#!/usr/bin/env bqn
# Idea: replace "one" to "1ne"

l ← •FLines "input_1a.txt" # load as lines
words ← ⟨"one", "two", "three", "four", "five", "six", "seven", "eight", "nine"⟩
digits ← '1'+↕9

# from docs on find, returns indices where 𝕨 is in 𝕩
Search ← (≠ ∘ ⊢ ↑ ⍷) 
Split ← { 𝕨(⊢-˜+`×¬)⊸⊔𝕩 } # split 𝕩 word at indices indicated by 𝕨, from bqncrate
Interleave ← { ∾1↓⥊𝕨≍˘𝕩 } # insert 𝕨 between 𝕩 cells, from bqncrate
FirstLetterToNumber ← {
    matches ← Search⟜𝕩¨words
    mut ← 𝕩
    ProcessMatch ← {
        # change mut in place so each word-digit is replaced
        mut ↩ (𝕩 ⊑ digits) Interleave ((𝕩 ⊑ matches) Split mut)
    }
    ProcessMatch⌜ (⌽↕≠digits)
    mut
}
FirstLastDigits ← 0‿¯1⊸⊏(∊⟜('0'+↕10))⊸/ # repeats digit if it's single
•Show +´(•ParseFloat FirstLastDigits∘FirstLetterToNumber)⌜ l
