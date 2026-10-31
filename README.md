# cascade-literature-review

A Claude skill that builds a literature review as a recursive fixed-point process (broad multi-vocabulary sweep → derived key contributions → backward/forward citation cascade → lateral search), then appraises the corpus on four epistemic axes: tacit vs explicit normative premises, progressive vs degenerating programme, performative contamination, and the purchase of a paper's evidence mode on its claim.

The deliverable is a corpus ledger, programme dossiers and a synthesis that states what the literature cannot settle, not only what it has not settled.

## Layout

```text
cascade-literature-review/     the skill itself (what gets installed)
├── SKILL.md                   entry point: design, non-negotiables, workflow
└── references/
    ├── discovery-protocol.md  sources, API mechanics, lateral search, stance coding, dedup
    ├── appraisal-grid.md      the four axes in full
    └── reporting.md           templates, "cannot settle" taxonomy, exclusion register
justfile                       check / build / install
```

## Use

```sh
just check     # SKILL.md citations and references/ files agree
just build     # dist/cascade-literature-review.skill
just install   # symlink into ~/.claude/skills
```

`dist/` is generated and not versioned.

## Licence

Per-file licensing, declared in `REUSE.toml` ([REUSE](https://reuse.software) convention) with full texts in `LICENSES/`:

- **Content** (the skill under `cascade-literature-review/`, this README): [CC BY-SA 4.0](LICENSES/CC-BY-SA-4.0.txt).
- **Code and config** (`justfile`, `.gitignore`): [GPL-3.0-or-later](LICENSES/GPL-3.0-or-later.txt).
