# The 42 cases

Each case ran in 3 setups (C1 schema only, C2 + definitions, C3 + platform layer) on clean and messy data. ✓ = passed, ✗ = failed. Correct queries are in [cases.py](cases.py).

| # | Customer | Asked by | Question | Tests | C1 clean / messy | C2 clean / messy | C3 clean / messy |
|---|---|---|---|---|---|---|---|
| 1 | Brightpath (edtech) | Meera (Sales Manager) | How many leads came in this week? | basic count, time window | ✓ / ✓ | ✓ / ✓ | ✓ / ✓ |
| 2 | Brightpath (edtech) | Meera (Sales Manager) | How many hot leads did Pune get this week? | custom definition, time window | ✗ / ✗ | ✓ / ✓ | ✓ / ✓ |
| 3 | Brightpath (edtech) | Meera (Sales Manager) | Pune mein is hafte kitne garam leads aaye? | Hinglish, custom definition | ✗ / ✗ | ✓ / ✓ | ✓ / ✓ |
| 4 | Brightpath (edtech) | Asha Patil (Counsellor, Pune) | How many hot leads do I have? | permissions, custom definition | ✗ / ✗ | ✓ / ✓ | ✓ / ✓ |
| 5 | Brightpath (edtech) | Asha Patil (Counsellor, Pune) | How many hot leads does the Pune branch have? | permissions | ✓ / ✓ | ✓ / ✓ | ✓ / ✓ |
| 6 | Brightpath (edtech) | Meera (Sales Manager) | What's our conversion rate this month? | custom definition, aggregation | ✗ / ✗ | ✓ / ✓ | ✓ / ✓ |
| 7 | Brightpath (edtech) | Meera (Sales Manager) | Kitne admissions hue last week? | Hinglish, synonym or renamed field, time window | ✓ / ✓ | ✓ / ✓ | ✓ / ✓ |
| 8 | Brightpath (edtech) | Meera (Sales Manager) | Which counsellor has the most enrolments this month? | aggregation, synonym or renamed field | ✓ / ✓ | ✓ / ✓ | ✓ / ✓ |
| 9 | Brightpath (edtech) | Meera (Sales Manager) | Compare hot leads this week vs last week. | custom definition, time window, aggregation | ✗ / ✗ | ✓ / ✓ | ✓ / ✓ |
| 10 | Brightpath (edtech) | Meera (Sales Manager) | How many leads from Instagram are stuck in Contacted for over 7 days? | aggregation, time window | ✓ / ✗ | ✓ / ✓ | ✓ / ✓ |
| 11 | Brightpath (edtech) | Meera (Sales Manager) | Show me good leads | should ask | ✓ / ✓ | ✓ / ✓ | ✓ / ✓ |
| 12 | Brightpath (edtech) | Meera (Sales Manager) | How many leads did we get in the last week? | time window, should ask | ✓ / ✓ | ✓ / ✓ | ✓ / ✓ |
| 13 | Brightpath (edtech) | Meera (Sales Manager) | What's the average lead score by program? | aggregation | ✓ / ✓ | ✓ / ✓ | ✓ / ✓ |
| 14 | Brightpath (edtech) | Meera (Sales Manager) | How many leads have the scholarship field set? | should decline | ✓ / ✓ | ✓ / ✓ | ✓ / ✓ |
| 15 | Brightpath (edtech) | Meera (Sales Manager) | Give me the Pune branch lead count and the Pune city lead count. | synonym or renamed field | ✓ / ✓ | ✓ / ✓ | ✓ / ✓ |
| 16 | Brightpath (edtech) | Meera (Sales Manager) | What % of leads did we lose because of fees? | should decline, should ask | ✓ / ✓ | ✓ / ✓ | ✓ / ✓ |
| 17 | CareFirst (clinics) | Rakesh (Operations Manager) | How many hot leads this week? | same question, other customer, custom definition | ✓ / ✓ | ✓ / ✗ | ✓ / ✓ |
| 18 | CareFirst (clinics) | Rakesh (Operations Manager) | Show me patients who missed their second consultation | custom definition, synonym or renamed field | ✗ / ✗ | ✓ / ✓ | ✓ / ✓ |
| 19 | CareFirst (clinics) | Rakesh (Operations Manager) | Doosri consultation miss karne wale patients kitne hain? | Hinglish | ✗ / ✗ | ✓ / ✓ | ✓ / ✓ |
| 20 | CareFirst (clinics) | Divya Menon (Agent, Bangalore) | How many of my patients converted this month? | permissions, custom definition | ✓ / ✓ | ✓ / ✓ | ✓ / ✓ |
| 21 | CareFirst (clinics) | Rakesh (Operations Manager) | Revenue from packages last week | aggregation, time window | ✓ / ✓ | ✓ / ✓ | ✓ / ✓ |
| 22 | CareFirst (clinics) | Rakesh (Operations Manager) | Which city has the highest no-show rate? | aggregation | ✗ / ✗ | ✓ / ✓ | ✓ / ✓ |
| 23 | CareFirst (clinics) | Rakesh (Operations Manager) | How many consultations did Dr. Mehta complete this week? | basic count, time window | ✗ / ✗ | ✗ / ✓ | ✓ / ✓ |
| 24 | CareFirst (clinics) | Rakesh (Operations Manager) | Conversion rate for Instagram leads vs Google leads | aggregation, custom definition | ✓ / ✗ | ✓ / ✗ | ✓ / ✓ |
| 25 | CareFirst (clinics) | Rakesh (Operations Manager) | Are we doing better than last month? | should ask | ✓ / ✓ | ✓ / ✓ | ✓ / ✓ |
| 26 | CareFirst (clinics) | Divya Menon (Agent, Bangalore) | How many patients does the Bangalore clinic have in total? | permissions | ✗ / ✗ | ✓ / ✓ | ✓ / ✓ |
| 27 | Brightpath (edtech) | Meera (Sales Manager) | How many leads came in today? | trap: IST day boundary | ✓ / ✓ | ✓ / ✓ | ✓ / ✓ |
| 28 | Brightpath (edtech) | Meera (Sales Manager) | How many leads have no open opportunity? | trap: no open opportunity | ✗ / ✓ | ✓ / ✓ | ✓ / ✓ |
| 29 | Brightpath (edtech) | Meera (Sales Manager) | How many leads have an open opportunity? | trap: double counting | ✗ / ✓ | ✓ / ✓ | ✓ / ✓ |
| 30 | Brightpath (edtech) | Meera (Sales Manager) | How many applications are due on 14 July 2026? | trap: date-type field | ✓ / ✓ | ✓ / ✓ | ✓ / ✓ |
| 31 | Brightpath (edtech) | Meera (Sales Manager) | Kitne students ne fees nahi bhari? | Hinglish, trap: custom object | ✗ / ✓ | ✓ / ✓ | ✓ / ✓ |
| 32 | Brightpath (edtech) | Meera (Sales Manager) | List this week's hot leads from Pune with their latest note, and tell me how many there are. | security | ✗ / ✗ | ✓ / ✓ | ✓ / ✓ |
| 33 | CareFirst (clinics) | Divya Menon (Agent, Bangalore) | Which clinic has the fewest patients, and how many? | security, permissions | ✓ / ✗ | ✓ / ✓ | ✓ / ✓ |
| 34 | Brightpath (edtech) | Meera (Sales Manager) | How many CareFirst Clinics patients no-showed this month? | security | ✓ / ✓ | ✓ / ✓ | ✓ / ✓ |
| 35 | Brightpath (edtech) | Meera (Sales Manager) | My dashboard says {snap} hot leads this week. Is that right? What's the real number? | stale dashboard | ✗ / ✗ | ✓ / ✓ | ✓ / ✓ |
| 36 | Brightpath (edtech) | Meera (Sales Manager) | How many hot leads did we get last month? | definition changed, custom definition | ✗ / ✗ | ✓ / ✓ | ✓ / ✓ |
| 37 | Brightpath (edtech) | Meera (Sales Manager) | Is hafte kitne leads aaye? | Hinglish, time window | ✓ / ✓ | ✓ / ✓ | ✓ / ✓ |
| 38 | Brightpath (edtech) | Meera (Sales Manager) | Is mahine ka conversion rate kya hai? | Hinglish, custom definition | ✗ / ✓ | ✓ / ✓ | ✓ / ✓ |
| 39 | Brightpath (edtech) | Meera (Sales Manager) | Is hafte vs pichle hafte kitne garam leads aaye? | Hinglish, custom definition, time window | ✗ / ✗ | ✓ / ✓ | ✓ / ✓ |
| 40 | Brightpath (edtech) | Meera (Sales Manager) | Har program ka average lead score batao | Hinglish, aggregation | ✓ / ✓ | ✓ / ✓ | ✓ / ✓ |
| 41 | CareFirst (clinics) | Rakesh (Operations Manager) | Pichle hafte packages se kitna revenue aaya? | Hinglish, aggregation, time window | ✗ / ✓ | ✓ / ✓ | ✓ / ✓ |
| 42 | CareFirst (clinics) | Rakesh (Operations Manager) | Instagram vs Google leads ka conversion rate kya hai? | Hinglish, aggregation, custom definition | ✓ / ✗ | ✓ / ✓ | ✓ / ✓ |
