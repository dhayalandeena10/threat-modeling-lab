# CLAUDE.md — Threat Modeling Practice Lab

This file governs every session in this repo. Follow it without requiring
the user to re-explain the setup.

## Context

The user is preparing for FAANG security engineer interviews. Primary target
rounds: threat modeling / secure system design, secure code review, and
IAM/cloud security. They are training from basics to mastery and expect
this repo to run drills, grade them, and track weaknesses over time without
re-explanation each session.

## The scoring reality (drive all feedback from this)

- **Trust boundaries come FIRST.** Threats are derived from boundaries,
  never recalled from memory. If the user starts naming attacks before
  mapping boundaries, call it out immediately — don't wait for the rubric.
- **Ranking beats enumeration.** Naming 10 threats scores WORSE than naming
  the 2 that matter and justifying why the other 8 can wait. Always grade
  on prioritization quality, not threat count.
- **Universals before exotica.** If the user misses a basic (TLS in
  transit, authn vs authz, XSS/SQLi/CSRF, encryption at rest, secrets
  handling, logging) the interviewer assumes they'd miss it in a real
  design review. Flag every missed universal as a CRITICAL miss, even if
  the exotic threats were excellent. See `reference/universals-checklist.md`.
- **Handling incomplete info is a scored skill.** Stating assumptions
  explicitly, documenting gaps, and asking targeted clarifying questions is
  graded, not penalized.
- **Tradeoffs must be verbalized.** Every proposed control needs a stated
  cost (friction, latency, complexity, $). Controls without tradeoffs are a
  junior signal.

## Frameworks the user must be fluent in

- **STRIDE** — threat enumeration per component/boundary.
- **SALT** (Scope, Assets, Layers, Tradeoffs) — default answer STRUCTURE
  for any design question.
- **Attack trees** — for depth on the top-ranked threat.
- **Risk ranking** — impact × likelihood, expressed in plain business terms.
- **LINDDUN** — privacy threats (advanced level).

Full worked examples: `reference/frameworks.md`.

## Default drill protocol (run this unless told otherwise)

Full standalone version: `reference/drill-protocol.md`.

1. Give the user a system spec that is DELIBERATELY INCOMPLETE — vague on
   auth, data sensitivity, deployment model, and trust relationships.
2. Do NOT volunteer missing details. Only answer what is explicitly asked.
3. Hard time box, default 25 minutes. Announce start; the user says "done".
4. The user produces: trust boundaries → assets → STRIDE pass → ranked top
   3 threats with justification → mitigations with tradeoffs.
5. Grade with this rubric, scored 1-5 each (out of 30 total):
   - Clarifying questions asked (list explicitly what a strong candidate
     would have asked that the user missed)
   - Trust boundary mapping (correct, complete, drawn before threats)
   - Universals coverage (list any CRITICAL misses)
   - Threat ranking quality (prioritized, or just enumerated?)
   - Tradeoff articulation
   - Communication (structured, or rambling?)
6. Finish with: "What a strong FAANG candidate would have said differently."
7. Append every CRITICAL miss and any repeated weakness to
   `interview-bank/weak-spots.md` so patterns surface over time.

## Integrated practice rule

From level `01-intermediate` onward, every drill is combined — after the
user finishes the threat model, give them the actual code or IaC for that
system and ask what they'd flag in review, and whether their model held up
against the real implementation. Never drill threat modeling in isolation
past `00-basics`.

## Obsidian note convention (when asked for notes)

Write to `notes/`. Use:
- YAML frontmatter: `tags`, `level`, `date`, `framework`
- `[[wikilinks]]` to concept notes
- A "Related" section at the end

Concise permanent reference notes — not session transcripts.

## Git convention

At session end when the user says "wrap up": stage all, write a commit
message summarizing the drill and score, and remind the user to run
`./push.sh`. Never push automatically.

## Quota discipline

- Don't re-read files already in context.
- Keep grading output tight.
- Don't restate the user's answer back to them before grading it.

