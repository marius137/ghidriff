# Reliability Refresh Progress Log

## Runtime

- Ghidra runtime checked locally: 12.0.4.
- pyghidra runtime checked locally: 3.0.2.

## Changed Files

- `.devcontainer/devcontainer.json`: target Ghidra 12.0.4/Python 3.13 image settings, stable ghidra-stubs path, and Ruff editor integration.
- `.devcontainer/post-create.sh`: install test/dev extras and link ghidra-stubs to a stable venv path.
- `.vscode/settings.json`: use a stable ghidra-stubs path and Ruff formatting.
- `setup.cfg`: require Python >=3.10, require pyghidra 3.x, add pytest markers and dev extra.
- `pyproject.toml`: add practical Ruff configuration.
- `Makefile`: add install, dev setup, fast/integration tests, lint, format, check, and clean targets.
- `ghidriff/parser.py`: make `--summary` a boolean flag.
- `ghidriff/__main__.py`: pass `--decompiler-timeout` into the engine.
- `ghidriff/ghidra_diff_engine.py`: add runtime compatibility warnings, typed CLI options, blocking decompiler queue, serialized analysis path, preflight checks, decompiler timeout use, stable `remove_code_sig` list return, small-function opt-in comparison path, unique program ID classification, and safer syntax/lint fixes.
- `ghidriff/version_tracking_diff.py`: guard invalid matches and fix `skip_types`.
- `tests/conftest.py`, `tests/test_fast_core.py`: split fast/integration tests and add fast regression coverage.
- `README.md`, `docs/deferred-issues.md`: document Ghidra 12.0.4/pyghidra 3.x workflow, Makefile commands, macOS notes, JVM arg syntax, integration-test path, and deferred design items.
- `.gitignore`: ignore local `binaries/`.

## Validation

- `make check PYTHON=.env/bin/python`: passed.
- `.env/bin/python -m pytest --collect-only -q`: passed, 26 tests collected.
- `.env/bin/python -m pytest tests/test_import.py::test_gzf_import_program -q`: passed.
- `.env/bin/python -m pytest tests/test_ghidra_zip_format_import.py::test_diff_afd_cve_2023_21768_gzf -q`: passed.

## Issues Addressed

- #138: Python support metadata now requires Python >=3.10.
- #137: `remove_code_sig` consistently returns a list of strings.
- #134: devcontainer and docs align to Ghidra 12.0.4 and pyghidra 3.x.
- #125: random analysis sleep replaced with a serialized analysis lock.
- #121: added an opt-in small-function comparison path and fast regression test.
- #119: added `--decompiler-timeout` and wired it through decompilation.
- #79: division-by-zero guard remains in stats calculation.
- #43: added Makefile/Ruff lint/dev workflow.
- #27: decompiler timeout is exposed as a user-facing decompiler option.
- #24: language and symbol-count preflight checks now raise actionable errors.
- #120: README macOS install notes updated for current Ghidra target.

## Deferred

Deferred design work is summarized in `docs/deferred-issues.md`: VT session import/export, loader/language/project planning, p-code correlator, stack-frame diffing, markdown linting, large-binary JVM stability, symbol porting, function categories, pdiff dataclasses, and extensionless PE URL heuristics.

## Residual Risks

- The full integration suite was not run end-to-end because the representative Ghidra tests already take minutes and some tests perform full analysis/diff flows.
- The small-function fix is intentionally conservative and opt-in through `--min-func-len`; broader correctness may still require #40 p-code correlator work.
- Ruff ignores existing broad style debt to provide a practical gate without a large unrelated formatting rewrite.
