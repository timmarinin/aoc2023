l ← •FLines "input_4.txt"
LenGame ← 2 + (⊑∘/ ": "⊸⍷)
DropGameXX ← LenGame⊸↓
Split ← ((¬-˜⊢×·+`»⊸>)∘≠⊔⊢)
SplitByPipe ← '|'⊸Split # from bqncrate
SplitBySpace ← ' '⊸Split # from bqncrate
Prepare ← { •ParseFloat¨¨ SplitBySpace¨ SplitByPipe DropGameXX 𝕩 }
Score ← { 𝕊 w‿n: 2⋆-⟜1 +´(n ∊ w) }
Part1 ← { +´ ⌊¨(Score∘Prepare)¨ 𝕩 }
# •Show Part1 l
# PART B
emptyRegistry ← (≠l)‿1 ⥊ 0
i ← 0
w‿n ← Prepare ⊑ l
UpdateRegistry ← { 𝕊 registry‿i‿w‿n:
    distribute ← +´ (n ∊ w) # new winning cards count
    copies ← i‿0 ⊑ registry
    start ← (i + 1)‿1 ⥊ 0
    patch ← distribute‿1 ⥊ copies
    end ← ((≠registry) - distribute + (≠ start))‿1 ⥊ 0
    diff ← (start ∾ patch ∾ end)
    registry +˘ diff
}
PrepareI ← { •ParseFloat¨¨ SplitBySpace¨ SplitByPipe DropGameXX 𝕩 }

# mutating the registry
registry ← (≠l)‿1 ⥊ 1

{
    𝕊 i:
    w‿n ← PrepareI (i ⊑ l)
    registry ↩ UpdateRegistry registry‿i‿w‿n
}¨ ↕≠l

partB ← +´ ⥊ registry

•Show partB
