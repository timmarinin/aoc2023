input ← •FLines "./input_8.txt"
instructions ← ⊐⊑input ⋄ len ← ≠ instructions
# Part 1:
# Idea: traverse graph with mutations to keep track of values

Parse ← { 𝕊:
    lines ← ∧2↓input
    Grab ← { ⥊ ⟨0‿1‿2, 7‿8‿9, 12‿13‿14⟩ ⊑¨¨ <<𝕩 }
    parsed ← ∘‿3 ⥊ ∾ (Grab¨ lines)
    titlesS‿leftsS‿rightsS ← ⟨0⊏˘parsed, 1⊏˘parsed, 2⊏˘parsed⟩
    Index ← { ⊑(titlesS ⊐ <𝕩) }
    titles ← ⊐ titlesS
    lefts ← Index¨ leftsS
    rights ← Index¨ rightsS
    titles‿lefts‿rights
}

Walk ← {
    titles‿lefts‿rights ← 𝕩
    pc ← 0
    ends‿node ← 𝕨
    steps ← 0

    Next ← {
        𝕊:
        steps 1⊸+ ↩ ⋄
        lr ← pc ⊑ instructions ⋄
        node ↩ node ⊑ lr ⊑ ⟨lefts, rights⟩ ⋄
        pc ↩ len|(pc+1)
    }
    NotReachedzzz ← { 𝕊: ¬ ∨´(⥊(node ∊ ends)) }
    Next •_while_ NotReachedzzz @
    steps
}

# •Show "Steps: "‿(Walk (Parse @))

# Part 2: simultaneous traversal


Parse2 ← {
    lines ← 𝕩
    Grab ← { ⥊ ⟨0‿1‿2, 7‿8‿9, 12‿13‿14⟩ ⊑¨¨ <<𝕩 }
    parsed ← ∘‿3 ⥊ ∾ (Grab¨ lines)
    titlesS‿leftsS‿rightsS ← ⟨0⊏˘parsed, 1⊏˘parsed, 2⊏˘parsed⟩
    Index ← { ⊑(titlesS ⊐ <𝕩) }
    titles ← ⊐ titlesS
    lefts ← Index¨ leftsS
    rights ← Index¨ rightsS
    starts ← / (('A'=¯1⊸⊑)¨titlesS)
    ends ← / (('Z'=¯1⊸⊑)¨titlesS)
    titles‿lefts‿rights‿starts‿ends
}

# titles‿lefts‿rights‿starts‿ends ← Parse2 @
Walk3 ← {
    titles‿lefts‿rights‿starts‿ends ← 𝕩
    lens ← { ends‿𝕩 Walk titles‿lefts‿rights }¨ starts
}

•Show •math.LCM´ Walk3 (Parse2 ∧2↓input)
# •Show "Steps Ghosts: "‿(Walk2 (Parse2 @))


# what if we merge for each node the program
# what if we work on suffixes
