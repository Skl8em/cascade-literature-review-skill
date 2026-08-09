# Appraisal grid

Four axes. Two are coded per paper (1 and 4), two per research programme (2 and 3), with papers inheriting the programme verdict unless overridden with a stated reason.

Coding an axis is a reasoning gesture, not a checklist lookup. The indicators below are illustrative — they are the forms these problems most often take in the literatures where the grid was developed, not an exhaustive typology. When a paper does not resemble any indicator, that is not evidence it passes; work from the definition.

## Contents

1. Axis 1 — normative structure (per paper)
2. Axis 2 — programme dynamics (per programme)
3. Axis 3 — performative contamination (per programme × field)
4. Axis 4 — claim strength (per paper)
5. How the axes interact
6. Coding discipline and failure modes

---

## 1. Axis 1 — normative structure

**Codes:** `descriptive` | `normative-explicit` | `normative-tacit` | `indeterminate`

**The question is not whether a value premise is present.** Almost every paper about human arrangements rests on one. The question is whether the premise is *named* and whether it is presented as *contingent*.

**Procedure.** Restate the paper's central claim as a conditional: *if premise P, then conclusion Q*. Isolating P this way makes the P→Q relation testable in exactly the way a descriptive claim is testable, which is why explicit normativity is not a defect. Then test P on two conditions:

- **(a) Explicitness.** Is P stated, or does it arrive as shared common sense? A premise can be present in the prose and still fail this test if it is asserted as background rather than claimed. Watch particularly for premises that live in the *operationalisation* rather than the argument: the choice of objective function, the welfare measure, what counts as a cost, what enters the model and what is left as externality. A paper can be scrupulously neutral in its prose and carry its entire normative load in an equation. This is the most common way condition (a) is failed by careful authors.
- **(b) Contingency.** Is P presented as one option among alternatives that a reasonable person could hold, or as the only serious position? A premise that is named but treated as beyond dispute is not clarified; it is fortified. Signals: alternatives mentioned only to be dismissed in a sentence; the literature that holds the alternative premise cited only through its critics; the premise attributed to no one in particular ("it is widely accepted that").

Failing (a) or (b) is `normative-tacit`. Passing both is `normative-explicit`. Genuinely no value premise in the central claim — which is rarer than it looks and is most plausible for measurement and typology papers — is `descriptive`.

`indeterminate` is for papers where the central claim cannot be reconstructed as a conditional from the available text. Code it and say why; do not guess.

**Provenance of the premise.** When a paper is coded `normative-tacit`, run its backward cascade far enough to find where P entered the literature. Frequently P was argued for explicitly, once, in a paper from decades earlier, under conditions that have since been abandoned — and has been inherited as furniture ever since. Recording that lineage is more valuable to the review than the code itself, because it converts an accusation into a traceable claim.

---

## 2. Axis 2 — programme dynamics

**Codes:** `progressive` | `degenerating` | `indeterminate`. Coded once per research programme.

The question is sociological as much as epistemological: does the community carrying this theory have a functioning correction mechanism? Lakatos's distinction is the frame — a programme has a hard core protected by a belt of auxiliary hypotheses, and what matters is what happens to that belt when anomalies arrive.

**Progressive indicators.** The core is narrowed, conditioned or made more precise in response to anomalies. The programme predicts facts it was not built to explain, and some of those predictions survive testing. Scope conditions get stated: *this holds for these actors under these institutions*. Critical empirical results are answered on their own terms — replicated, bounded, or conceded.

**Degenerating indicators.** Auxiliary assumptions accumulate, each fitted to one anomaly and predicting nothing else. Disconfirmations are absorbed as measurement problems, or as failures of the world to satisfy the model's conditions. The core survives untouched across decades of contrary results. Critical work is cited perfunctorily or not at all — check whether the strongest published criticisms appear in the citing set of the programme's own papers, because a programme that does not cite its critics is not answering them.

**Evidence comes from the forward cascade**, specifically from the stance distribution (see `cascade-protocol.md` §6). The ratio of `extending` to `rescuing`, and the fate of the `critical-empirical` set, are the operational measure. Trace two or three anomalies through the citing literature and see what the programme did with them; this is more informative than any aggregate.

**Constraints on the verdict.** A programme needs time and a body of empirical confrontation before it can be judged. A programme younger than roughly a decade, or one that has not yet met a serious anomaly, is `indeterminate` — not `progressive` for lack of failures. Symmetrically, `indeterminate` is the honest code when the corpus is too thin to see the community's behaviour, and it must not drift toward `degenerating` because the reviewer finds the theory uncongenial.

A degenerating programme is not thereby false, and its empirical observations may be perfectly sound. The verdict bears on the warrant its conclusions carry, not on the truth of its propositions.

---

## 3. Axis 3 — performative contamination

**Codes:** `contaminated` | `independent` | `indeterminate`. Coded per programme × field of study.

