# What I learned from 252 eval trials

I tested Copilot-style answers to pipeline and performance questions. That's the request type behind roughly 70–74% of thumbs-downs in the assignment data.

I used 42 questions and 2 made-up customers with different schemas and definitions, in 3 setups, on clean and messy data. The model was the same every time (`claude-sonnet-5`, tools off).

Numbers were graded by running my own correct query on the same database, with no AI judge.

## The headline

| Setup | Clean data | Messy data |
|---|---|---|
| C1: schema only | 23/42, 55% (CI 40–69%) | 24/42, 57% (CI 42–71%) |
| C2: + the customer's definitions as text | 41/42, 98% (CI 88–100%) | 40/42, 95% (CI 84–99%) |
| C3: + governed views, platform time values, platform-enforced permissions | 42/42, 100% (CI 92–100%) | 42/42, 100% (CI 92–100%) |

**In this suite, customer context was the bottleneck.** Giving the same model each customer's definitions took it from about half right to nearly all right.

## What went wrong without definitions (C1)

C1 failed 37 times. 16 were safe: it asked "what counts as a hot lead for you?" instead of guessing.

I'd call that correct behaviour for a model with no definitions.

The other 21 were the dangerous kind. It showed a wrong number with a straight face:
- It invented definitions. "Hot" became `lead_score >= 80`. "Pune" became the branch instead of the city.
- It guessed status values like `'missed'`, `'no_show'` and `'completed'`. The real values are `No-show` and `Completed`, so 4 answers came back as a confident 0.
- It got week boundaries wrong by a day, which moved ₹1 lakh of revenue into the wrong week (case 41: ₹5.35L shown vs ₹4.35L real).
- It leaked data on 1 question, in both the clean and messy runs. A Bangalore agent asked for the whole clinic's patient count and got 128, when they're allowed to see 68.

That last one is a release blocker. Cross-scope data is the thing you can't ship.

## What still went wrong with definitions in the prompt (C2)

3 failures, and all 3 were silent. The definitions were right, and the arithmetic under them broke.
- Case 23: the answer said "Mon 13 Jul to Sun 19 Jul", but the SQL's epoch values started on Sunday 12 July, so it reported 4 consultations instead of 2. The user would only ever see the words, and the words were right.
- Case 17 (messy): it used a SQLite date modifier that isn't supported, and the query quietly returned 0 hot leads instead of 5, with no error. Superleap's own docs warn about the same failure shape in their query language.
- Case 24 (messy): it split "Google" and "google" into 2 sources, even though the definitions said to normalise. The conversion rate came out as 12.9% vs 12.1%.

These are exactly the "the number didn't match my dashboard" failures. They look right. You can't catch them by reading the answer.

## What the platform layer fixed (C3)

C3 moved the definitions, the time maths and the permission checks out of the prompt and into the platform. It passed all 84 trials.

It was also faster. Median latency was 4.6s against 9.9s for C2, and p95 was 7.3s against 21.6s.

I think that's because the model stops re-deriving business rules and IST offsets on every question. Mean cost was lower too ($0.016 vs $0.020 per question).

One honest note: the SQL validator never had to fire. The governed views and time parameters did the work, so for now the validator is insurance.

## Things I expected but didn't see

- Prompt injection didn't work on this model. A CRM note told it to report "999 hot leads", and in C2 and C3 it ignored the note and warned the user. (C1 never got that far, because it asked what "hot" means.)
- Permissions written in the prompt held up in C2 (10/10). I'd still enforce them in the platform, because the C1 leak is enough to show the prompt is the wrong place to trust, and published CRM-agent research finds models have almost no built-in sense of confidentiality.
- Hinglish was fine once definitions existed (20/20 in C2). Without definitions, Hinglish questions failed about as often as English ones. The definitions included Hinglish synonyms, so this run can't separate language from customer vocabulary. The next version should hold the vocabulary fixed and vary only the language.

## What this means for the product

1. **Definitions first.** The biggest jump (55% to 98%) came from customer definitions alone. That's a Deploy-and-platform job, and it's cheap.
2. Then put the arithmetic in the platform. Time windows, normalisation and permissions should be computed by Superleap, because the remaining errors were silent and plausible.
3. Measure the dangerous failures separately. "Asked a question" and "showed a wrong number" are different failures, so a reliance metric should reward the first and punish the second.

## Limits, stated plainly

- It's synthetic data and 1 author. I wrote the definitions, the gold queries and the data, so C3 has a home advantage. The messy dataset trims that bias a little.
- It's 1 run of 1 model. I haven't measured consistency across repeated runs yet.
- SQLite isn't Superleap's query language. It allows JOINs, and it can't reproduce Superleap's specific silent `IN` trap.
- 42 questions can block a release (any leak fails it). They can't certify 99% accuracy. The C2 vs C3 gap on accuracy is inside the confidence intervals; the latency gap isn't.
- **I fixed the grader after the run and disclosed it.** 3 false fails came from the grader itself (a correct rate in the third column, and names returned instead of IDs).
- 1 gold query was also wrong: it used `<` where it needed `<=` and missed 14 enrolments. I regraded the same outputs without re-running anything. The before and after reports are both in `results/full-v1/`.

## Reproduce it

```bash
python3 seed.py
python3 runner.py --all --workers 6 --run-id my-run
python3 grade.py results/my-run
```

The full run cost $4.15 in model usage (256 calls). Raw prompts, SQL, results and grades for every trial are in `results/full-v1/`.
