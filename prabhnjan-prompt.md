# Key prompts

Prabhanjan Kulkarni · Superleap take-home, Product Manager, Core Platform (Copilot)

The assignment asks for "a short log of the tools and key prompts you used". These are the 10 prompts that shaped the work. Most of them combine a first prompt and its follow-ups into one, tidied for reading. The full exchange-by-exchange log stays in my working repo.

**Tools**
- **Claude Code** (Claude Opus 5.5) for research, the site study, the eval and the writing.
- **Codex** (GPT-5.6) as a second, sceptical reviewer, and to build much of the prototype.
- Every review claim was checked against the source before anything changed.

| # | Area | Tool | Technique |
|---|---|---|---|
| 1 | Research: framing the problem | Claude Code | Role, numbered tasks, assumptions stated up front |
| 2 | Research: deep-research brief | Claude Code, web search | Researcher brief: scope, fields per source, output table, citation rules |
| 3 | Superleap site and docs study | Claude Code | Crawl, keep raw text, label first-party claims |
| 4 | Building and running the eval | Claude Code | Controlled experiment: one model, setups that differ by one layer |
| 5 | Auditing the grader | Claude Code | Verify the verifier before trusting the score |
| 6 | Auditing the finished assignment | Codex, then Claude Code | Adversarial review, then claim-by-claim validation |
| 7 | Prototype: functional | Codex, Claude Code | Spec from the user's job and the bet's rules |
| 8 | Prototype: design | Codex, Claude Code | Design constraints, palette tokens, layout rules |
| 9 | Prototype: experience | Codex, Claude Code | Walk the story as the user; test value, discoverability and trust |
| 10 | Prototype: guided tour | Claude Code | Restore a removed feature on the new build, scoped so the core app is untouched |

---

## 1. Research: framing the problem

*Technique: a role, numbered tasks, and a rule to state assumptions before using them. The last task asks the model to write the research prompts it can't answer itself.*

```
Act as an experienced product manager who has fixed low adoption of an AI
feature inside a B2B product before.

Read the attached assignment brief and its data.

1. Analyse the situation: what the numbers say, what they don't, and where
   they disagree with each other.
2. State every assumption you need, and mark how each one could be checked.
3. Break down what is being asked: the explicit asks, the implicit ones, and
   what isn't asked, so I don't spend pages on it.
4. Propose a strategy for each part.
5. Decide whether market research would change any decision. If it would,
   write the deep-research prompts that would answer it, so I can run them
   separately.

Keep facts, derived numbers and hypotheses apart, and label each one.
```

## 2. Research: deep-research brief

*Technique: a researcher brief. It fixes the scope, the fields to report for each source, the output shape, and how to cite. This one fed the eval design in Part B.*

```
Research studies and benchmarks (2023–2026) that measure LLM accuracy on
natural-language-to-SQL or analytics questions over business data, with and
without a semantic layer, knowledge graph, metric definitions or glossary.

Include BIRD (with external evidence), Spider 2.0, data.world's
knowledge-graph study, dbt Labs semantic layer benchmarks, AtScale and Cube
reports, and academic work on ambiguity and clarifying questions in
text-to-SQL.

For each source, report:
- the setup and the models used,
- accuracy with and without the added context,
- the error types (wrong definitions, date handling, joins, permissions),
- whether a vendor sponsored it.

Then answer: how much of the error comes from missing business context and
how much from model capability? What does a good eval look like when every
customer has a different schema?

Cite every source with a URL and date. Separate peer-reviewed work from
vendor claims.
```

## 3. Superleap site and docs study

*Technique: a crawl with a fixed output structure. Raw text is saved, so any claim can be checked later, and first-party marketing is labelled as such.*

```
Study everything public about Superleap, so later work uses their real
product and words: the website, each product, testimonials, the knowledge
base, the developer docs and the glossary.

1. Use the sitemap to find every page, and save the raw text of each one
   (pages, docs, blog) in a folder I can search.
2. Build a knowledge base, one file per topic: company, product
   architecture, agents, the AI assistant, voice, deployment, integrations,
   data model, customers, industries, security, sales and pricing, glossary.
3. Mark each claim as first-party marketing, documentation or third-party
   evidence.
4. End with what this changes in my answer: anything the brief proposes
   that Superleap already sells, any doc that explains a failure in the
   data, and the terms I should use.
```

## 4. Building and running the eval

*Technique: a controlled experiment. One model and one question set, with setups that each add one layer, so a change in score can be traced to that layer.*

```
Build an eval for pipeline and performance questions: they are 52% of
requests and carry the highest thumbs-down rate.

Data:
- 2 synthetic customers with different CRM setups (an edtech and a clinic
  chain): their own objects, stages, field names and metric definitions.
- A clean and a messy version of each, with missing and inconsistent values.
- Freeze the clock, so "this week" means the same thing in every run.

Test set:
- About 40 questions, in English and Hinglish, covering
  customer-specific terms, date windows, joins, and requests a user's role
  shouldn't see.
- Write a gold SQL query for each, and run it to get the expected answer.

Setups, same model each time:
- A: schema only.
- B: schema plus the customer's definitions.
- C: the model chooses the metric; the platform applies definitions, dates
  and permissions.

Grading:
- Run every generated query and compare results, not text.
- Grade wrong numbers, scope leaks and silent wrong windows separately.
- Run every question in every setup on both datasets. Report confidence
  intervals.

Keep every raw output. Write up what we learned; it matters more than the
score.
```

