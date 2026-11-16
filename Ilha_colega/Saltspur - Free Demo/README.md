# Saltspur — free demo (76 pixel-art assets, top-down pirate cove)

A free sample of Saltspur: the sand ↔ tropical grass ground set, a few dock planks, a small stake fence kit and pieces from every prop category. The full pack has 788 assets (the lagoon water and reef ground sets, a raised wooden pier, both plank floor families, the whole fence, and 13 to 34 pieces in every category).

## Sizes

**Every cell is 32×32 pixels.** Every file is a whole number of cells. `png/64px/` and `png/96px/` are exact 2× and 3× copies. `sheets/`: one sheet per piece size, slice at the size in its name, 0 margin, 0 spacing. `atlas.json` lists every asset's `x, y, w, h` (32-px sheets).

| folder | files | sizes (32-px version) |
|---|---|---|
| `ground/deck-planks/` | 3 | 32×32 (3) |
| `ground/sand-grass/` | 21 | 32×32 (21) |
| `walls/stake-fence/gate/` | 1 | 64×64 (1) |
| `walls/stake-fence/posts/` | 2 | 32×64 (2) |
| `walls/stake-fence/runs/` | 3 | 32×64 (2) · 32×32 (1) |
| `walls/stake-fence/side/` | 2 | 32×32 (2) |
| `props/barrels-crates/` | 2 | 32×32 (2) |
| `props/beach-junk-animals/` | 2 | 32×32 (2) |
| `props/buildings/` | 2 | 64×64 (2) |
| `props/cannons-anchors-lanterns/` | 2 | 64×64 (2) |
| `props/dock-gear/` | 2 | 64×64 (2) |
| `props/ferns-trees/` | 2 | 64×64 (2) |
| `props/ground-decals/` | 2 | 32×32 (2) |
| `props/palms-bushes/` | 2 | 64×32 (1) · 64×64 (1) |
| `props/rocks-coral/` | 2 | 32×32 (2) |
| `props/sacks-rope-cannonballs/` | 2 | 32×32 (2) |
| `props/sand-decals/` | 2 | 32×32 (2) |
| `props/scatter-bits/` | 2 | 32×32 (2) |
| `props/scatter-shells-coins/` | 2 | 32×32 (2) |
| `props/set-pieces/` | 2 | 96×96 (1) · 64×96 (1) |
| `props/shells-driftwood/` | 2 | 32×32 (2) |
| `props/small-boats/` | 2 | 32×64 (2) |
| `props/tavern-furniture/` | 2 | 32×32 (2) |
| `props/tavern-items/` | 2 | 32×32 (2) |
| `props/towers/` | 2 | 32×96 (1) · 64×96 (1) |
| `props/treasure-chests/` | 2 | 32×32 (2) |
| `props/treasure-loot/` | 2 | 32×32 (2) |
| `props/wreckage-bones/` | 2 | 32×32 (2) |

## The ground

`ground/sand-grass/` files are named `NN_CODE`: CODE is the terrain at the top-left, top-right, bottom-left and bottom-right corners (`s` beach sand, `g` tropical grass). Pick each cell by its four corners, or paint with the terrain brush: Godot `godot/pirate-cove.tres` terrain set 0 (lay `ssss` first), Tiled `tiled/ground.tsx` Wang set "Ground". Tested in Godot 4.4 and Tiled 1.11. Props stand on the bottom of their box: place them on a layer above the ground. In Godot set Default Texture Filter to **Nearest**.

## Licence

Free to use in your own games and apps, free or commercial. Don't resell or share the assets themselves, and don't use them to train AI. Full terms in `LICENSE.txt`.

## Made with AI assistance

The art was generated with the help of AI tools. Every asset was hand-picked and prepared for this pack.
