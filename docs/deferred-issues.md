# Deferred Issue Notes

These items are intentionally outside the current reliability refresh because they need design work, broader fixtures, or Ghidra-version-specific validation.

- Loader, language, and existing/manual project support: #129, #124, #114, and #130 should be designed together around explicit import planning rather than one-off CLI switches.
- Version Tracking session output/import: #135, #39, and #31 belong together as a VT interoperability feature. The current JSON/Markdown diff output remains the primary batch workflow.
- P-code correlator: #40 may be required for some small-function correctness cases, but it should be introduced as a new correlator with dedicated fixtures rather than folded into existing hash matching.
- Stack-frame diffing: #132 is a useful report enhancement once stable function stack metadata extraction is defined.
- Extensionless PE URL generation: #88 needs a reliable PE type/name heuristic for extensionless downloads before changing Microsoft symbol URL generation.
- Markdown linting: #55 should be handled after generated Markdown structure is made deterministic enough for GFM/cmark checks.
- Large-binary JVM stability and Java process exit behavior: #97 and #99 need reproducible cases and JVM/Ghidra-specific mitigation notes.
- Symbol porting, function categories, and pdiff dataclasses: #42, #15, and #5 are feature/refactor work and should not block reliability fixes.
