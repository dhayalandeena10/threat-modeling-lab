# Threat Modeling Practice Lab

Self-paced drill lab for FAANG security engineer interviews — product
security / appsec track (threat modeling, secure system design, secure code
review, IAM/cloud security).

## Progress

| Level | Drill | Date | Score (/30) | Top weakness |
|---|---|---|---|---|
| — | — | — | — | — |

## Curriculum

### `00-basics`
Trust boundaries, DFDs, STRIDE, CIA/AAA, universals. Simple 3-tier web app,
single auth flow. Threat modeling drilled in isolation here only.

### `01-intermediate`
SALT structure, attack trees, risk ranking, abuse cases, MITRE ATT&CK
mapping. Microservices, mobile backend, third-party integrations. Code
review merges in from this level onward — every drill is threat model +
real code/IaC review.

### `02-advanced`
Cloud/IAM boundaries (the other commonly underprepared round), shared
responsibility model, container/K8s, IaC review, supply chain, LINDDUN
privacy. Terraform/AWS specs with real code to review.

### `03-mastery`
Cold timed drills, interviewer cross-examination, facilitating a threat
model, standing up a TM practice at an org, threat modeling as code.

## How this repo works

- `CLAUDE.md` — drives every session: drill protocol, grading rubric,
  scoring philosophy. Read this if you want to know how the lab behaves,
  not this README.
- `reference/` — pre-flight checklist, standalone drill protocol, and
  framework cheat sheet (STRIDE, SALT, attack trees, DREAD/CVSS, LINDDUN).
- `drills/` — scenario + grade output per level.
- `case-studies/` — longer-form real-world breach/design writeups.
- `code-review/` — code/IaC review reps, merged into drills from
  `01-intermediate` onward.
- `notes/` — Obsidian vault. Permanent reference notes, not transcripts.
- `interview-bank/` — `weak-spots.md` (auto-appended CRITICAL misses and
  patterns) and `talking-points.md` (curated reusable answers).
- `./push.sh` — stage, commit, and push. Prompts for a GitHub PAT at
  runtime; never stores it.

To start a drill, just ask — the default protocol in `CLAUDE.md` kicks in
automatically.