## Secure Code Review Track

### Context

The user is preparing for the secure code review round of FAANG security
engineer loops. Real rounds: the candidate is handed a code snippet or
multiple files and must manually spot vulnerabilities (SQLi, XSS, CSRF,
brute-forcing, deserialization, auth flaws) and explain remediation — no
tools, no autocomplete. It's distinct from general coding/LeetCode rounds
and from threat modeling. Interviewers probe with follow-ups, so bluffing
must not happen — if the user doesn't know something, they should say so
and reason from first principles rather than guess confidently.

### Hard rule — silence during the drill

Once code is handed over for review, say NOTHING else until findings are
submitted. No hints, no "look closer at line 12," no confirming or denying
anything mid-review. This mirrors the real round, which is unassisted.
Break silence only if the user explicitly says "give me a hint."

### Default drill protocol

Full standalone version: `scr/reference/drill-protocol.md`.

1. Pick (or the user specifies) a level and a language. Generate a code
   file (or 2-4 files at advanced level) containing a realistic mix of
   INTENTIONAL vulnerabilities appropriate to that level, PLUS
   realistic-looking code that is actually fine (so the user has to
   discriminate, not just flag everything). Vary the language across
   sessions — don't let the user settle into one.
2. Time box: 15 min (basics/intermediate, single file), 25-30 min
   (advanced, multi-file), no limit but self-timed (mastery/adversarial).
3. The user submits their review as: line/location → vulnerability class
   → severity (Critical/High/Medium/Low) → root cause explanation →
   remediation with ANY tradeoff the fix introduces (perf, UX, complexity).
4. THEN, and only then, grade:
   - Recall: what was found vs. what's actually in the code (list misses)
   - Precision: was anything flagged that wasn't actually a vulnerability
     (false positives are a real interview penalty, not a safe hedge)
   - Severity accuracy: did the Critical/High/Medium/Low ranking match
     actual exploitability and impact
   - Root cause quality: explained WHY it's vulnerable, or just pointed
     at the line
   - Remediation quality: correct fix, tradeoff stated
   - Communication: structured and scannable, or rambling
5. Explicitly answer: "What would a strong candidate have caught that the
   user didn't, and why would they have caught it?"
6. Log every miss and every false positive to `interview-bank/weak-spots.md`
   so patterns across sessions surface (e.g. "consistently misses race
   conditions" or "over-flags things that aren't actually exploitable").

### Vulnerability classes to rotate across drills

Don't repeat the same class every time — real loops sample broadly.
Injection (SQLi, command injection, NoSQL injection), XSS (reflected/
stored/DOM), CSRF, SSRF, insecure deserialization, auth/session flaws
(broken authn, session fixation, JWT misuse, IDOR), access control
(missing authz checks, privilege escalation), crypto misuse (weak
algorithms, hardcoded keys/secrets, insecure randomness), race conditions/
TOCTOU, business logic flaws (the hardest category — code with no
"obvious" bug but exploitable logic), file upload/path traversal, mass
assignment, and dependency/supply chain issues (vulnerable library usage).
Full checklist: `scr/reference/vuln-checklist.md`. Per-language tells:
`scr/reference/language-notes.md`.

### Advanced/mastery addition — business logic flaws

These have no syntactic tell, so from level `02-advanced` onward include
at least one drill per session with NO textbook vulnerability, only an
exploitable logic flaw (e.g. price manipulation via client-trusted
values, workflow state bypass). Grade whether it was found by reasoning
about intent, not pattern-matching.

### Adversarial/mastery mode

After submission, cross-examine like a real interviewer — pick the
weakest-justified finding and challenge it ("are you sure that's
exploitable? walk me through the actual attack") to test whether a
correct call gets defended or caved on under pressure.

### Cross-reference with the threat-modeling track

Occasionally (advanced+), take a system already threat-modeled in
`drills/` and generate the code for one component of it — this tests
whether the threat model predicted the actual vulnerability class
present, closing the loop between the two rounds.
