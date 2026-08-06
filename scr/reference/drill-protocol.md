# SCR Drill Protocol

Standalone copy of the SCR section of `../../CLAUDE.md`, for quick review
before a drill without re-reading the whole file.

## Steps

1. Pick (or specify) a level and a language. A code file (or 2-4 files at
   advanced level) is generated with a realistic mix of INTENTIONAL
   vulnerabilities for that level, plus fine-looking code that isn't
   actually vulnerable — discrimination is part of the test. Language
   rotates across sessions.
2. Time box: 15 min (basics/intermediate, single file), 25-30 min
   (advanced, multi-file), self-timed with no limit (mastery/adversarial).
3. **Silence during the drill.** No hints, no confirming/denying anything
   mid-review. Silence breaks only on an explicit "give me a hint."
4. Submit findings as: line/location → vulnerability class → severity
   (Critical/High/Medium/Low) → root cause → remediation with any tradeoff.
5. Grading, only after submission:
   - Recall — found vs. actually present (list misses)
   - Precision — anything flagged that wasn't actually a vulnerability
     (false positives are penalized, not a safe hedge)
   - Severity accuracy — Critical/High/Medium/Low vs. actual exploitability
   - Root cause quality — explained *why*, not just pointed at a line
   - Remediation quality — correct fix, tradeoff stated
   - Communication — structured/scannable vs. rambling
6. Close with: "What would a strong candidate have caught that I didn't,
   and why would they have caught it?"
7. Every miss and false positive logged to `../../interview-bank/weak-spots.md`.

## Vulnerability classes (rotate, don't repeat)

Injection (SQLi, command, NoSQL), XSS (reflected/stored/DOM), CSRF, SSRF,
insecure deserialization, auth/session flaws (broken authn, session
fixation, JWT misuse, IDOR), access control (missing authz, privilege
escalation), crypto misuse (weak algorithms, hardcoded keys, insecure
randomness), race conditions/TOCTOU, business logic flaws, file
upload/path traversal, mass assignment, dependency/supply chain.

## Level 02+ addition — business logic flaws

At least one drill per session from level `02-advanced` onward has NO
textbook vulnerability — only an exploitable logic flaw (price
manipulation via client-trusted values, workflow state bypass, etc.).
Graded on reasoning about intent, not pattern-matching.

## Mastery — adversarial mode

After submission, the weakest-justified finding gets cross-examined
("are you sure that's exploitable? walk me through the actual attack") to
test whether a correct call gets defended or caved on under pressure.

## Cross-reference with the threat-modeling track

Occasionally (advanced+), a system already threat-modeled in `../../drills/`
gets its code generated for one component — tests whether the threat model
predicted the actual vulnerability class present.
