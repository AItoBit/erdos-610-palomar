# Erdos 610 Palomar Preparation

**Incomplete proof development. Not submitted to Palomar.**

This project states the clique-transversal bounds in Erdos Problem 610 and
provides eight proved basic lemmas about the definition. Its four research
theorems still contain `sorry`; no full solution or Palomar verification is
claimed. A passing Lean build does not remove those proof holes.

Alexander is the human project author and responsible maintainer, as confirmed
by the user. Codex generated the Lean code and submission files. Human
mathematical review has not been performed.

## Mathematical Content

A clique transversal meets every inclusion-maximal clique containing at least
two vertices. Isolated vertices do not have to be selected. Its minimum size
is `cliqueTransversalNum`.

The four research statements are:

1. A uniform bound `tau(G) <= n - omega(n) * sqrt(n)`, with `omega(n)` tending
   to infinity.
2. The sharper uniform bound `tau(G) <= n - c * sqrt(n * log(n))`, for one
   absolute positive constant `c` and all sufficiently large `n`.
3. The Erdos-Gallai-Tuza upper bound `tau(G) <= n - sqrt(2*n) + C`.
4. The matching existential lower bound `tau(G) >= n - C * sqrt(n * log(n))`.

The eight supporting lemmas establish that the full vertex set is a
transversal, every set works in an edgeless graph, each transversal bounds the
minimum, the minimum is attained, bounds have finite witnesses, the minimum
is at most the number of vertices, and it is zero for edgeless graphs and
empty vertex types. These lemmas do not establish the four research bounds.

The statements and supporting proofs are adapted from
[Formal Conjectures PR 7140](https://github.com/google-deepmind/formal-conjectures/pull/7140)
at commit `1584447424bec3db6589383ce59a2798c2010ce7`. Both definitions are
inlined in each module so the Challenge imports only Mathlib. The FC
`answer(True)` wrappers become literal `True`, preserving their resulting
types. No external proof of the four research bounds has been copied or imported.

## Literature Status

The [problem page](https://www.erdosproblems.com/610) attributes the positive
answers to the clique-colouring result of
[Joret, Micek, Reed and Smid](https://arxiv.org/abs/2006.11353v2).
An [August 2026 discussion](https://www.erdosproblems.com/forum/thread/610#post-8594)
reports a gap in that published proof. This project does not resolve the
reported gap, refute the theorem, or claim a complete verification of that
paper. The original FC contribution remains a draft for this reason.

## Verification

`lean-toolchain` and `lake-manifest.json` pin Lean and Mathlib to
`v4.35.0-rc2`, meeting Palomar's current minimum toolchain version.
The original FC files passed strict builds with Lean/Mathlib `4.33.1`.
The new GitHub workflow builds the standalone pair with the pinned target
toolchain and runs `Audit.lean` to print every advertised theorem's axioms.

`scripts/check_axioms.py` rejects missing reports and any axiom not listed in
`comparator.json`. The four research declarations currently depend on
`sorryAx`, so this readiness check is expected to fail. This check does not
replace Comparator or full Palomar verification.

`comparator.json` includes all twelve theorems and both definitions. Challenge
holes are deliberate statements; Solution holes are unfinished proofs.
The full Palomar workflow is pinned to
`d4e41c1d5b0d114c4859e6e5831dc6d3ad1d0d44` in both its reference and
`pipeline_commit` input, with mode `full` and profile `palomar-standard-v1`.

## Before Submission

Complete all four research proofs, resolve their mathematical dependencies,
update the status metadata, and rerun the axiom audit. Push a fixed full
40-character commit SHA and dispatch Full Palomar Preflight for that exact
snapshot. Intake requires its mechanical report to say `status: pass`.

Submissions go through https://submit.palomar-registry.org/. Follow
[Palomar's requirements](https://palomar-registry.org/how-to-submit) and
[agent protocol](https://submit.palomar-registry.org/llms.txt). Agents use
the HTTPS/tag/secret-gist route. Registration follows review and requires
the user's decision on the specific review and permanent public record.

The repository is licensed under Apache-2.0. Cited mathematical papers and
other source materials retain their own terms.
