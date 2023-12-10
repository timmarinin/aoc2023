input ← •FLines "./input_9.txt"
Split ← ((¬-˜⊢×·+`»⊸>)∘≠⊔⊢) # from bqncrate
lines ← •ParseFloat¨¨ (' ' Split¨ input)
line ← 1⊑lines
NextLine ← 1↓+`⁼ # from bqncrate
FindNext ← { 𝕊 𝕩:
    self ← 𝕤 ⋄ line ← 𝕩 ⋄ next ← NextLine line ⋄ last ← ¯1 ↑line
    isConst ← ∧´ (⊣=1⊸⌽) next
    diff ← (¬isConst)◶⟨{ 𝕊𝕩: ⊑next }, { 𝕊: Self next }⟩ @
    last + diff
}
FindPrev ← { 𝕊 𝕩:
    self ← 𝕤 ⋄ line ← 𝕩 ⋄ next ← NextLine line ⋄ first ← 1 ↑line
    isConst ← ∧´ (⊣=1⊸⌽) next
    diff ← (¬isConst)◶⟨{ 𝕊𝕩: ⊑next }, { 𝕊: Self next }⟩ @
    first - diff
}

JoinNext ← ⊣∾FindNext
•Show +´∾´ FindNext¨ lines
•Show +´∾´ FindPrev¨ lines