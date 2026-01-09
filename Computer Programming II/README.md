
# CP2_PROJECT

Classroom Management System — a small C program used for learning and demonstration.

This repository contains source code, a simple build script, and VS Code launch/tasks examples. The README below uses neutral, cross-platform instructions so contributors can follow along on their own systems.

## Prerequisites
- A C compiler (GCC/MinGW on Windows, or the system `gcc` on Linux/macOS). Ensure `gcc` is on your PATH.
- Optional: Visual Studio Code with the Microsoft C/C++ extension for editing and debugging.

If you are on Windows and using MinGW or TDM-GCC, make sure the `bin` directory that contains `gcc.exe` and `gdb.exe` is added to your PATH. On Linux/macOS install GCC through your package manager (apt, yum, pacman, brew, etc.).

## Build

From the project root (where this README lives) you can build with a single command. These examples assume the source file is at `CP2_PROJECT/main.c`.

Windows (PowerShell):

```powershell
# build
gcc "CP2_PROJECT\main.c" -o "CP2_PROJECT\main.exe"

# run
.
"CP2_PROJECT\main.exe"
```

Linux / macOS (bash):

```bash
# build
gcc CP2_PROJECT/main.c -o CP2_PROJECT/main

# run
./CP2_PROJECT/main
```

Alternatively you can run the included `build.ps1` on Windows (PowerShell):

```powershell
.
\build.ps1
```

## Run

Run the produced executable from the command line as shown above. The program is interactive and uses stdin/stdout for its menu.

## Debugging in VS Code

There are two common ways to debug in VS Code:

- Using the Microsoft C/C++ debug adapter (`cppdbg`) with GDB (recommended for GCC toolchains)
- Using CodeLLDB (an alternative debugger front-end)

The workspace `launch.json` provided in `.vscode/` uses variables so it should work across systems. Important points:

- Ensure the `program` path uses the correct executable name for your OS (`${fileDirname}\\${fileBasenameNoExtension}.exe` on Windows, `${fileDirname}/${fileBasenameNoExtension}` on Linux/macOS).
- If using GDB, set `miDebuggerPath` to the full path of `gdb` if it's not on PATH.
- The launch configuration can run a `preLaunchTask` that compiles the active file before launching the debugger.

If F5 fails with an error mentioning a missing command (for example `extension.CompileRun`), this usually means a third-party extension remapped F5. Open Keyboard Shortcuts (Ctrl+K Ctrl+S) and remove or reassign any F5 binding from extensions like "Compile Run" or "Code Runner".

## What to commit

- Commit source files (`*.c`, `*.h`), scripts (`build.ps1`), `README.md`, `LICENSE`, and `.vscode` configuration files you want to share.
- Do NOT commit build artifacts or binaries (for example `main.exe`, `main`, or any files in `build/`, `bin/`, `obj/`). The included `.gitignore` already excludes common artifacts.

## Contributing

See `CONTRIBUTING.md` for a short guide. If you open a PR, please include:

- A short description of the change
- How to reproduce or test it

## License

This project is provided under the MIT license — see `LICENSE`.

---
