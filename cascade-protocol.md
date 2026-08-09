# Cascade protocol

Mechanics of the depth-1 backward/forward cascade: which source to use, how not to invert the directions, how to handle overflow, and how to record provenance.

## Contents

1. Direction semantics
2. Source selection and their known gaps
3. OpenAlex mechanics
4. Semantic Scholar and Crossref fallbacks
5. Overflow: when the forward set is too large
6. Citation stance coding (feeds axis 2 and 3)
7. Deduplication
8. Depth 2
9. Zotero integration
10. Recording the search itself

## 1. Direction semantics

- **Backward** = works the seed cites = its reference list = outgoing citations. Fixed at publication; complete for the seed's own view of its ancestry.
- **Forward** = works that cite the seed = incoming citations. Grows over time; must be re-run and re-dated if the review spans months.

These get inverted constantly, including in API parameter names. Verify direction empirically on one seed before running a batch: take a work you know the reference list of, query it, and check that what comes back is what it cites.

## 2. Source selection and their known gaps

| Source | Backward | Forward | Notes |
|---|---|---|---|
| OpenAlex | `referenced_works` on the work object | filtered query | Free, no key, best default. |
| Semantic Scholar Graph API | `/paper/{id}/references` | `/paper/{id}/citations` | Adds citation contexts and intent labels on some records. Unauthenticated rate limits are a shared pool and change; verify current limits before a batch run and back off on 429. |
| Crossref | reference lists where the publisher deposits them | not available | Deposit is publisher-dependent and patchy. |

No source is complete. Books, edited volumes, non-English work, working papers and grey literature are systematically under-indexed — which matters here, because heterodox and critical programmes publish disproportionately in exactly those formats. Running the cascade on one database and calling it exhaustive builds a corpus biased toward whatever that database indexes well.

Mitigation: run the cascade on OpenAlex, spot-check a sample of seeds against Semantic Scholar, and for the backward direction on any seed that matters, read the actual reference list from the PDF. The PDF is ground truth; the database is an approximation of it. Record which seeds got the PDF treatment.

## 3. OpenAlex mechanics

Base: `https://api.openalex.org/works`. No key required; add a `mailto=` parameter to get the polite pool.

**Backward** — the work object carries `referenced_works`, a list of OpenAlex IDs of works it cites. One request per seed retrieves the whole reference list. Equivalently, `filter=cited_by:W<seed>` returns works cited by the seed.

**Forward** — `filter=cites:W<seed>` returns works citing the seed. This is a filtered query on `/works`, not a field on the seed, because the citing set is a property of other works and can be very large. Paginate with cursor paging (`cursor=*`, then the `next_cursor` from each response) rather than page numbers, which have a depth ceiling.

The two filter names are easy to swap. `cites:X` = works that cite X. `cited_by:X` = works X cites. If a query on a well-known seed returns a handful of works when you expected thousands, you have them the wrong way round.

Fields worth requesting for triage: `id,doi,title,publication_year,authorships,primary_location,type,cited_by_count,referenced_works,abstract_inverted_index`. Abstracts come back as an inverted index and need reconstructing before they are readable.

Reported citing counts can drift slightly from `cited_by_count` because of indexing lag. Record the retrieval date; do not treat a count as a stable quantity.

## 4. Semantic Scholar and Crossref fallbacks

Semantic Scholar Graph API base: `https://api.semanticscholar.org/graph/v1/`. Papers resolve by DOI (`DOI:10.xxxx/yyy`), arXiv ID, or S2 paper ID. `/paper/{id}/references` and `/paper/{id}/citations` paginate with `offset`/`limit`; request `contexts` and `intents` where available — the surrounding sentence of a citation is what makes stance coding (§6) affordable.

Rate limits for unauthenticated use are shared across all anonymous traffic and have changed repeatedly. Do not hard-code an assumed limit: throttle conservatively, honour 429 with exponential backoff, and cache every response to disk so a re-run costs nothing.

Crossref (`https://api.crossref.org/works/{doi}`) is a backward-only fallback and only where the publisher deposited references. Useful for filling holes in OpenAlex on a specific seed, not as a primary source.

## 5. Overflow: when the forward set is too large

A canonical seed can have tens of thousands of citing works. Enumerating them all is still cheap (metadata only) and should be done, because the *shape* of that set is evidence. Reading them is not possible, so:

