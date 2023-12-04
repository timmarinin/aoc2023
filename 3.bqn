i ← •FLines "input_3.txt"

rowlen ← ≠ i
celllen ← ⌈´ ≠¨ i

m ← rowlen‿celllen ⥊ ∾ i
# General idea: find positions of all symbols (non-digits, non-dot),
# Then check neighbours for digits, merge numbers, sum.
IsSymbol ← ⊑∘>∘(¬ ∊ ⟜ ".0123456789")
symbols ← IsSymbol¨ m
N ← « ⋄ S ← » ⋄ E ← »˘ ⋄ W ← «˘ ⋄ SE ← »»˘ ⋄ NE ← «»˘ ⋄ NW ← ««˘ ⋄ SW ← »«˘
Neighbourhood ← { ∨´ (⟨n, s, e, w, se, ne, nw, sw⟩ {𝕎𝕩}¨ <𝕩) }
neighbours ← Neighbourhood symbols

IsDigit ← ≥⟜'0' ∧ ≤⟜'9'
digits ← IsDigit¨ m
digitsOnly ← { (IsDigit 𝕩) ⊑ ⟨'.', 𝕩⟩ }¨ m

pointers ← digits∧neighbours

GroupsOf1 ← { 𝕨(⊢∧∧(⊢∊/)·+`»⊸<∘⊢)𝕩 } # from bqncrate: Groups of ones in b1 pointed to by at least one 1 in a1
SplitByDot ← { '.'((¬-˜⊢×·+`»⊸>)∘≠⊔⊢) 𝕩 } # from bqncrate
# StartLen1 ← { -˜`˘∘‿2⥊/0(∾≠∾˜) 𝕩 }
# LengthsOf1 ← { -˜˝˘∘‿2⥊/0(∾≠∾˜) 𝕩 }
neededDigits ← pointers GroupsOf1˘ digits
neededDigitsMasked ← neededDigits { 𝕨 ⊑ ⟨'.', 𝕩⟩ }¨ digitsOnly

rowresult ← (+´ (•ParseFloat¨ SplitByDot))˘ neededDigitsMasked
•Show "Part A: "‿(+´ rowresult)

# PART B:
## General idea: check gear one-by-one
gearCandidates ← '*'⊸=¨ m

CheckGear ← {
    neighbours ← Neighbourhood 𝕩
    pointers ← digits∧neighbours
    neededDigits ← pointers GroupsOf1˘ digits
    neededDigitsMasked ← neededDigits { 𝕨 ⊑ ⟨'.', 𝕩⟩ }¨ digitsOnly
    partNumbers ← (< SplitByDot)˘ neededDigitsMasked
    partNumbers ↩ ∾ ((≠¨ partNumbers) > 0) / partNumbers
    ((≠partNumbers)=2) ⊑ ⟨⟨0⟩, (×´ •ParseFloat¨ partNumbers)⟩
}

flatGears ← ⥊ gearCandidates
gearIndices ← / flatGears

ratios ← ∾´ {
    (𝕩 CheckGear (rowlen‿celllen ⥊ (𝕩⊸= ↕≠flatGears)))
}¨ gearIndices

•Show "Part B: "‿(+´ ratios) 