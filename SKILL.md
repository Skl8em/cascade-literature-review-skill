---
name: cascade-literature-review
description: Build a literature review as a recursive fixed-point process — broad multi-vocabulary sweep, derivation of key contributions from the corpus itself, exhaustive backward/forward citation cascade, lateral search across neighbouring disciplines — then appraise the corpus on four epistemic axes (tacit vs explicit normative premises, progressive vs degenerating research programme, performative contamination of the field, and the purchase a paper's evidence mode has on the claim it makes). Use this whenever the user asks for a literature review, a state of the art, a snowball or backward/forward citation search, a survey of a theoretical debate, or a critical synthesis. Use it too when they want a literature screened for hidden value premises, circular or self-fulfilling theories, or a field that keeps rescuing a theory with ad hoc fixes — and when they want to know not just what the literature has not settled but what it structurally cannot settle. Prefer this skill over ad-hoc web searching whenever the deliverable is a synthesis of a scholarly literature rather than a single fact lookup.
---

# Recursive cascade literature review with enthusiastic scepticism

## What this skill produces

1. **A corpus ledger** — one row per work, with versioned provenance (which channel, which round, which key-set version, which source database), tier, and appraisal codes.
2. **Programme dossiers** — one per research programme identified, carrying the axis-2 and axis-3 verdicts that individual papers inherit.
3. **The review** — a synthesis stating, for every thesis, how strongly it is warranted, what would overturn it, and whether it is the kind of thing this literature can settle at all.

Never deliver 3 without 1 and 2. A review whose corpus cannot be audited is an opinion piece with citations.

## The core design — read this before doing anything

**Three findings channels, three declared completeness regimes.** Completeness is a property of each channel separately, never of the whole. Claiming global exhaustiveness is not achievable and pretending otherwise is the failure this skill exists to prevent.

- **Backward cascade** (what key works cite) — exhaustive at depth 1. Reconstructs where premises come from. Feeds **axis 1**.
- **Forward cascade** (what cites key works) — exhaustive in enumeration, tiered in reading. It is a record of how the community behaved after the thesis was on the table: which anomalies arose, what was done with them, who picked the theory up. Feeds **axes 2 and 3**.
- **Lateral channel** — explicitly partial, with the interrogated disciplines and the untouched ones both listed. The cascade is an intra-community operation: it only ever finds people who already read each other. A parallel literature treating the same problem in another vocabulary, citing none of the key works, is structurally invisible to citation search. The lateral channel is the only way to reach it, it cannot be mechanised, and it is not optional.

**The key set is derived, not given, and it moves.** Do not ask the user for key papers. Sweep broadly first, derive candidate key contributions from what the sweep returns, cascade from those, and let reading move the set. Two or three rounds normally suffice.

**Appraisal is deferred.** Rounds 1-2 run on metadata and abstracts. The full grid comes after the key set stabilises, otherwise expensive codings are spent on works that leave the set.

## Non-negotiables

**Exhaustive enumeration, tiered appraisal.** At depth 1 every reference and every citing work of every key work enters the ledger, none silently dropped. Appraisal is triaged, criteria-based, and recorded. An excluded work is an excluded work with a reason, never an absent one — absences that leave no trace validate themselves.

**Versioned provenance on every record.** Channel, round, key-set version, source, date. A demoted key work does not disappear; it moves to the register with its demotion reason. The movement of the key set is evidence, not draft.

**Two-level verification.** `[V]` only when the supporting passage has been read. `[C]` means claimed-but-unchecked. Confirming a cited work exists proves existence, not that it supports the claim made of it — most miscitation survives an existence check. Paraphrase by default; quotations under fifteen words, attributed.

**Symmetry.** Apply the grid to the programme the user favours, not only to its rivals. If their own position comes out clean on all four axes, treat that as a warning about the application rather than as a result.

**Falsification hooks.** Every exclusion and every programme verdict records what would reverse it. Without this the appraisal is unfalsifiable and, by its own standard, worthless.

**No confidence without a check.** Search rather than hedge. Figures, exact citations, dates and identifiers are `[to verify]` unless verified.

## Workflow

### Phase 0 — Frame

Establish and write down, with the user:

- The **theses**, as propositions, not as a topic. "Wage share and innovation" is a topic; "the composition of demand shapes the direction of technical change" is a thesis. Everything downstream is anchored on theses.
- The **scope boundary**: disciplines, languages, date floor, publication types. Books, working papers and practitioner documents are in scope by default — excluding them is a decision with consequences that must be stated, not a default.
- The **budget**: how many works can be read in full. This sets the triage thresholds, and is better fixed honestly now than discovered halfway.

State the constraints back before proceeding.

### Phase 1 — Broad sweep (round 0)

Keyword search across the sources appropriate to the disciplines in scope — and in **three or four disciplinary vocabularies from the start**, not after. The lateral channel opens here, not later: a sweep run in one vocabulary produces a key set that can only reproduce that vocabulary's debate.

Output: a provisional corpus, unappraised, metadata only.

### Phase 2 — Derive the key set

Write the derivation criteria **before looking at what the sweep returned**, otherwise the criteria mould themselves to the findings.

A work is a candidate key contribution when it **carries** a thesis rather than applying it; when it is where a programme's hard core is stated; when it is a **site of dispute**, attracting critical citation and not merely use; or when it is the origin of a premise. Citation count measures diffusion, which is an axis-3 indicator, not theoretical centrality — do not derive the key set from it.

**Adversarial coverage rule.** The key set must span the positions in the debate, including those the review is sceptical of. If a round yields key works from a single programme, that is a defect of the sweep, not a fact about the literature — widen and re-derive. This is the main failure mode of a derived key set: it converges on wherever the sweep started.

Size: 3-8. Fewer is parochial; more makes depth-1 unmanageable.

Show the derived set and the criteria to the user before cascading.

### Phase 3 — Cascade

Depth 1 in both directions from every key work, plus a lateral pass on the vocabularies the new corpus reveals. See `references/discovery-protocol.md` for source selection by discipline, API mechanics, the books/humanities compensation procedure, citation stance coding, and deduplication.

### Phase 4 — Re-derive, and loop

Re-apply the phase-2 criteria to the enlarged corpus. The key set will move — typically a few works in, a few out.

- Record the new key-set version, and the demotion reason for each work that left.
- **Note the direction of drift.** Toward the recent: the debate has moved and the older literature has become history. Toward the older: the field is rediscovering its foundations, often the sign of an anomaly surfacing. Either way it goes in the programme dossier.
- Loop back to phase 3 with the new members only.

**Stopping rule.** Two or three rounds. Declare convergence when the set is stable and a further round yields no significant new T1. If it has not converged after three rounds, **stop and report that as a finding**: a debate whose core will not stabilise says something about the field, and it feeds axis 2 directly.

**Path-dependence test** (cheap, and worth it). Run a second sweep from a deliberately different disciplinary entry point and see whether it converges on the same key set. Convergence means the centrality is real. Divergence means there are two communities working the same object without reading each other — the most valuable result a review of this kind can produce, and invisible to either the cascade or the fixed-point loop taken alone.

### Phase 5 — Triage

| Tier | Meaning | Treatment | Zotero |
|---|---|---|---|
| T0 | Key works (current version) | Full grid, full read | yes |
| T1 | Directly bears on a thesis | Full grid, full read | yes |
| T2 | Relevant context, not thesis-bearing | Abstract-level, axes 1 and 4 only | yes |
| T3 | Out of scope | Recorded with exclusion reason, not read | no — ledger only |

Triage on title and abstract. Where ambiguous, promote rather than exclude: a false positive costs a read, a false negative costs a blind spot that will never be seen.

Report tier counts against the stated budget before reading anything. If T1 overruns, tighten the theses rather than truncating arbitrarily, and record the tightening.

### Phase 6 — Map programmes (axes 2 and 3)

**Axes 2 and 3 are not properties of papers.** A research programme is progressive or degenerating; a *field of study* is contaminated by a theory or independent of it. Cluster the corpus into programmes — typically 3-6 — and assess each once, with evidence drawn from the forward cascade's stance distribution. Papers then inherit, and inheritance is overridable per paper with a stated reason: a paper inside a degenerating programme that genuinely exposes the core to risk is real and should be marked.

Criteria: `references/appraisal-grid.md`.

### Phase 7 — Appraise papers (axes 1 and 4)

Per paper at T0/T1 depth, T2 on abstract:

- **Axis 1** — is the value premise named *and* presented as one contingent option among others? The premise often lives in the operationalisation rather than the prose.
- **Axis 4** — three orthogonal dimensions, not a hierarchy of evidence: what kind of claim, produced by what mode of inquiry, and what **purchase** that mode has on that claim. A randomised design has strong purchase on magnitude and almost none on mechanism discrimination or conceptual requalification; a well-conducted ethnography has strong purchase on requalification, and a successful requalification retroactively unsettles what the trial was measuring.

Criteria and worked codings: `references/appraisal-grid.md`.

### Phase 8 — Decide, synthesise, attack

Apply the decision rule, write the synthesis, then attack the draft: for the central conclusion, actively search for the strongest published objection. If none is found, say so, and say whether that reflects the debate or the corpus boundary.

The synthesis carries an obligatory epistemological section — what the corpus **cannot** settle, distinct from what it has not settled. Templates and the obstacle taxonomy: `references/reporting.md`.

## Decision rule

| Profile | Decision |
|---|---|
| normative-tacit **and** degenerating **and** contaminated | **Exclude** — the strongest signal. Register with all three codes. |
| Any two of the three | **Include, flagged.** The thesis is reported as an artefact of a programme, not as a finding. |
| normative-explicit, premise presented as contingent | **Include**, whatever the premise. Explicit normativity is a virtue: "if P then Q" is testable in the same way a descriptive claim is. |
| contaminated field, progressive programme | **Include**, with post-diffusion confirmations requalified as "the theory structured the practice" rather than "the regularity was observed". |
| Weak purchase of mode on claim | **Restate** the claim at the level the evidence supports, whatever the paper says. Not grounds for exclusion. |
| Any axis `indeterminate` | **Include**, marked. Indeterminate is a legitimate verdict and must stay visible; letting it drift into a negative verdict is how a grid becomes a filter for what was already believed. |

Two guards against the grid becoming a rejection machine:

- If exclusions exceed roughly a third of T1, re-examine the coding rather than the literature. Either it is being applied too harshly, or the sweep was too narrow to contain a real debate.
- A degenerating programme is not thereby false and its observations may be sound. Exclude the warrant, not the data.

## Ledger schema

```
id_openalex, doi, isbn, year, authors_short, title, venue, work_type,
prov_channel (sweep|backward|forward|lateral|manual|pdf-extraction),
prov_round, prov_keyset_version, prov_from_work, prov_source, retrieved_on,
tier (T0|T1|T2|T3), exclusion_reason, demotion_reason,
programme_id,
a1_normativity (descriptive|normative-explicit|normative-tacit|indeterminate),
a2_programme (progressive|degenerating|indeterminate|inherited),
a3_contamination (contaminated|independent|indeterminate|inherited),
a4_claim_type, a4_evidence_mode, a4_purchase (strong|partial|weak|none),
a4_failure (theoretical-inertia|overreach|none),
population_evidence, population_conclusion,
stance (for forward-channel records),
decision (include|include-flagged|exclude),
falsification_hook, verification (V|C), notes
```

## Zotero boundary rule

Everything that reaches **T2 or above** goes into Zotero — seen and coded. T3 and raw enumeration stay in the tabular ledger with their provenance. Zotero holds what was read; the ledger proves the rest was seen and set aside.

Structure: collection `Review: <name>`, subcollections **by research programme** (the structural, exclusive axis), plus `Key works` and `Demoted`. Tier and axis codes are tags, since they cumulate: `review:<name>`, `tier:T1`, `prog:<id>`, `a1:normative-tacit`, `a4:weak-purchase`, `stance:rescuing`, `decision:exclude`. Appraisals go in a child note prefixed with the review name, so a work appraised in two reviews carries both codings without overwriting.

Write access is required. Read-only means the appraisal dies with the conversation.

## Scaling down

Cut in this order, and tell the user what was cut:

1. Drop the path-dependence test (second sweep).
2. Restrict the forward cascade's *reading* to critical-stance works plus the most-cited *k* and most-recent *m* per key work — never the enumeration, which stays exhaustive.
3. Reduce programme dossiers to a paragraph each, keeping both verdicts and their evidence.

Never cut: the lateral channel, provenance, the exclusion register, the falsification hooks, the symmetry requirement, the epistemological section. Those are what separate this from a reading list.

## Reference files

- `references/discovery-protocol.md` — sources by discipline, the books/humanities gap and its compensation, API mechanics, lateral search procedure, stance coding, deduplication, search logging.
- `references/appraisal-grid.md` — the four axes in full, including the three-dimensional axis 4 and the handling of meta-analyses.
- `references/reporting.md` — templates, the "cannot settle" obstacle taxonomy, exclusion register, handover note.