## 5. Auditing the grader

*Technique: check the checker. Before the score was used anywhere, every failure was re-read by hand.*

```
Before we trust these results, audit the grader and the gold answers.

1. Re-read every failed trial by hand. For each one, is the model wrong,
   the grader wrong, or the gold query wrong?
2. Fix only proven grader or gold errors. Keep the original grades next to
   the corrected ones.
3. Disclose every fix and every limit in the report: synthetic data,
   SQLite, one model, small sample.
4. Then report the results in the usual shape for published evals: purpose,
   system under test, test set, grading, results with intervals, error
   analysis, grader audit, limits.
```

## 6. Auditing the finished assignment

*Technique: an adversarial review by a second model, then a validation pass that treats the review as claims to verify rather than instructions.*

**6a. The review (Codex)**

```
You are a sceptical founder and hiring manager at Superleap, reviewing this
take-home for a Product Manager, Core Platform role. Your job is to find the
reasons not to hire.

Read the brief and the full submission. For each part:
1. Does it answer what was asked, within the limits?
2. List every claim that isn't backed by the data, a source or the eval.
3. Find numbers that don't match the brief, or each other.
4. Find places where the plan is unfocused: too many bets, or 2 plans
   competing for one team.
5. Say what a founder would ask in the interview, and whether the
   submission can answer it.

Give a verdict from each lens, then a ranked fix list (P0, P1, P2). Quote
the exact line for each finding.
```

**6b. The validation (Claude Code)**

```
Codex has audited the submission. Don't accept any point at face value.

For each finding:
1. Check it against the brief, the eval files and the research.
2. Give a verdict: accepted, partly accepted, deferred or rejected, with
   the evidence.
3. Where you accept it, make the smallest change that fixes it. Keep the
   old text in the redline.
4. Note where Codex's fix conflicts with another constraint, such as the
   6-page limit, and choose.

Then confirm that both sets of judgement calls survive: Codex's and yours.
```

## 7. Prototype: functional

*Technique: start from one user's job and the rules of the bet, then define every state the screen needs. Most of the build came from Codex, working from this brief.*

```
Build a clickable prototype of the Part C bet for one real workflow: a
counsellor's follow-up day at a sample edtech customer.

It has to show a platform capability, not a feature for one industry. The
same decision must reach the dashboard, the record and the Copilot panel.

Data:
- 53 synthetic weekly leads, with uneven stages and sources.
- Week and Month views that stay consistent with each other.

Home is a decision desk: only real exceptions (an overdue promise, a consent
block), 1 item per person, never the full task list.

One complete story: a lead asked for a payment plan and a timetable, the
counsellor promised them by 10:00, and nothing was sent. Show the source,
the suggested step, the consent check and the human review. Nothing is sent
from the prototype.

The Copilot chat is scripted, and it must say so. Every number on screen
must reconcile with the records behind it.
```

## 8. Prototype: design

*Technique: hard constraints. A palette given as tokens, layout rules, and a list of things the screen must not do.*

```
Redesign the prototype. I design minimally.

- Use this palette consistently (tropical rain forest, 50 to 950):
  #effaf5 #d8f3e6 #b4e6d0 #82d3b4 #4fb893 #2d9c79 #1c775c #18644f #155040
  #124236 #09251f.
- Screens run edge to edge, not boxed in the middle.
- Lay information out so it can be skimmed: little empty space, no clutter.
- Use visuals where they say more than text: a funnel, trends, status.
- Detail opens in a side drawer, and Copilot opens as a side panel. Neither
  takes the user off the page.
- Fix copy and grammar everywhere. Use the customer's own words for stages
  and fields.
```

## 9. Prototype: experience

*Technique: walk the story as the user, then test it against the 3 problems Part A found.*

```
Walk through the prototype as the counsellor, then as her manager.

1. Discoverability: the help has to come to the user. While she is on a
   record or moving between screens, a small suggestion appears in context
   and expands into the side drawer in 1 click. Check that she finds it
   without being told.
2. Trust: every suggestion shows where it came from, what was checked and
   what the user still decides. Blocked actions say why.
3. Value: the first screen answers "what needs me now?" in seconds.

Then check the whole thing against the bet: is it new yet simple,
and does it work as a platform capability for another industry, such as a
clinic chain? List every gap, give a verdict, and change the prototype only
where the gap is real.
```

## 10. Prototype: guided tour

*Technique: restore a feature from an older version, rebuilt for the current screens, with a hard limit on what may change. Reviewed locally before it went live.*

```
The prototype used to have a guided tour, and the rebuild dropped it. Add it
back.

- Keep the old pattern: a small card with the step count, dots, Back, Next,
  Finish, and "Explore on my own".
- Write new steps for the current screens, in the order of my Loom: the
  decision desk, the exceptions, the conversation pattern, the promise at
  risk, Copilot, the record, the consent review, and why it works for any
  customer.
- Each step opens the right screen and outlines one element. The card
  must never cover what it points at.
- Put it in its own file and leave the app code alone. It must not start by
  itself, so it doesn't interrupt a recording.
- Test every step, Back, Escape and phone width, and check that the Loom
  click path still works.
- Don't commit it. I'll review it locally first.
```

---

© 2026 Prabhanjan Kulkarni. All rights reserved. Shared for review as part of a job application to Superleap. No copying, reuse or derivative work without my written permission.
