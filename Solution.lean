/- Copyright 2026 The Formal Conjectures Authors. Apache-2.0. -/
module

public import Mathlib.Combinatorics.SimpleGraph.Clique
public import Mathlib.Analysis.SpecialFunctions.Log.Basic
public import Mathlib.Analysis.SpecialFunctions.Sqrt
public import Mathlib.Order.Filter.AtTopBot.Basic

/-!
# Incomplete Solution for Erdos 610

The eight supporting lemmas are proved. The four research statements still
contain unresolved proof holes and cannot pass Palomar verification.
The targets and API are adapted from Formal Conjectures commit
1584447424bec3db6589383ce59a2798c2010ce7 under Apache-2.0.
No external claimed proof or assumed literature theorem is imported.
-/

@[expose] public section

namespace SimpleGraph

variable {V : Type*} {G : SimpleGraph V}

/-- A set meeting every nontrivial maximal clique of a graph. -/
def IsCliqueTransversal (G : SimpleGraph V) (s : Set V) : Prop :=
  ∀ t : Set V, Maximal G.IsClique t → t.Nontrivial → (s ∩ t).Nonempty

lemma isCliqueTransversal_univ (G : SimpleGraph V) : G.IsCliqueTransversal Set.univ := by
  intro t _ ht
  simpa using ht.nonempty

lemma isCliqueTransversal_bot (s : Set V) : (⊥ : SimpleGraph V).IsCliqueTransversal s := by
  intro t ht hnt
  exact (hnt.not_subsingleton ht.1.subsingleton).elim

/-- The least size of a clique transversal, ignoring isolated vertices. -/
noncomputable def cliqueTransversalNum (G : SimpleGraph V) [Fintype V] : ℕ :=
  sInf {k | ∃ s : Finset V, G.IsCliqueTransversal (s : Set V) ∧ s.card = k}

variable [Fintype V]

lemma cliqueTransversalNum_le_card {s : Finset V} (hs : G.IsCliqueTransversal s) :
    G.cliqueTransversalNum ≤ s.card :=
  Nat.sInf_le ⟨s, hs, rfl⟩

lemma exists_cliqueTransversal_card_eq (G : SimpleGraph V) :
    ∃ s : Finset V, G.IsCliqueTransversal (s : Set V) ∧ s.card = G.cliqueTransversalNum := by
  have hne : {k | ∃ s : Finset V, G.IsCliqueTransversal (s : Set V) ∧ s.card = k}.Nonempty :=
    ⟨_, Finset.univ, by simpa using G.isCliqueTransversal_univ, rfl⟩
  exact Nat.sInf_mem hne

lemma cliqueTransversalNum_le_iff {k : ℕ} :
    G.cliqueTransversalNum ≤ k ↔
      ∃ s : Finset V, G.IsCliqueTransversal (s : Set V) ∧ s.card ≤ k := by
  constructor
  · intro h
    obtain ⟨s, hs, hcard⟩ := G.exists_cliqueTransversal_card_eq
    exact ⟨s, hs, hcard.trans_le h⟩
  · rintro ⟨s, hs, hcard⟩
    exact (cliqueTransversalNum_le_card hs).trans hcard

lemma cliqueTransversalNum_le_card_univ (G : SimpleGraph V) :
    G.cliqueTransversalNum ≤ Fintype.card V := by
  simpa using cliqueTransversalNum_le_card
    (s := Finset.univ) (by simpa using G.isCliqueTransversal_univ)

@[simp] lemma cliqueTransversalNum_bot : (⊥ : SimpleGraph V).cliqueTransversalNum = 0 := by
  apply Nat.eq_zero_of_le_zero
  simpa using cliqueTransversalNum_le_card (G := (⊥ : SimpleGraph V)) (s := ∅)
    (by simpa using isCliqueTransversal_bot (∅ : Set V))

@[simp] lemma cliqueTransversalNum_of_isEmpty [IsEmpty V] (G : SimpleGraph V) :
    G.cliqueTransversalNum = 0 := by
  apply Nat.eq_zero_of_le_zero
  simpa using G.cliqueTransversalNum_le_card_univ

end SimpleGraph

open Filter Real

namespace Erdos610

/-- Pending proof of the first uniform bound. -/
theorem erdos_610.parts.i : True ↔
    ∃ ω : ℕ → ℝ, Tendsto ω atTop atTop ∧ ∀ᶠ n : ℕ in atTop,
      ∀ G : SimpleGraph (Fin n), (G.cliqueTransversalNum : ℝ) ≤ n - ω n * √n := by
  sorry

/-- Pending proof of the sharper uniform bound. -/
theorem erdos_610.parts.ii : True ↔
    ∃ c : ℝ, 0 < c ∧ ∀ᶠ n : ℕ in atTop, ∀ G : SimpleGraph (Fin n),
      (G.cliqueTransversalNum : ℝ) ≤ n - c * √((n : ℝ) * log n) := by
  sorry

/-- Pending proof of the Erdos-Gallai-Tuza bound. -/
theorem erdos_610.variants.erdos_gallai_tuza :
    ∃ C : ℝ, ∀ n : ℕ, ∀ G : SimpleGraph (Fin n),
      (G.cliqueTransversalNum : ℝ) ≤ n - √(2 * (n : ℝ)) + C := by
  sorry

/-- Pending proof of the matching lower bound. -/
theorem erdos_610.variants.lower_bound :
    ∃ C : ℝ, 0 < C ∧ ∀ᶠ n : ℕ in atTop, ∃ G : SimpleGraph (Fin n),
      (n : ℝ) - C * √((n : ℝ) * log n) ≤ G.cliqueTransversalNum := by
  sorry

end Erdos610
