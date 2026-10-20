# datum.nvim

Datum.nvim is a LaTeX study tool designed to encourage quick and easy references between notes by allowing users to wrap LaTeX content in a "card" environment and reference it easily in other places, not just within the same `.tex` file but within the directory.

As I study for my engineering degree, I find myself more and more often needing to relate concepts not just within each field, but across disciplines as well. Lots of tools already exist in this vein, such as TiddlyWiki, Jon Sterling's Forester, or even good old Obsidian, but none of these had the benefit of full LaTeX typesetting. Datum.nvim is my attempt to address that gap.

Notes are `.tex` files in one directory; each note can hold cards (`\begin{card}{d:xxxx}`) that other notes embed by id.

IDs are intended to be opaque, and are generated randomly by `:Datum card`, although as of v0.1 you must still manually type `\begin{card}{}` and `\end{card}`. Cards can be referenced with `:Datum embed`, which opens a picker through `vim.ui.select` and fuzzy searches over note titles and card content.

Datum.nvim currently ships with only two very simple card types, `concept` and `recall`, with `recall` as the default if no type is given.

A fully defined card looks like:

```latex
\begin{card}[concept]{d:x4ra}
Some "concept" content goes here
\end{card}

\begin{card}{d:8g6e}  % defaults to recall
Some "recall" content goes here
\end{card}
```

## Requirements

- Neovim 0.10+
- LuaLaTeX
- LaTeX packages: `hyperref`, `cleveref`, `tcolorbox`

## Installation

- The nvim plugin must be installed
- datum.sty must be accesible by your compiler (see below for more detail)
- .tex files must compile with LuaLaTeX (You can set this on a per-file basis with `%! TeX program = lualatex` before the document class declaration in the preamble if you don't want to set LuaLaTeX as your default compiler)
- All TeX files will need `\usepackage{datum}` in their preamble (as of v0.1, this is NOT automated even when adding new slugs using `:Datum new`)


### lazy.nvim Installation

```lua
{
  "mustache-enthusiast/datum.nvim",
  cmd = "Datum",
  ft = "tex",
  opts = {
    dir = "~/datum", -- folder where your notes live
  },
}
```
### TeX File installation

Link the repo's `tex/` folder into your personal TeX tree (run from the repo root):

```bash
ln -s "$PWD/tex" "$(kpsewhich -var-value TEXMFHOME)/tex/latex/datum"
```

Or copy the files instead (you'll need to re-copy after updates):

```bash
mkdir -p "$(kpsewhich -var-value TEXMFHOME)/tex/latex/datum"
cp tex/datum.sty tex/datum-tex.lua "$(kpsewhich -var-value TEXMFHOME)/tex/latex/datum/"
```

TeX may skip a `latex/` or `lualatex/` directory whose only entry is a symlink. Check the install with `kpsewhich datum.sty` and try copying the file over if the symlink doesn't work, or creating another .sty or .cls file in one of those locations to force TeX to actually read the folder.


## Commands

| Command | Action |
| --- | --- |
| `:Datum new` | Create a note from a slug |
| `:Datum edit` | Open a note by slug |
| `:Datum card` | Insert a unique card id |
| `:Datum embed` | Pick a card and insert `\dembed{id}` (uses `vim.ui.select`) |
| `:Datum index` | Rebuild and print the note index |
| `:Datum index_nobuild` | Print the note index without rebuilding (debugging) |
| `:Datum dir` | Print the notes directory |

## LaTeX

| Macro | Action |
| --- | --- |
| `\datum{slug}` | Note id |
| `\tags{...}` | Note tags |
| `\begin{card}[recall\|concept]{d:xxxx}` | Card |
| `\dembed{d:xxxx}` | Embed a card |
| `\dref{slug}` | Link to a note's PDF |