The question: has the theory, by circulating, shaped the behaviour of the actors it claims to describe? Where it has, empirical confirmation obtained after diffusion cannot be read as an independently occurring regularity — the correct reading is that the theory structured the practice. Merton's self-fulfilling prophecy is the general form; MacKenzie's account of finance theory reshaping the markets it modelled is the developed case, with *Barnesian performativity* naming the case where use of the theory makes the world more like the theory's model, and *counterperformativity* the case where use makes it less so.

**Coding requires two things, both evidenced:**

- **A diffusion channel.** The actors were exposed: professional training, textbooks, certification syllabi, regulation and accounting standards that embed the model, software and instruments that implement it, consultancy practice, management doctrine. The `practitioner-uptake` stance code in the forward cascade is the direct evidence.
- **A feedback path into the measured quantity.** Exposure alone is not contamination. There must be a route by which the changed behaviour affects the variable the theory is tested on. A theory taught to everyone but tested on something the actors cannot influence is `independent`.

**Direction matters.** Where the feedback makes the model more accurate, subsequent confirmations are near-worthless as tests. Where the feedback works against the model, disconfirmations are equally compromised. Both are contamination; record which.

**Date the diffusion.** Contamination has a start. Empirical work on the field before diffusion is uncontaminated evidence and is often the most valuable material in the whole corpus — flag it in the ledger. This is why the time distribution of the forward cascade is worth plotting.

**The obvious contrast, offered as illustration only:** a field where the studied population has not read the theory that describes it differs structurally from one where the actors were trained on it and are evaluated against it. Domains vary continuously between these, and the code must rest on the two evidenced conditions above, not on a discipline's reputation.

---

## 4. Axis 4 — claim strength

**Codes:** `typological` | `correlational` | `causal-identified` | `causal-asserted`, plus `evidence_meets_bar`: `yes` | `partial` | `no`.

Code what the paper *claims*, then judge whether the evidence supports that level. The point of the axis is that the required standard of proof follows from the claim, so the two must be coded separately.

- `typological` — proposes a classification, a concept, a distinction. Bar: internal coherence, discriminating power, and whether cases can actually be sorted by it.
- `correlational` — reports association. Bar: sample and its boundary, robustness, whether the association is presented as such throughout.
- `causal-identified` — claims causation and offers an identification strategy: experiment, natural experiment, instrument, explicit mechanism traced through cases. Bar: does the strategy do what it claims, and does the identified effect apply to the population the conclusion addresses?
- `causal-asserted` — claims causation on correlational or purely theoretical evidence. The single most common failure. It is usually detectable in the shift between the results section and the conclusion: associations in one, mechanisms and policy implications in the other.

`causal-asserted` is not grounds for exclusion. It is grounds for restating the paper's claim at the level its evidence supports, and reporting it that way in the synthesis regardless of how the paper phrased it.

Also record the **population the evidence was built on** against the **population the conclusion addresses**. A result rigorous on its sample and silently universalised is methodologically sound and substantively false for everyone outside it — a failure invisible to any check performed inside the paper's own frame.

---

## 5. How the axes interact

Axes 2 and 3 are largely independent of axis 1. An openly normative theory can be a progressive programme working on an uncontaminated field; a theory descriptive in form can be degenerating and circular. Do not let a verdict on one axis propagate to the others by association — that is the mechanism by which a grid becomes a way of restating a prior judgement in four columns.

The combination that identifies the target failure — a theory imposed on a field, insulated from correction, confirmed by a practice it created — is `normative-tacit` + `degenerating` + `contaminated`. This is the exclusion criterion, and it is strong precisely because it requires three independent findings to coincide.

Axis 4 modulates rather than decides: it sets what the paper is allowed to be reported as saying.

---

## 6. Coding discipline and failure modes

**Code from the paper, not from its reputation.** Read the passage that carries the claim. A verdict formed from the abstract is `[C]`, not `[V]`.

**Record the evidence for each code.** One sentence and a locator per axis. A code without evidence cannot be contested, and an uncontestable code is not a finding.

**Falsification hook per programme verdict.** Write what would change it: a specific kind of result, a specific response to a specific anomaly. If nothing could change it, the verdict is not an assessment but a stance, and should be reported as such.

**Symmetry check.** After coding, take the programme the review is most sympathetic to and re-code it as if arguing against it. If it survives that with all four axes clean, either it genuinely is in good shape — which happens — or the grid was applied with different force in different directions. Report which of the two you concluded and why.

**Field knowledge counts as evidence.** Practitioner testimony, professional experience and knowledge produced outside the dominant academic centres bear directly on axis 3, where the question is what actors actually do, and on axis 2, where the question is how a community actually behaves. Such material is under-indexed by every citation database, so it will not arrive through the cascade. It has to be sought deliberately, and where it is used, its provenance should be as explicit as any journal citation.

**The grid's own limits.** It was built to catch a specific failure — a theory applied to a domain, insulated from correction, confirmed by the practice it produced. It is not sensitive to fraud, to statistical malpractice inside an otherwise progressive programme, to publication bias, or to a field whose whole question is badly posed. Where one of those is the live risk, say so in the review rather than reporting a clean grid as a clean bill of health.
