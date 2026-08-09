---
name: cascade-literature-review
description: Build a literature review by exhaustive backward/forward citation cascade from seed papers, then appraise the corpus on four epistemic axes (tacit vs explicit normative premises, progressive vs degenerating research programme, performative contamination of the field of study, and strength of empirical claim). Use this whenever the user asks for a literature review, a state of the art, a snowball or backward/forward citation search, a survey of a theoretical debate, or a critical synthesis — and also whenever they name "key papers", "seed papers" or "founding papers" and want what those cite and what cites them. Use it too when the request is about screening a literature for hidden value premises, circular or self-fulfilling theories, or a field that keeps rescuing a theory with ad hoc fixes. Prefer this skill over ad-hoc web searching whenever the deliverable is a synthesis of a scholarly literature rather than a single fact lookup.
---

# Cascade literature review with enthusiastic scepticism

## What this skill produces

Three artifacts, in this order:

1. **A corpus ledger** — one row per work, with provenance (which seed, which direction, which source database), triage tier, and appraisal codes. Machine-readable (CSV or a Zotero collection with tags).
2. **Programme dossiers** — one short document per research programme identified in the corpus, carrying the axis-2 and axis-3 verdicts that individual papers inherit.
3. **The review itself** — a synthesis that states, for every thesis it reports, how strongly it is warranted and what would overturn it.

Never deliver 3 without 1 and 2. A review whose corpus cannot be audited is an opinion piece with citations.

## The core idea — read this before doing anything

The cascade and the appraisal are not two separate features bolted together. Each direction of the cascade produces the evidence one specific axis needs:

- **Backward** (works cited by the seeds) reconstructs where the seeds' premises come from. This is where you find whether a normative premise was argued for once and then inherited unexamined for thirty years. It feeds **axis 1**.
- **Forward** (works citing the seeds) is a record of how the community behaved after the thesis was on the table: what anomalies appeared, what the response was, whether the core was narrowed or protected. It feeds **axis 2**. It also shows who picked the theory up — if the citing set includes textbooks, regulators, consultancies and practitioner handbooks, the actors the theory describes have read it. That feeds **axis 3**.

So: run the cascade to build the corpus, and read the shape of the cascade as data in its own right. Citation counts are not a quality signal here; the *distribution* of citation stances is the signal.

## Non-negotiables

**Exhaustive enumeration, tiered appraisal.** "Integral" applies to enumeration: at depth 1 every reference and every citing work of every seed enters the ledger, none silently dropped. It does not apply to appraisal — the full four-axis grid requires reading a paper properly and cannot be applied to two thousand records. Triage is therefore explicit, criteria-based, and recorded in the ledger. An excluded paper is an excluded paper with a reason, never an absent one. Absences that leave no trace validate themselves.

**Provenance on every record.** Which seed it came from, which direction, which database, what date. Reviews rot when nobody can tell whether a gap is a real gap or a query that failed.

**Two-level verification.** Mark every substantive claim `[V]` only when you have read the passage in the source that supports it. `[C]` means claimed-but-unchecked. Finding that a cited work exists proves existence, not that it supports the claim made of it — most miscitation survives an existence check. Prefer paraphrase; if an exact wording matters, keep the quotation under fifteen words and attribute it.

**Symmetry.** Apply the grid to the programme the user favours, not only to its rivals. A grid used in one direction is a rhetorical instrument. If the user's own position comes out unscathed on all four axes, treat that as a warning sign about the grid's application rather than as a result.

**Falsification hooks.** Every exclusion and every programme-level verdict records what evidence would reverse it. Without this the appraisal is unfalsifiable and, by its own standards, worthless.

**No confidence without a check.** Search rather than hedge. Quantitative claims, exact citations, dates and product names are qualified `[to verify]` unless verified.

## Workflow

### Phase 0 — Frame the question and the exclusion contract

Before searching, get three things from the user and write them down:

- The **thesis or theses to be synthesised**, stated as propositions, not as a topic. "Wage share and innovation direction" is a topic; "the composition of demand shapes the direction of technical change" is a thesis. The cascade is anchored on theses, otherwise it drifts.
- The **scope boundary**: disciplines, languages, date floor, publication types (preprints? working papers? grey literature? practitioner documents — these matter for axis 3).
- The **budget**: how many works can realistically be read in full. This number sets the triage thresholds, and it is better set honestly at the start than discovered halfway through.

State back the constraints you have understood before proceeding.

### Phase 1 — Seed set

Identify 3–8 seed works that carry the theses. Fewer than 3 makes the cascade parochial; more than 8 makes depth-1 unmanageable. Seeds should span the positions in the debate, including the ones the user is sceptical of — a cascade seeded only from allies produces a corpus that cannot disconfirm anything.

Record for each seed: DOI, OpenAlex ID, year, and one sentence on which thesis it carries.

Confirm the seed list with the user before running the cascade. This is the last cheap moment to change direction.

### Phase 2 — Cascade

Depth 1 exhaustively in both directions, for every seed. See `references/cascade-protocol.md` for API mechanics, deduplication, forward-set overflow handling, and the depth-2 rule.

### Phase 3 — Deduplicate and triage

Merge on DOI, then on normalised title + year. Assign each record a tier:

| Tier | Meaning | Treatment |
|---|---|---|
| T0 | Seeds | Full grid, full read |
| T1 | Directly bears on a thesis | Full grid, full read |
| T2 | Relevant context, not thesis-bearing | Abstract-level coding, axis 1 and 4 only |
| T3 | Out of scope | Recorded with exclusion reason, not read |

