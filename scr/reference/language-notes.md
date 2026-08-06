# Language Notes — Where Vulnerabilities Hide

Cross-language quick reference. Real loops sample across languages —
don't specialize in just one.

## Python
- `pickle.loads` / `yaml.load` (not `safe_load`) on untrusted input — insecure deserialization
- f-string or `%`-formatted SQL instead of parameterized queries
- `subprocess.run(..., shell=True)` with user input — command injection
- `eval`/`exec` on user input
- Flask/Django debug mode left on in prod-looking code (stack traces, secret leakage)
- Django `raw()` / `.extra()` bypassing the ORM's parameterization

## Java
- Deserialization gadgets — `ObjectInputStream.readObject` on untrusted input
- XXE — `DocumentBuilderFactory`/`SAXParserFactory` without disabling external entities
- JDBC string concatenation instead of `PreparedStatement`
- Spring `@RequestMapping` missing `@PreAuthorize`/method-security on a sensitive endpoint
- Reflection-based deserialization frameworks (Jackson polymorphic typing misconfigured)

## JavaScript / Node
- Prototype pollution — unguarded recursive merge/`Object.assign` from user input, or `__proto__` key not blocked
- `eval`, `new Function()`, or `vm` module on user input
- Template engines rendering unsanitized user input (`ejs`, unescaped Handlebars `{{{ }}}`)
- `child_process.exec` with string interpolation instead of `execFile`/array args
- JWT libraries accepting `alg: none` or not pinning the expected algorithm
- Missing `helmet`/CSP, permissive CORS (`Access-Control-Allow-Origin: *`) on authenticated routes

## Go
- `fmt.Sprintf` used to build SQL instead of parameterized queries (`?`/`$1` placeholders)
- Missing `context` timeout on outbound requests/goroutines — resource exhaustion / goroutine leak used as DoS
- `os/exec.Command` with unsanitized user input
- Ignored error returns (`_ = err`) hiding a failed auth/validation check
- `math/rand` (not `crypto/rand`) used for tokens or session identifiers
