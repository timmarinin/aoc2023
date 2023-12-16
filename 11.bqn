input ← •FLines "./input_11.txt"
rowcount ← ≠input ⋄ colcount ← ≠⊑input
map ← (≠input)‿(≠⊑input)⥊∾(<".#") ⊐¨input
# not 1m, because +1 comes from grid itself
cols ← 999999 × 0=+˝map # part1 1× ...
rows ← 999999 × 0=+˝˘map # part1: 1× ...
 
positions ← (↕rowcount) ∾⌜ (↕colcount)
stars ← (0<≠¨⥊map/¨positions) / (⥊map/¨positions)
Expand ← { 𝕩 + (+´(0⊑𝕩)↑rows)‿(+´(1⊑𝕩)↑cols) }
expanded_stars ← Expand¨ stars
Manhattan ← { x1‿y1 𝕊 x2‿y2: (|(x2-x1))+(|(y2-y1)) }
part1←(+´⥊(expanded_stars Manhattan⌜ expanded_stars))÷2
•Show part1