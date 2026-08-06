# SCR Vuln Checklist — Never Miss These

Pre-flight skim before every drill. Dense, no filler — each line is a
vuln class plus its code-level "tell."

## Injection
- **SQLi** — string-concatenated or f-string/template-built SQL instead of parameterized queries
- **Command injection** — user input passed to `exec`/`system`/`subprocess` with `shell=True` or unescaped
- **NoSQL injection** — user input passed as a raw operator/object into a Mongo-style query (`$where`, `$gt`, etc.)

## XSS
- **Reflected/DOM** — user input written into HTML/DOM via `innerHTML`, template string, or unescaped template render
- **Stored** — user-controlled content persisted then rendered elsewhere without encoding

## CSRF
- State-changing endpoint (POST/PUT/DELETE) with no anti-CSRF token and no `SameSite` cookie protection

## SSRF
- Server-side code fetches a URL built from user input with no allowlist/scheme/host validation

## Insecure Deserialization
- `pickle.loads`, `yaml.load` (not `safe_load`), Java `ObjectInputStream.readObject`, PHP `unserialize` on untrusted input

## Auth / Session Flaws
- **Broken authn** — missing rate limit on login, weak password policy, credentials in plaintext
- **Session fixation** — session ID not rotated after login
- **JWT misuse** — `alg: none` accepted, signature not verified, secret hardcoded, no expiry check
- **IDOR** — object ID from request used to fetch/modify a resource with no ownership check

## Access Control
- Authorization check missing or only checked client-side, after authentication already succeeded
- Role/permission check present on one path (UI) but not another (direct API call)

## Crypto Misuse
- Weak/broken algorithm (MD5/SHA1 for passwords, DES/ECB mode)
- Hardcoded keys/secrets/API tokens in source
- Insecure randomness (`Math.random`, `random.random`) used for tokens/session IDs

## Race Conditions / TOCTOU
- Check-then-act pattern with no lock/transaction (balance check then debit, file existence check then write)

## Business Logic Flaws
- No syntactic tell — look for client-trusted values that should be server-derived (price, quantity, role,
  discount), or a workflow step that can be skipped/reordered by calling an API directly

## File Upload / Path Traversal
- Uploaded filename used directly in a filesystem path; no extension/content-type allowlist; user input
  concatenated into a file path with no normalization/containment check

## Mass Assignment
- Request body bound directly to a model/object without an explicit allowlist of updatable fields

## Dependency / Supply Chain
- Known-vulnerable library version pinned; dependency pulled from an unpinned/untrusted source