- Enumerate the full forward set and keep it as a metadata file. Report its size and its distribution over time and over venue types. A citation curve that is flat for twenty years and then spikes after a regulatory change is an axis-3 finding.
- For triage into T1, take: (a) all citing works whose title or abstract engages a thesis directly, (b) all citing works flagged critical or contrasting by stance coding, (c) the most-cited *k* citing works, and (d) the most recent *m*, so the corpus is not blind to the current state of the debate.
- Never sample the forward set at random and call it representative. Citation practices are not random and a random sample under-represents exactly the critical minority that axis 2 depends on.

## 6. Citation stance coding

For each forward-cascade record that reaches T1 or T2, code how it uses the seed:

| Stance | Meaning |
|---|---|
| `perfunctory` | Cited in passing, as background furniture. Carries no information about the thesis. |
| `affirming-applies` | Takes the thesis as settled and applies it. Evidence of diffusion, not of validation. |
| `extending` | Modifies or narrows the core in response to something. Evidence *for* a progressive programme. |
| `rescuing` | Preserves the core against an anomaly by adding an auxiliary assumption. Evidence *for* degeneration. |
| `critical-empirical` | Reports evidence against the thesis. |
| `critical-theoretical` | Attacks the internal structure of the thesis. |
| `practitioner-uptake` | Textbook, regulator, handbook, consultancy, industry standard. Direct evidence for axis 3. |

The stance distribution is the raw material for the programme dossier. A field with a large `affirming-applies` mass, a visible `rescuing` set, and a `critical-empirical` set that is never answered is the signature of degeneration. A field where `critical-empirical` is followed by `extending` is the signature of a progressive programme.

Where citation contexts are available from the API, code from the context sentence. Otherwise code from abstract plus the paragraph containing the citation, and mark the coding `[C]` until the full text has been checked.

## 7. Deduplication

Merge in this order:

1. DOI, lowercased, `https://doi.org/` prefix stripped.
2. OpenAlex ID.
3. Normalised title (lowercase, punctuation and diacritics stripped, whitespace collapsed) plus publication year ±1.
4. Manual review of remaining near-matches.

Preprint and published version of the same work are one record with both identifiers, not two — but keep both, because the forward cascade will return citations to each separately and the counts must be summed.

When a work arrives from several seeds, keep all provenance entries rather than overwriting. Arriving from several seeds independently is itself a relevance signal.

## 8. Depth 2

Depth 2 is not run exhaustively; it explodes and it dilutes. Run it selectively, from nodes that satisfy at least one of:

- The work is cited by three or more seeds (a shared ancestor — likely where a premise entered the literature).
- The work is coded `critical-empirical` and appears unanswered — chase its forward set to find whether the response exists elsewhere.
- The work is the origin of a normative premise identified at axis 1 — chase its backward set to find whether the premise was ever argued for.

Record depth-2 records with `provenance_direction` naming the depth-1 node they came from, so the corpus stays auditable.

## 9. Zotero integration

If a Zotero MCP connection is available, write the corpus there rather than to a loose CSV — the tags survive the review and are reusable.

- One collection per review, subcollections per tier or per programme.
- Tags: `review:<name>`, `tier:T1`, `prog:<id>`, `a1:normative-tacit`, `a2:degenerating`, `a3:contaminated`, `a4:causal-asserted`, `decision:exclude`, `stance:rescuing`.
- Attach the appraisal note to the item as a child note, keyed to the review name, so a work appraised in two reviews carries both codings.

Before relying on a Zotero plugin or connector, check the `strict_max_version` field in its `manifest.json` against the installed Zotero version. Popularity and maintainer reputation do not predict compatibility.

Write access matters here. A read-only integration means the appraisal lives outside the library and is lost the moment the conversation ends.

## 10. Recording the search itself

The search is part of the result. Record, in a `search-log.md` alongside the ledger:

- Every query string, source, date and result count.
- Which seeds got PDF-level reference extraction and which relied on the database.
- Every source and format excluded by the scope boundary, so the reader can see what the corpus structurally cannot contain.
- Every failed or truncated query, with what was done about it.

This log is what allows someone — including the user in six months — to distinguish a genuine gap in the literature from a gap in the search.
