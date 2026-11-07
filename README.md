# Git Tutorial

This repository hosts a beginner Git workshop for WHUAI students who have learned programming and are new to version control.

The workshop uses one small grade-calculator project and five guided exercises. Allow approximately **120 minutes**, with Git installed and a GitHub account prepared before class. Chapter 4 guides students through PAT setup before their first push.

The slides, student handout, and student exercises are in Traditional Chinese.

## Materials

| Material | PDF | LaTeX source |
| --- | --- | --- |
| Slides | [View slides](source.pdf) | [source.tex](source.tex) |
| Student handout | [View handout](handout.pdf) | [handout.tex](handout.tex) |

The handout includes numbered chapters, concept explanations, all five exercises, troubleshooting, and a final answer section with links to and from the questions. Body paragraphs indent by two Chinese characters. The PDF is built directly from `handout.tex`.

- [Student exercises](exercises/README.md): preparation, five exercises, success criteria, and reference answers.
- [Starter project](exercises/grade-lab): copy this outside the tutorial repository before initializing Git.

The sequence is: save and inspect versions → understand staging → undo a mistake → develop on a branch → resolve a conflict → push and review a pull request. Advanced history manipulation is reserved for follow-up study.

Stable IDs `S01`–`S31` and `A01`–`A03` identify the lesson slides. `S08a` combines excerpts of the Untracked and Not staged output (formerly `S08b`); `S08c` shows staged output. `S12a` introduces `git add .` after `.gitignore`. The handout uses these IDs to point to the relevant slides. Beamer also adds chapter navigation pages, and pauses create incremental PDF pages.

## How to build

1. Install [TeXLive](https://www.tug.org/texlive/) on your PC or Mac, and make sure the fonts listed below is properly installed:
    - Helvetica Neue
    - IBM Plex Sans SC (Text and SemiBold, used for missing Chinese glyphs)
    - Menlo
    - [IBM Plex Sans TC](https://github.com/IBM/plex/tree/master/packages/plex-sans-tc/fonts)
2. Build both editions from the repository root:

   ```bash
   latexmk -xelatex -bibtex- -interaction=nonstopmode -halt-on-error source.tex
   latexmk -xelatex -interaction=nonstopmode -halt-on-error handout.tex
   ```

   The existing slide theme, style, layout, colors, and fonts are retained. Bibliography processing is disabled because this lesson uses direct reference links rather than a bibliography database. The handout is self-contained LaTeX; no Markdown conversion or shell escape is needed. In `handout.tex`, body and code leading are 1.25 times the original spacing: the original 1.12 stretch becomes 1.40. Paragraph, list, and code-block gaps are configured separately.

   Both slides and the handout use IBM Plex Sans TC for Chinese text, with IBM Plex Sans SC Text/SemiBold as the fallback. The slide source reduces only the spacing below code blocks; upper spacing follows the original template. The shared theme and style files remain unchanged.
3. A Simplified Chinese edition is not currently included. To produce one, use [OpenCC](https://github.com/BYVoid/OpenCC) to convert a copy before compilation and review the terminology. Convert the handout and exercises too if distributing a fully localized workshop.
