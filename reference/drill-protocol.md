# Drill Protocol

Standalone reference — same content as the protocol section of `CLAUDE.md`,
for review before a drill without loading the whole file.

## Steps

1. You get a system spec that is DELIBERATELY INCOMPLETE — vague on auth,
   data sensitivity, deployment model, and trust relationships.
2. The interviewer (Claude) does not volunteer missing details. Only what
   you explicitly ask gets answered.
3. Hard time box, default 25 minutes. Start is announced; you say "done"
   when finished.
4. You produce, in order:
   1. Trust boundaries
   2. Assets
   3. STRIDE pass
   4. Ranked top 3 threats, with justification
   5. Mitigations, each with a stated tradeoff
5. You are graded on the rubric below, 1-5 each, 30 total.
6. Session closes with: "What a strong FAANG candidate would have said
   differently."
7. Every CRITICAL miss and repeated weakness gets appended to
   `interview-bank/weak-spots.md`.

## Rubric (1-5 each, /30)

| Dimension | What it measures |
|---|---|
| Clarifying questions | What a strong candidate would have asked that you missed |
| Trust boundary mapping | Correct, complete, drawn *before* threats |
| Universals coverage | Any CRITICAL misses from `reference/universals-checklist.md` |
| Threat ranking quality | Prioritized top threats with justification, not a raw list |
| Tradeoff articulation | Every control has a stated cost |
| Communication | Structured (SALT-shaped) vs rambling |

## Integrated practice (from 01-intermediate onward)

After the threat model, you get the real code or IaC for the system. Flag
what you'd catch in review, and state whether your threat model held up
against the actual implementation.
