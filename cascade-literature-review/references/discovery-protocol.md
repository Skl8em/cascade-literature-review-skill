# Discovery protocol

Three channels, three completeness regimes.
This file covers source selection, the structural gap in citation databases, API mechanics, the lateral procedure, stance coding, deduplication and logging.

## Contents

1. The three channels
2. Sources by discipline
3. The books and humanities gap
4. OpenAlex mechanics
5. Semantic Scholar, Crossref, OpenCitations
6. Lateral search procedure
7. Forward-set overflow
8. Citation stance coding
9. Deduplication and versioned provenance
10. Depth 2
11. Search log

## 1. The three channels

| Channel | Completeness regime | What it is evidence for |
|---|---|---|
| Backward | Exhaustive at depth 1 | Provenance of premises (axis 1) |
| Forward | Exhaustive in enumeration, tiered in reading | Community behaviour (axis 2), diffusion into practice (axis 3) |
| Lateral | Explicitly partial, disciplines listed both ways | Whether the object is worked on elsewhere under another name |

State each regime in the review's method section.
Never aggregate them into a claim of overall exhaustiveness.

## 2. Sources by discipline

OpenAlex and Semantic Scholar are the *generalist* standards, not universal ones.
Coverage is uneven and degrades exactly where a broad-ranging review needs to go.

| Source | Backward | Forward | Best for |
|---|---|---|---|
| OpenAlex | `referenced_works` field | filtered query | Default, free, no key |
| Semantic Scholar Graph | `/paper/{id}/references` | `/paper/{id}/citations` | Citation contexts and intent labels |
| OpenCitations | yes | yes | Open citation index, useful cross-check |
| Crossref | where the publisher deposited references | no | Filling specific holes |
| PhilPapers | own indexing | limited | Philosophy — has its own bibliographic logic |
| HAL, Cairn, OpenEdition, Persée | varies | limited | Francophone social sciences and humanities |
| Discipline-specific indexes | varies | varies | Ask what the field's own index is before assuming a generalist covers it |

Availability and shape of each API changes; verify before a batch run rather than trusting a remembered endpoint.
`[to verify]` for anything not checked in-session.

**Rule:** before phase 1, name the disciplines in scope and identify, for each, whether a generalist source covers it adequately.
Where it does not, add the discipline-specific source or declare the gap.

## 3. The books and humanities gap

This is not a marginal shortfall.
**The citation graph of books does not exist in any open database.**
In philosophy and much of the social sciences and humanities, the monograph and the edited-volume chapter are the primary publication formats.
A cascade run on OpenAlex in these fields does not miss a few references — it misses the dominant mode of publication.
Non-anglophone national journals fail similarly.

Compensation procedure, **required** whenever books or humanities are in scope:

- **Manual bibliography extraction** from the PDFs or physical copies of every key work that is a book or chapter.
  The bibliography is ground truth; the database is an approximation of it.
- **Non-citational discovery**: bibliographies of handbooks, of the Stanford Encyclopedia of Philosophy, of Annual Reviews and equivalent review series, and of syllabi where available.
  These are curated entry points into literatures the graph cannot see.
- **Log which key works got manual treatment and which relied on the database**, so the corpus's blind spots are locatable.

Forward citation to books is effectively unobtainable at scale.
Where a book is a key work, treat its forward set as a known gap and compensate through review series and through the citing sets of journal articles that discuss it.

## 4. OpenAlex mechanics

Base `https://api.openalex.org/works`; no key, add `mailto=` for the polite pool.

- **Backward**: the work object carries `referenced_works`, the list of OpenAlex IDs it cites — one request per key work.
  Equivalently `filter=cited_by:W<id>`.
- **Forward**: `filter=cites:W<id>`, a filtered query on `/works`, because the citing set is a property of other works and can be very large.
  Paginate with cursor paging (`cursor=*`, then `next_cursor`), not page numbers.

`cites:X` = works citing X. `cited_by:X` = works X cites.
These are inverted constantly.
Verify direction empirically on one work whose reference list is known before running a batch.

Useful fields for triage: `id,doi,title,publication_year,authorships,primary_location,type,cited_by_count,referenced_works,abstract_inverted_index`.
Abstracts arrive as an inverted index and need reconstructing.

Counts drift with indexing lag.
Record the retrieval date; a count is not a stable quantity.

## 5. Semantic Scholar, Crossref, OpenCitations

Semantic Scholar Graph base `https://api.semanticscholar.org/graph/v1/`.
Papers resolve by DOI (`DOI:10.xxxx/yyy`), arXiv ID or S2 ID; `/paper/{id}/references` and `/citations` paginate with `offset`/`limit`.
Request `contexts` and `intents` where available — the sentence surrounding a citation is what makes stance coding affordable.

Unauthenticated rate limits are a shared pool and have changed repeatedly.
Do not hard-code an assumed limit: throttle conservatively, honour 429 with exponential backoff, cache every response to disk so re-runs are free.

