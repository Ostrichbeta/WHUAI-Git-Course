# Git Tutorial

This repo hosts a Git tutorial slide for the WHUAI Team’s courses.

The compiled PDF can be found [here](source.pdf), or the Simplified Chinese version [here](source-sc.pdf).

There is only Traditional Chinese version, the Simplified Chinese version is automatically converted by program and the grammar may not be accurate.

## How to build

1. Install [TeXLive](https://www.tug.org/texlive/) on your PC or Mac, and make sure the fonts listed below is properly installed:
    - Helvetica Neue
    - PingFang TC
    - PingFang SC
    - [IBM Plex Sans TC](https://github.com/IBM/plex/tree/master/packages/plex-sans-tc/fonts)
2. Use latexmk or other tools to compile, make sure XeLaTeX is used.
3. If a Simplified Chinese PDF is needed, just convert using [OpenCC](https://github.com/BYVoid/OpenCC) before compilation.
