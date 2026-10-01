# Superleap take-home: Product Manager, Core Platform (Copilot)

Prabhanjan Kulkarni · October 2026

This repo holds the evidence behind my submission: the eval, the key prompts I used, and the assignment brief as Superleap sent it. **The submission document is the place to start**, and everything here opens without signing in.

| What | Where |
|---|---|
| Submission document (Parts A to C) | [Notion](https://app.notion.com/p/Superleap-Copilot-Diagnosis-Evals-and-a-Two-year-Bet-3ec05934ca76800a9d16e951fa2f39e4) |
| Prototype | [superleap-prototype.vercel.app](https://superleap-prototype.vercel.app) |
| Loom walkthrough (5 minutes) | [Watch on Loom](https://www.loom.com/share/39a7c9ee30af4426b62bfec17b7479c8) |
| Eval report, code and every trial | [evals/](evals/) |
| Key prompts and tools | [prabhnjan-prompt.md](prabhnjan-prompt.md) |
| Sources for every outside claim | [SOURCES.md](SOURCES.md) |
| The assignment brief, as received | [superleap-pm-assignment-brief.pdf](superleap-pm-assignment-brief.pdf) |

## The short version

- **Part A:** Copilot isn't relied on yet. Managers use it for weekly reviews, the frontline has mostly forgotten it, and the main reason is that people stopped trusting its numbers.
- **Part B:** an eval for pipeline questions. With the same model, answers went from 55% right with only the schema, to 98% with the customer's definitions, to 100% once time windows and permissions ran in the platform. That's on synthetic data, so it shows which layer removes which error.
- **Part C:** a 2-year bet on 1 engine that brings the right help to the moment of work. It reads each customer's definitions and rules, recommends a next step, allows only actions that pass policy and human review, and is measured against the existing workflow.
- **Part D:** the Loom, walking through all of it.

## The evals

The [evals/](evals/) folder follows the usual shape for published evals:
- [EVAL-REPORT.md](evals/EVAL-REPORT.md): purpose, system under test, test set, grading, results with confidence intervals, error analysis, grader audit, limits.
- [CASES.md](evals/CASES.md): all 42 questions and how each setup did.
- `results/full-v1/`: 1 line per trial, raw and graded, plus the generated report.
- The code to rebuild the data, rerun the model and regrade.

## The prototype

A clickable prototype on synthetic data, hosted on Vercel. Brightpath Academy is a made-up customer. The Copilot chat is scripted, and no message is ever sent.

## Copyright

© 2026 Prabhanjan Kulkarni. All rights reserved. Shared for review as part of a job application to Superleap. No copying, reuse or derivative work without my written permission. The assignment brief belongs to Superleap. Details in [LICENSE](LICENSE).