Crossref (`https://api.crossref.org/works/{doi}`) is backward-only and publisher-dependent.
OpenCitations is a useful cross-check when OpenAlex and S2 disagree on a reference list.

## 6. Lateral search procedure

The operation is conceptual, not mechanical, and it cannot be delegated to a query.

1. **Restate each thesis stripped of its home discipline's vocabulary.** Reduce it to the relation it asserts between what kinds of things.
2. **Re-express it in the lexicon of three or four neighbouring disciplines.** The same relation is routinely studied under different names — the point is to find the name, not to translate the words. Where the equivalent term is uncertain, search a handbook or encyclopedia of that discipline for the relation rather than the term.
3. **Search each vocabulary independently**, in that discipline's own sources.
4. **Record both lists**: disciplines interrogated, and disciplines within plausible reach that were not. The second list is what makes the partial regime honest.

Philosophy and the social sciences are the ones most often skipped and most often load-bearing — a large part of what a literature treats as settled empirical background turns out, laterally, to be a contested conceptual position.
Do not treat them as optional colour.

Run the lateral channel at phase 1 and again after each cascade round, since a new corpus reveals new vocabularies.

## 7. Forward-set overflow

A canonical work can have tens of thousands of citing works.
Enumerate all of it — metadata is cheap and the *shape* of the set is evidence — but read selectively.

- Keep the full forward set as a metadata file.
  Report its size and its distribution over time and venue type.
  A flat curve that spikes after a regulatory change is an axis-3 finding.
- Promote to T1: works engaging a thesis directly; all critical-stance works; the most-cited *k*; the most recent *m*.
- **Never sample at random and call it representative.**
  Citation practices are not random, and a random sample under-represents precisely the critical minority axis 2 depends on.

## 8. Citation stance coding

For each forward-channel record reaching T1 or T2:

| Stance | Meaning |
|---|---|
| `perfunctory` | Cited in passing as background furniture. No information about the thesis. |
| `affirming-applies` | Takes the thesis as settled and applies it. Evidence of diffusion, not validation. |
| `extending` | Modifies, narrows or conditions the core in response to something. Evidence *for* a progressive programme. |
| `rescuing` | Preserves the core against an anomaly with an auxiliary assumption. Evidence *for* degeneration. |
| `critical-empirical` | Reports evidence against the thesis. |
| `critical-theoretical` | Attacks the internal structure of the thesis. |
| `practitioner-uptake` | Textbook, regulator, handbook, consultancy, standard. Direct evidence for axis 3. |

The distribution is the raw material of the programme dossier.
Large `affirming-applies` mass, a visible `rescuing` set, and a `critical-empirical` set that is never answered: degeneration.
`critical-empirical` followed by `extending`: a progressive programme.

Where citation contexts are available, code from the context sentence.
Otherwise code from the abstract plus the paragraph containing the citation, and mark the coding `[C]` until the full text is checked.

This is the most expensive step in the whole protocol and the one the axis-2 verdict rests on.
Budget it explicitly; do not let it be absorbed silently.

## 9. Deduplication and versioned provenance

Merge on: DOI (lowercased, prefix stripped) → OpenAlex ID → normalised title plus year ±1 → manual review of near-matches.

Preprint and published version are one record with both identifiers, but keep both, since the forward channel returns citations to each separately and the counts must be summed.
Books: match on ISBN where present, otherwise title plus author plus edition — editions are a recurring source of false duplicates and of false distinctness.

When a work arrives from several key works or several channels, **keep all provenance entries** rather than overwriting.
Arriving independently by two routes is itself a relevance signal, and convergence between the cascade and the lateral channel is exactly what the path-dependence test looks for.

Every record carries the round and key-set version by which it entered.
When a key work is demoted, its records stay with their original provenance and the key work moves to the demoted register with its reason.

## 10. Depth 2

Not exhaustive — it explodes and dilutes.
Run it selectively from nodes meeting at least one condition:

- Cited by three or more key works (a shared ancestor, likely where a premise entered).
- Coded `critical-empirical` and apparently unanswered — chase its forward set to find whether a response exists elsewhere.
- Identified at axis 1 as the origin of a normative premise — chase its backward set to see whether the premise was ever argued for.

Record depth-2 entries with `prov_from_work` naming the depth-1 node, so the corpus stays auditable.

## 11. Search log

The search is part of the result.
Keep `search-log.md` alongside the ledger:

- Every query, vocabulary, source, date, result count.
- Which key works got manual bibliography extraction, which relied on databases.
- Disciplines interrogated laterally, and those not.
- Every format and source excluded by the scope boundary, so the reader can see what the corpus structurally cannot contain.
- Key-set versions per round, with what entered and what was demoted.
- Every failed or truncated query and what was done about it.

This log is what lets someone — including the user in six months — tell a gap in the literature from a gap in the search.
