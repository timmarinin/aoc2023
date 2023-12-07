input ← •FChars "./input_5.txt"
SplitIndices ← (⊢-˜+`×¬)⊸⊔  # from bqncrate: split 𝕩 word at indices indicated by 𝕨
nl ← @+10
Split ← ((¬-˜⊢×·+`»⊸>)∘≠⊔⊢) # from bqncrate
Search ← (≠ ∘ ⊢ ↑ ⍷) # from bqncrate
SortRanges ← ((⍋1⊸⊑¨ ) ⊏ ⊢) # sort by second column
CanIndex ← {
    res ← 𝕨 ((0⊸≤)˜∧<) 𝕩
    # •Show res
 } # can 𝕨 index 𝕩
InPair ← { # w to check, x pair
    (𝕨 - 0⊑𝕩) CanIndex 1⊑𝕩
}
ParseMap ← { •ParseFloat¨¨ ' ' Split¨ 𝕩 }
#          dest source len
idRange ← ⟨0,   0,     0⟩


parts ← nl⊸Split¨ (⟨nl, nl⟩ Search input) SplitIndices input
seedsLine ← ⊑⊑ parts

# Part1 seeds are given as-is
seeds ← •ParseFloat¨ ({(' '⊸Split (≠ "seeds: ") ↓ 𝕩)} (⊑⊑ parts))
maps ← 1⊸↓¨(1↓parts)

Transform ← { (𝕨 - 1⊸⊑𝕩) + 0⊑𝕩 } # w - number, x - range
ApplicableRange ← { ⊑ (((𝕨 { (𝕨 - 1⊸⊑𝕩) }¨ 𝕩) CanIndex¨ 2⊑¨𝕩)/𝕩) ∾ ⟨idRange⟩ }
ApplyTransform2 ← { 𝕨 (⊣ Transform ApplicableRange)⌜ <𝕩 }
RunTransforms ← { ¯1 ⊑ ApplyTransform2` (⟨𝕩⟩ ∾ (ParseMap¨ maps)) }

part1 ← ⌊´ RunTransforms seeds
# •Show "Part 1: "‿part1

# PART 2
pairCount ← (≠seeds) ÷ 2
pairs ← <˘ (pairCount‿2) ⥊ seeds

Range2points ← {
    dest‿source‿len ← 𝕩
    ⍷∧⟨source, source + len⟩
}

maps2 ← ( ParseMap¨ (⥊maps))
InvertMap ← { {1‿0‿2 ⊏ 𝕩 }¨ 𝕩 }
MergeMaps ← {
    left ← 𝕩 ⋄ right ← 𝕨
    leftI ← InvertMap left
    lpoints ← ⍷ ∧ ∾ Range2points¨ left
    rpoints ← ⍷ ∧ ∾ Range2points¨ right
    rpointsInL ← rpoints ApplyTransform2 leftI
    
    poi ← ⍷ ∧ (lpoints ∾ rpointsInL)
    poiInLR ← (poi ApplyTransform2 left) ApplyTransform2 right
    lens ← -˜˝˘ (2↕ (poi ∾ (⌈´poi)))
    
    newPairs ← SortRanges poi ⋈˜¨ poiInLR
    newRanges ← SortRanges (newPairs ∾¨ lens)
    
    # verify that merged map works
    !∧´({
        x ← 𝕩
        original ← (x ApplyTransform2 left) ApplyTransform2 right
        merged ← x ApplyTransform2 newRanges
        ⊑ original=merged
    }¨ poi )

    newRanges
}

merged ← (MergeMaps´ (⌽maps2))
invertMerged ← SortRanges InvertMap merged
destinations ← 1⊑¨ invertMerged
starts ← destinations ApplyTransform2 invertMerged
matches ← { ∨´ 𝕩 InPair⌜ pairs }¨ starts
paired ← matches / starts
pairedD ← matches / destinations
•Show ⊑ pairedD