Triage on title and abstract. Where the abstract is ambiguous, promote rather than exclude — a false positive costs a read, a false negative costs a blind spot you will never see.

Report the tier counts to the user before reading anything, with the T1 count against the stated budget. If T1 exceeds budget, tighten the thesis statements rather than truncating arbitrarily, and record the tightening.

### Phase 4 — Map research programmes (axes 2 and 3)

This is the step that makes the appraisal tractable, and it is a correction to the naive version of the grid: **axes 2 and 3 are not properties of papers.** A research programme is progressive or degenerating; a *field of study* is contaminated by a theory or independent of it. Individual papers inherit these verdicts from the programme they belong to.

So: cluster the corpus into research programmes (typically 3–6 in a review of normal size). For each, write a dossier assessing axis 2 and axis 3 once, with evidence drawn from the forward cascade. Then assign each paper to a programme. Papers inherit, and inheritance can be overridden per paper only with a stated reason — a paper inside a degenerating programme that genuinely exposes the core to risk is real and should be marked as such.

Full criteria and indicators: `references/appraisal-grid.md`.

### Phase 5 — Appraise papers (axes 1 and 4)

Per paper, at T0/T1 depth:

- **Axis 1 — normative structure**: `descriptive` / `normative-explicit` / `normative-tacit`. The discriminator is not whether a value premise is present but whether it is named *and* presented as one contingent option among alternatives. A premise named but framed as the only reasonable position fails.
- **Axis 4 — claim strength**: `typological` / `correlational` / `causal-identified` / `causal-asserted`, plus whether the evidence offered meets the bar the claim requires. `causal-asserted` — a causal claim resting on correlational evidence — is the most common failure and the cheapest to detect.

Full criteria, indicators and worked codings: `references/appraisal-grid.md`.

### Phase 6 — Decide, synthesise, attack

Apply the decision rule (below), write the synthesis, then run an adversarial pass on your own draft: for the central conclusion, actively search for the strongest published objection to it. If none is found, say so explicitly and note that the absence may reflect the corpus boundary rather than the state of the debate. Reporting formats: `references/reporting.md`.

## Decision rule

| Profile | Decision |
|---|---|
| normative-tacit **and** degenerating **and** contaminated | **Exclude** — the strongest exclusion signal. Record in the review's exclusion register with the three codes. |
| Any two of the three above | **Include, flagged.** The thesis is reported as an artefact of a programme, not as a finding. |
| normative-explicit, premise presented as contingent | **Include**, whatever the premise. Explicit normativity is a virtue, not a defect: the conditional "if premise P, then Q" is testable in the same way a descriptive claim is. |
| contaminated field but progressive programme | **Include**, with every post-diffusion empirical confirmation requalified as "the theory structured the practice" rather than "the regularity was observed". |
| `causal-asserted` on correlational evidence | **Downgrade** the claim to correlational in the synthesis, whatever the paper says. Do not exclude on this ground alone. |
| Any axis `indeterminate` | **Include**, marked indeterminate. Indeterminate is a legitimate verdict and must be visible in the ledger; converting it silently to a negative verdict is how a grid becomes a filter for what one already believed. |

Two guards against the grid degenerating into a rejection machine:

- If the exclusion rate exceeds roughly a third of T1, stop and re-examine the coding rather than the literature. Either the codings are being applied too harshly, or the seed set was too narrow to contain a genuine debate.
- A degenerating programme can still contain true propositions, and its accumulated observations may be sound even where its explanations are not. Exclude the theory's warrant, not its data.

## Ledger schema

One row per work. Minimum columns:

```
id_openalex, doi, year, authors_short, title, venue,
provenance_seed, provenance_direction (backward|forward|seed|manual),
provenance_source (openalex|s2|crossref|manual), retrieved_on,
tier (T0|T1|T2|T3), exclusion_reason,
programme_id,
a1_normativity (descriptive|normative-explicit|normative-tacit|indeterminate),
a2_programme (progressive|degenerating|indeterminate|inherited),
a3_contamination (contaminated|independent|indeterminate|inherited),
a4_claim (typological|correlational|causal-identified|causal-asserted),
a4_evidence_meets_bar (yes|no|partial),
decision (include|include-flagged|exclude),
falsification_hook,
verification (V|C),
notes
```

If Zotero is available, mirror this: one collection per review, tags `review:<name>`, `tier:T1`, `a1:normative-tacit`, `prog:<id>`, `decision:exclude`. Tags survive outside the review; a CSV in a folder does not.

## Scaling down

If the budget is small, cut in this order and tell the user what was cut:

1. Drop axis 4 (cheapest to re-add later, and its main function — catching causal claims on correlational evidence — can be handled in the synthesis).
2. Restrict the forward cascade to the highest-cited *k* citing works per seed plus every citing work that is critical in stance (see the protocol file — stance matters more than count).
3. Drop programme dossiers to a single paragraph each, keeping the two verdicts and their evidence.

Do not cut: provenance, the exclusion register, the falsification hooks, or the symmetry requirement. Those are what distinguish this from a reading list.

## Reference files

- `references/cascade-protocol.md` — API mechanics (OpenAlex, Semantic Scholar, Crossref), direction semantics, deduplication, overflow and depth-2 rules, Zotero integration.
- `references/appraisal-grid.md` — the four axes in full: indicators, coding rules, failure modes, worked examples.
- `references/reporting.md` — output templates for the review, the programme dossier and the exclusion register.
