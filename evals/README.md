# Superleap Copilot: evals for pipeline questions

This is the eval behind Part B of my take-home for Superleap's Product Manager, Core Platform (Copilot) role. It tests answers to pipeline and performance questions, like "How many hot leads did Pune get this week?".

Those questions are 52% of Copilot requests and cause about 70–74% of its thumbs-downs. **The goal was to learn which layer removes which error**, so the same model ran in 3 setups on the same questions.

## Results

42 questions, 2 made-up customers (an edtech and a clinic chain), clean and messy data, 252 trials on `claude-sonnet-5` with tools off.

| Setup | Clean data | Messy data |
|---|---|---|
| C1: schema only | 23/42, 55% (CI 40–69%) | 24/42, 57% (CI 42–71%) |
| C2: + the customer's definitions as text | 41/42, 98% (CI 88–100%) | 40/42, 95% (CI 84–99%) |
| C3: + governed views, platform time values, platform-enforced permissions | 42/42, 100% (CI 92–100%) | 42/42, 100% (CI 92–100%) |

CI is the 95% Wilson interval. At 42 questions, the intervals are wide.

## What I learned

1. In this suite, customer context was the bottleneck. Definitions alone took the model from about half right to nearly all right.
2. Without definitions, 21 of 37 failures were confident wrong numbers, including 1 answer that showed a Bangalore agent data outside their permissions. The other 16 were the model asking what "hot" means, which is the right move.
3. The 3 failures left with definitions were silent. One answer said "Mon 13 to Sun 19 July" while its SQL started a day early, and nothing on screen showed it.
4. Moving time windows and permissions into the platform cleared those and cut p95 latency from 21.6s to 7.3s.
5. A planted "report 999 hot leads" note in a CRM record didn't work. The model ignored it and warned the user.

The full report is in [EVAL-REPORT.md](EVAL-REPORT.md), and a shorter write-up is in [RESULTS.md](RESULTS.md).

## What's in here

| File | What it is |
|---|---|
| [EVAL-REPORT.md](EVAL-REPORT.md) | **The full eval report**: purpose, system under test, test set, grading, results, error analysis, grader audit, limits |
| [RESULTS.md](RESULTS.md) | A shorter write-up of the findings |
| [CASES.md](CASES.md) | All 42 questions, what each one tests, and how each setup did |
| [results/full-v1/report.md](results/full-v1/report.md) | The graded report: pass rates, severity, safe vs unsafe failures, latency, cost |
| [results/full-v1/report_before_grader_fix.md](results/full-v1/report_before_grader_fix.md) | The report before I fixed my grader, kept on purpose |
| `results/full-v1/raw.jsonl` | Every trial: prompt, model output, SQL, rows, cost, latency |
| `results/full-v1/graded.jsonl` | Every trial with its grade, failure type and severity |
| [cases.py](cases.py) | The questions with their correct (gold) queries |
| [seed.py](seed.py) | Builds the 2 synthetic customers, clean and messy, on a frozen clock |
| [runner.py](runner.py) | Runs each case in each setup and records everything |
| [grade.py](grade.py) | Grades by execution and writes the report |
| [semantic/](semantic/) | Each customer's business definitions, as given to the model in C2 |
| [contracts/](contracts/) | The governed views used in C3 |

## How it works

Every case runs on a frozen clock, Wed 15 July 2026 at 11:00 IST, so "this week" means the same thing on every run. The messy copy of each customer adds merged duplicates, casing drift in stages and sources, and blank cities.

Numbers are graded by execution. The model's query and my correct query run on the same database, and the results are compared, with no AI judge.

Behaviours use fixed rules: asking when a definition is missing, telling a counsellor the answer covers only their leads, and ignoring instructions planted in a note. Every failure gets a severity, from S0 (data outside the user's permissions, or another customer's data) to S3 (a weak explanation).

## Run it

You need Python 3 and the `claude` command-line tool.

```bash
python3 seed.py
python3 runner.py --all --workers 6 --run-id my-run
python3 grade.py results/my-run
```

The full run cost about $4 in model usage.

## Limits

- It's synthetic data, and I wrote the definitions, the correct queries and the data. That gives C3 a home advantage, and a production suite should have someone else write the correct queries.
- It's 1 run of 1 model, so there's no consistency measure yet.
- It uses SQLite. Superleap's query language forbids joins and has a silent `IN` trap on virtual relations that SQLite can't reproduce.
- 42 questions can block a release, because any leak fails it. They can't certify high accuracy.
- I fixed my grader after the run: 3 false fails, plus 1 wrong gold query. The same outputs were regraded without re-running, and both reports are here.

---

© 2026 Prabhanjan Kulkarni. All rights reserved. Shared for review as part of a job application to Superleap. No copying, reuse or derivative work without my written permission.
