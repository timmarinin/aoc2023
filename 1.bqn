#!/usr/bin/env bqn

l ← •FLines "input_1a.txt" # load as lines
Line ← 0‿¯1⊸⊏(∊⟜('0'+↕10))⊸/
•Show +´(•ParseFloat Line)¨ l
