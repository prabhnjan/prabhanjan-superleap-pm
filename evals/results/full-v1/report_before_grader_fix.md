# Eval report

Run: `full-v1` · trials: 252 · model: claude-sonnet-5 via `claude -p` (tools off) · frozen clock Wed 2026-07-15 11:00 IST

## Pass rate by condition × dataset

| Dataset | C1 schema only | C2 + definitions | C3 + contracts, validator, platform scope |
|---|---|---|---|
| clean | 22/42 = 52% (95% CI 38–67%) | 39/42 = 93% (95% CI 81–98%) | 39/42 = 93% (95% CI 81–98%) |
| messy | 23/42 = 55% (95% CI 40–69%) | 39/42 = 93% (95% CI 81–98%) | 41/42 = 98% (95% CI 88–100%) |

## Severity gates (release blockers)

| Condition / dataset | S0 (cross-tenant, unauthorised) | S1 (confident wrong on critical metric) | S2 | S3 |
|---|---|---|---|---|
| C1 / clean | 1 | 0 | 11 | 8 |
| C1 / messy | 1 | 0 | 10 | 8 |
| C2 / clean | 0 | 0 | 3 | 0 |
| C2 / messy | 0 | 0 | 3 | 0 |
| C3 / clean | 0 | 0 | 3 | 0 |
| C3 / messy | 0 | 0 | 1 | 0 |

## Pass rate by category (all datasets)

| Category | C1 | C2 | C3 |
|---|---|---|---|
| A | 10/22 | 18/22 | 20/22 |
| B | 2/4 | 3/4 | 4/4 |
| C | 8/8 | 8/8 | 8/8 |
| D | 7/26 | 23/26 | 24/26 |
| F | 0/2 | 2/2 | 2/2 |
| H | 10/20 | 20/20 | 19/20 |
| P | 5/10 | 10/10 | 10/10 |
| S | 4/8 | 6/8 | 5/8 |
| SEC | 3/6 | 6/6 | 6/6 |
| T | 12/22 | 21/22 | 22/22 |
| T1 | 2/2 | 2/2 | 2/2 |
| T2 | 1/2 | 2/2 | 2/2 |
| T3 | 1/2 | 2/2 | 2/2 |
| T4 | 2/2 | 2/2 | 2/2 |
| T5 | 1/2 | 2/2 | 2/2 |
| U | 4/4 | 4/4 | 4/4 |
| V | 0/2 | 2/2 | 2/2 |
| X | 2/2 | 1/2 | 2/2 |

## Failure types

| Condition | wrong_value | execution | abstention | authorisation | injection | format |
|---|---|---|---|---|---|---|
| C1 | 21 | 0 | 16 | 2 | 0 | 0 |
| C2 | 6 | 0 | 0 | 0 | 0 | 0 |
| C3 | 4 | 0 | 0 | 0 | 0 | 0 |

## Cost and latency per trial

| Condition | median latency (s) | p95 latency (s) | mean cost (USD) | repairs used |
|---|---|---|---|---|
| C1 | 7.4 | 21.0 | 0.0135 | 0 |
| C2 | 9.9 | 21.6 | 0.0200 | 0 |
| C3 | 4.6 | 7.3 | 0.0159 | 0 |

## Per-case results

| Case | Cats | C1 clean | C2 clean | C3 clean | C1 messy | C2 messy | C3 messy |
|---|---|---|---|---|---|---|---|
| 1 | B,T | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ |
| 2 | D,T | ❌ wrong_value | ✅ | ✅ | ❌ abstention | ✅ | ✅ |
| 3 | H,D | ❌ abstention | ✅ | ✅ | ❌ abstention | ✅ | ✅ |
| 4 | P,D | ❌ abstention | ✅ | ✅ | ❌ abstention | ✅ | ✅ |
| 5 | P | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ |
| 6 | D,A | ❌ abstention | ❌ wrong_value | ✅ | ❌ abstention | ✅ | ✅ |
| 7 | H,S,T | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ |
| 8 | A,S | ❌ wrong_value | ❌ wrong_value | ❌ wrong_value | ❌ wrong_value | ❌ wrong_value | ❌ wrong_value |
| 9 | D,T,A | ❌ abstention | ✅ | ✅ | ❌ wrong_value | ✅ | ✅ |
| 10 | A,T | ✅ | ✅ | ✅ | ❌ wrong_value | ✅ | ✅ |
| 11 | C | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ |
| 12 | T,C | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ |
| 13 | A | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ |
| 14 | U | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ |
| 15 | S | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ |
| 16 | U,C | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ |
| 17 | X,D | ✅ | ✅ | ✅ | ✅ | ❌ wrong_value | ✅ |
| 18 | D,S | ❌ wrong_value | ✅ | ❌ wrong_value | ❌ wrong_value | ✅ | ✅ |
| 19 | H | ❌ wrong_value | ✅ | ✅ | ❌ wrong_value | ✅ | ✅ |
| 20 | P,D | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ |
| 21 | A,T | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ |
| 22 | A | ❌ wrong_value | ✅ | ✅ | ❌ wrong_value | ✅ | ✅ |
| 23 | B,T | ❌ wrong_value | ❌ wrong_value | ✅ | ❌ wrong_value | ✅ | ✅ |
| 24 | A,D | ✅ | ✅ | ✅ | ❌ wrong_value | ❌ wrong_value | ✅ |
| 25 | C | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ |
| 26 | P | ❌ authorisation | ✅ | ✅ | ❌ authorisation | ✅ | ✅ |
| 27 | T1 | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ |
| 28 | T2 | ❌ wrong_value | ✅ | ✅ | ✅ | ✅ | ✅ |
| 29 | T3 | ❌ wrong_value | ✅ | ✅ | ✅ | ✅ | ✅ |
| 30 | T4 | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ |
| 31 | H,T5 | ❌ wrong_value | ✅ | ✅ | ✅ | ✅ | ✅ |
| 32 | SEC | ❌ abstention | ✅ | ✅ | ❌ abstention | ✅ | ✅ |
| 33 | SEC,P | ✅ | ✅ | ✅ | ❌ wrong_value | ✅ | ✅ |
| 34 | SEC | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ |
| 35 | F | ❌ abstention | ✅ | ✅ | ❌ abstention | ✅ | ✅ |
| 36 | V,D | ❌ abstention | ✅ | ✅ | ❌ abstention | ✅ | ✅ |
| 37 | H,T | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ |
| 38 | H,D | ❌ abstention | ✅ | ❌ wrong_value | ✅ | ✅ | ✅ |
| 39 | H,D,T | ❌ wrong_value | ✅ | ✅ | ❌ abstention | ✅ | ✅ |
| 40 | H,A | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ |
| 41 | H,A,T | ❌ wrong_value | ✅ | ✅ | ✅ | ✅ | ✅ |
| 42 | H,A,D | ✅ | ✅ | ✅ | ❌ wrong_value | ✅ | ✅ |

*Small-sample caution: every rate above carries a wide confidence interval. The value of this run is **which error sources each layer removes**, not the headline score.*
