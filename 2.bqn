l ← •FLines "input_2.txt"
f ← ⊑ l

WG ← (⊢ ↓˜ (+⟜2∘/ ": "⊸⍷)) # without Game xx:
game ← WG f
games ← WG¨ l
# r g b
colors ← ⟨"red", "green", "blue"⟩
cmap ← {
    red ⇐ 1‿0‿0
    green ⇐ 0‿1‿0
    blue ⇐ 0‿0‿1
}
Red ← cmap.red×•ParseFloat∘⊑
Green ← cmap.green×•ParseFloat∘⊑
Blue ← cmap.blue×•ParseFloat∘⊑
SecondAsBox ← <∘(1⊸⊑)
IndexColor ← ⊑ (colors ⊐ SecondAsBox)
ChooseColor ← (IndexColor)◶⟨Red, Green, Blue, ⊢⟩

separators ← ", "‿"; "
SplitIndices ← { 𝕨(⊢-˜+`×¬)⊸⊔𝕩 } # split 𝕩 word at indices indicated by 𝕨, from bqncrate
Search ← (≠ ∘ ⊢ ↑ ⍷)
Double1 ← (⊢∨») # 0 1 0 0 -> 0 1 1 0
Split ← {
    str ← 𝕩
    s ← (∨´ { Double1 𝕩 Search str }¨ separators) SplitIndices 𝕩
    f ← (1 ⌊¨ (≠¨s)) / s
    (' ' ⍷¨ f) SplitIndices¨ f
}
ColorMax ← >⌈˝

# PART A:

FindMaximumColor ← { ColorMax ChooseColor¨ Split 𝕩 }
targetBag ← 12‿13‿14
maxes ← FindMaximumColor game

Playable ← ∧´ targetBag ⊸ ≥

PossibleGames ← Playable¨ FindMaximumColor¨

# •Show +´ 1 + / PossibleGames games

# PART B:
×´¨ FindMaximumColor¨ games
PartB ← +´ (×´¨ FindMaximumColor¨)
•Show PartB games