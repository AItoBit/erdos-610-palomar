/- Copyright 2026 The Formal Conjectures Authors. Apache-2.0. -/
module

public import Mathlib.Combinatorics.SimpleGraph.Clique
public import Mathlib.Analysis.SpecialFunctions.Log.Basic
public import Mathlib.Analysis.SpecialFunctions.Sqrt
public import Mathlib.Order.Filter.AtTopBot.Basic

/-!
# Erdos 610: Clique Transversal Bounds

This Challenge records both questions and two known bounds from
https://www.erdosproblems.com/610, together with the supporting minimum API.
The corresponding research proofs in Solution are incomplete.

The statements are adapted from Formal Conjectures commit
1584447424bec3db6589383ce59a2798c2010ce7. The two literal `True` values replace
FC's `answer(True)` elaborator without changing the resulting propositions.
Definitions are inlined because Challenge imports must use the approved closure.
See README.md for the source references and the reported gap in JMRS21.
-/

@[expose] public section

namespace SimpleGraph

variable {V : Type*} {G : SimpleGraph V}

/-- A vertex set meeting every inclusion-maximal clique with at least two vertices.
Isolated vertices and the empty clique impose no requirement. -/
def IsCliqueTransversal (G : SimpleGraph V) (s : Set V) : Prop :=
  ∀ t : Set V, Maximal G.IsClique t → t.Nontrivial → (s ∩ t).Nonempty

/-- The whole vertex set meets every nontrivial maximal clique. -/
lemma isCliqueTransversal_univ (G : SimpleGraph V) : G.IsCliqueTransversal Set.univ := by
  sorry

/-- In an edgeless graph every set is a clique transversal. -/
lemma isCliqueTransversal_bot (s : Set V) : (⊥ : SimpleGraph V).IsCliqueTransversal s := by
  sorry

/-- The minimum number of vertices meeting every nontrivial maximal clique. -/
noncomputable def cliqueTransversalNum (G : SimpleGraph V) [Fintype V] : ℕ :=
  sInf {k | ∃ s : Finset V, G.IsCliqueTransversal (s : Set V) ∧ s.card = k}

variable [Fintype V]

/-- Any clique transversal bounds the minimum from above. -/
lemma cliqueTransversalNum_le_card {s : Finset V} (hs : G.IsCliqueTransversal s) :
    G.cliqueTransversalNum ≤ s.card := by
  sorry

/-- A finite graph has a clique transversal attaining the minimum. -/
lemma exists_cliqueTransversal_card_eq (G : SimpleGraph V) :
    ∃ s : Finset V, G.IsCliqueTransversal (s : Set V) ∧ s.card = G.cliqueTransversalNum := by
  sorry

/-- A bound on the minimum is equivalent to a transversal of bounded size. -/
lemma cliqueTransversalNum_le_iff {k : ℕ} :
    G.cliqueTransversalNum ≤ k ↔
      ∃ s : Finset V, G.IsCliqueTransversal (s : Set V) ∧ s.card ≤ k := by
  sorry

/-- The clique transversal number is at most the number of vertices. -/
lemma cliqueTransversalNum_le_card_univ (G : SimpleGraph V) :
    G.cliqueTransversalNum ≤ Fintype.card V := by
  sorry

/-- Isolated vertices do not contribute to the clique transversal number. -/
@[simp] lemma cliqueTransversalNum_bot : (⊥ : SimpleGraph V).cliqueTransversalNum = 0 := by
  sorry

/-- The graph with no vertices has clique transversal number zero. -/
@[simp] lemma cliqueTransversalNum_of_isEmpty [IsEmpty V] (G : SimpleGraph V) :
    G.cliqueTransversalNum = 0 := by
  sorry

end SimpleGraph

open Filter Real

namespace Erdos610

/-- The first question asks for a function tending to infinity such that every
sufficiently large graph has transversal number at most $n-\omega(n)\sqrt n$.
The function and threshold are uniform over all graphs. -/
theorem erdos_610.parts.i : True ↔
    ∃ ω : ℕ → ℝ, Tendsto ω atTop atTop ∧ ∀ᶠ n : ℕ in atTop,
      ∀ G : SimpleGraph (Fin n), (G.cliqueTransversalNum : ℝ) ≤ n - ω n * √n := by
  sorry

/-- The sharper question asks for an absolute $c>0$ such that every sufficiently
large graph satisfies $\tau(G)\leq n-c\sqrt{n\log n}$. This is the bound attributed
to JMRS21; the published-proof concern is recorded in the metadata. -/
theorem erdos_610.parts.ii : True ↔
    ∃ c : ℝ, 0 < c ∧ ∀ᶠ n : ℕ in atTop, ∀ G : SimpleGraph (Fin n),
      (G.cliqueTransversalNum : ℝ) ≤ n - c * √((n : ℝ) * log n) := by
  sorry

/-- The Erdos-Gallai-Tuza bound $\tau(G)\leq n-\sqrt{2n}+O(1)$, with one
constant for all finite graphs. -/
theorem erdos_610.variants.erdos_gallai_tuza :
    ∃ C : ℝ, ∀ n : ℕ, ∀ G : SimpleGraph (Fin n),
      (G.cliqueTransversalNum : ℝ) ≤ n - √(2 * (n : ℝ)) + C := by
  sorry

/-- Kim's Ramsey lower bound yields graphs of every sufficiently large order
with $\tau(G)\geq n-C\sqrt{n\log n}$ for one absolute $C>0$. -/
theorem erdos_610.variants.lower_bound :
    ∃ C : ℝ, 0 < C ∧ ∀ᶠ n : ℕ in atTop, ∃ G : SimpleGraph (Fin n),
      (n : ℝ) - C * √((n : ℝ) * log n) ≤ G.cliqueTransversalNum := by
  sorry

end Erdos610
