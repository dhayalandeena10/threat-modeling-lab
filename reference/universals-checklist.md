# Universals Checklist — Never Miss These

Pre-flight read before every drill. Missing any of these is a CRITICAL miss
regardless of how strong the rest of the threat model is — the interviewer
reads it as "would miss this in a real review."

## Identity & Access
- [ ] Authn vs authz distinguished explicitly (who you are vs what you can do)
- [ ] Session management (expiry, rotation, invalidation on logout/privilege change)
- [ ] MFA on sensitive actions / privileged accounts
- [ ] Token handling (short-lived, scoped, not logged, secure storage)

## Data
- [ ] Encryption in transit (TLS everywhere, cert validation, no downgrade)
- [ ] Encryption at rest
- [ ] Key management (rotation, access control, HSM/KMS vs hardcoded)
- [ ] PII/data classification (what's sensitive, where it flows, blast radius)

## Input / Output
- [ ] XSS (output encoding, CSP)
- [ ] SQLi (parameterized queries)
- [ ] CSRF (tokens / SameSite cookies)
- [ ] SSRF (outbound request validation, especially on server-side fetchers)
- [ ] Deserialization (untrusted input into deserializers)
- [ ] File upload (type/size validation, storage isolation, no execution)

## Infra
- [ ] Network segmentation (trust zones, no flat network)
- [ ] Secrets management (no hardcoded secrets, vault/rotation)
- [ ] Least privilege (IAM roles, service accounts, blast radius on compromise)
- [ ] Patching / dependency hygiene

## Detection
- [ ] Logging (security-relevant events captured)
- [ ] Audit trail (who did what, when — tamper-resistant)
- [ ] Alerting (someone/something acts on anomalies)
- [ ] Non-repudiation (actions attributable to an actor)
