input ← •FLines "./input_6.txt"
Split ← ((¬-˜⊢×·+`»⊸>)∘≠⊔⊢) # from bqncrate

times‿records ← •ParseFloat¨¨ 1↓¨ ' ' Split¨ input

# BRUTEFORCE
Dist ← ⊣ (⊢×-)¨ (1+↕∘-⟜1)
Winning ← { 𝕨 < (Dist 𝕩) }

part1 ← ×´ records (+´∘Winning)¨ times

•Out •Fmt part1

# part2
time‿record ← •ParseFloat¨ ∾¨ 1↓¨ ' ' Split¨ input

# BRUTEFORCE:
# part2 ← record (+´∘Winning) time

# ELEGANTFORCE: find roots of record and beat them by nudging to next integer
Eval ← {
    r ← 𝕩 + 0.001 # add a bit in case x_1 or x_2 of true 𝕩 are integers
    d ← (𝕨⋆2) - 4×r # discriminant
    x_1 ← (-⟜𝕨 + √d) ÷ ¯2
    x_2 ← (-⟜𝕨 - √d) ÷ ¯2
    x_min ← ⌈(x_1 ⌊ x_2)
    x_max ← ⌊(x_1 ⌈ x_2)
    (x_max - x_min) + 1 # inclusive
}

part2e ← time Eval record
⋄
•Out •Fmt part2e