# Frameworks Reference

Concise reference, one worked example each. No filler.

## STRIDE
Threat enumeration per component/boundary: **S**poofing, **T**ampering,
**R**epudiation, **I**nformation disclosure, **D**enial of service,
**E**levation of privilege.

*Example:* A login API behind a trust boundary from the public internet.
Spoofing — attacker submits stolen credentials as another user. Tampering —
attacker modifies the request to change the `role` field client-side.
Repudiation — no audit log of failed login attempts, so an admin can deny
having reset their own password. Information disclosure — verbose error
distinguishes "user not found" from "wrong password," enabling enumeration.
DoS — no rate limit, so the endpoint is crackable via brute force. Elevation
of privilege — a successful login returns a JWT the backend trusts for
`role` without re-checking server-side.

## SALT
Default answer structure for any design question: **S**cope (what system,
what's in/out of bounds), **A**ssets (what's worth protecting and why),
**L**ayers (trust boundaries and the components inside each), **T**radeoffs
(cost of every control you propose).

*Example:* Asked to threat model a file-sharing feature — Scope: upload,
storage, and share-link generation only, not the whole app. Assets: user
files (confidentiality), share-link tokens (integrity/unguessability).
Layers: client → API gateway → auth service → storage bucket, each a
boundary. Tradeoffs: signed, short-lived share URLs add complexity and a
key-rotation burden versus permanent public links, but close the
indefinite-exposure risk.

## Attack Trees
Root node is the top-ranked threat; children are the ways to achieve it,
decomposed until each leaf is a concrete, testable step. Used to go deep on
the #1 threat after STRIDE has ranked it, not to enumerate broadly.

*Example:* Root — "Attacker exfiltrates another user's files." Children —
(1) Guess/enumerate share-link token → leaf: token entropy too low; (2)
Compromise storage bucket IAM policy → leaf: overly broad bucket ACL; (3)
Exploit IDOR on the download endpoint → leaf: endpoint trusts a client-
supplied `file_id` without ownership check. Each leaf maps directly to a
mitigation.

## DREAD vs CVSS
DREAD (**D**amage, **R**eproducibility, **E**xploitability, **A**ffected
users, **D**iscoverability) is a fast, subjective 1-10-per-axis scoring
model good for ranking threats in a live discussion. CVSS is a
standardized, auditable scoring system (base/temporal/environmental
metrics) used for tracking real vulnerabilities in a vuln-management
pipeline. In an interview, DREAD-style reasoning ("high damage, low
discoverability, still worth fixing first because...") is expected; citing
CVSS vectors is a bonus signal of real-world tooling exposure, not a
substitute for the reasoning.

*Example:* An IDOR that leaks another user's profile email — Damage:
moderate (PII, not credentials). Reproducibility: trivial (increment an
ID). Exploitability: trivial (no tooling needed). Affected users: all.
Discoverability: high (obvious from URL pattern). DREAD score pushes it
above a theoretical crypto downgrade that scores lower on reproducibility
and discoverability — ranking, not just severity, is the point.

## LINDDUN
Privacy-threat counterpart to STRIDE: **L**inkability, **I**dentifiability,
**N**on-repudiation (of privacy actions), **D**etectability, **D**isclosure
of information, **U**nawareness, **N**on-compliance.

*Example:* An analytics pipeline that logs device fingerprints alongside
in-app events. Linkability — fingerprints let otherwise-anonymous sessions
be correlated across time. Identifiability — combined with IP and behavior,
a specific user becomes identifiable without an account. Unawareness —
users never consented to fingerprint-based tracking specifically. The
mitigation (hash + rotate the fingerprint, minimize retention) trades off
some fraud-detection signal for privacy compliance — a tradeoff that must
be stated, per SALT.
