Split ← ((¬-˜⊢×·+`»⊸>)∘≠⊔⊢) # from bqncrate

input ← •FLines "./input_7.txt"
input_lines ← •ParseFloat⌾(1⊸⊑)¨  ' ' Split¨ input
hands ← 0⊑¨ input_lines
bets ← 1⊑¨ input_lines
orderingJ ← ⌽"AKQT98765432J"
ordering ← ⌽"AKQJT98765432"
HandType ← { +´⊒∧𝕩 }
HandTypeWithJokers ← {
    hand ← 𝕩
    jless ← ('J'≠hand)/hand
    jless ↩ ((≠jless)>0) ⊑ ⟨"A", jless⟩
    wl ← (⊑ ⍒ ⊒jless) ⊑ jless
    HandType (jless ∾ (((≠hand) - (≠jless)) ⥊ wl))
}

powers ← ⌽(13⋆(1 + ↕5))
HandPowers ← { ⊑ +´ (powers { 𝕨×((ordering⊐ 𝕩)+1) }¨ 𝕩)} # assign each hand a number
HandPowersJ ← { ⊑ +´ (powers { 𝕨×((orderingJ⊐ 𝕩)+1) }¨ 𝕩)} 
ranks ← 1 + (⍋ ⍋ {⟨HandType 𝕩, HandPowers 𝕩⟩} ¨ hands)
ranksJ ← 1 + (⍋ ⍋ {⟨HandTypeWithJokers 𝕩, HandPowersJ 𝕩⟩} ¨ hands)
part1← +´ (ranks × bets)
part2← +´ (ranksJ × bets)
•Show part1
•Show part2
# 253227540 is too high