# StackHunter

A simple command-line tool to analyze `%p` leaks: generate cyclic patterns, scan for possible canary/libc/stack/main pointers, and locate specific values by position.

Supports both 32-bit and 64-bit leaks. Filters out ASCII artifacts like `%p`, `.p.`, `p.p`, etc. Output is colorized and split into addresses and small values for clarity.

---

## Features

- Generate cyclic `%p` fuzzing payloads
- Scan leaked stack data and detect:
  - possible canary (if not a small value)
  - libc / stack / main binary pointers (heuristic)
- Locate any leaked value and get its stack position
- Smart filtering to ignore noise (e.g. `%p`-style strings)
- 32-bit and 64-bit compatible
- Big/little endian-aware (for ASCII detection)
- Clean CLI output with colors and `%pos$p` snippets for copy-paste

---

## Usage

Run with one flag at a time:

| Flag               | Description                            |
|--------------------|----------------------------------------|
| `-c`, `--cyclic N` | Generate N `%p.` payloads              |
| `-s`, `--scan`     | Scan a leak (show addresses + values)  |
| `-f`, `--find`     | Search for a value in the leak         |
| `-h`, `--help`     | Show help                              |

---

## Examples

### Generate fuzzing payload

```bash
stackhunter -c 50
%p.%p.%p.%p.%p.%p.%p.%p.%p.%p.%p.%p.%p.%p.%p.%p.%p.%p.%p.%p.%p.%p.%p.%p.%p.%p.%p.%p.%p.%p.%p.%p.%p.%p.%p.%p.%p.%p.%p.%p.%p.%p.%p.%p.%p.%p.%p.%p.%p.%p.
```

### Scan a leaked stack

```bash
stackhunter -s "0x200.0xf7f275c0.0x804877d.0x1.0xfffffea1"
```

<img width="518" height="183" alt="image" src="https://github.com/user-attachments/assets/c6d8e966-8955-4376-9d1f-99a4eea4f37a" />


### Find where a leaked address appears

```bash
stackhunter -f "0x200 0xf7f27d40 0xfffffea1" 0xfffffea1

--- Matches ---
[3] 0xfffffea1 | %3$p
```

---

## Notes

- Use quotes if your leak contains spaces.
- Values under `0x1000` are treated as small and shown separately with their decimal value and ASCII if printable.
- Artifacts from `%p`-based fuzzing are automatically filtered out.

---

## License

Licensed under the **GNU General Public License v3.0**.

> You are free to use, modify, and redistribute this tool, but any distributed modifications must remain open source under the same license.

© 2025 ub1cu0
