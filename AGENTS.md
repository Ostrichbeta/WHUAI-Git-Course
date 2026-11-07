# Editing this tutorial

- Before writing or revising Chinese prose, consult the user's DeepSeek service for wording and editing. Use model `deepseek` at `http://192.168.13.120:8907/v1/chat/completions`, with the key read from the `LUOJIA_API_KEY` environment variable. Never print or save the key.
- Keep the existing Traditional Chinese script. Use the original tutorial as a style reference: natural, precise technical Chinese, with consistent terminology and no translated-sounding slogans.
- Keep Git terms such as commit and branch in English, and typeset branch names in monospace. Use IBM Plex Sans SC as the Chinese fallback font.
- Review DeepSeek's suggestions for technical accuracy. Preserve commands, examples, exercise sequence, and alignment between slides and handouts unless the requested change requires otherwise.
- Write and edit the student handout directly in `handout.tex`, using native LaTeX and configuring its line spacing there; build `handout.pdf` directly from that source. Do not track `handout.md` in Git or link to it as a repository document. Retain the existing slide sources and complete exercise guide. Do not delete or replace them unless the user explicitly requests that action. Do not reintroduce speaker-note editions unless requested.
- Preserve the existing LaTeX theme, style files, fonts, colors, and layout. Edit teaching content using modification tools such as `apply_patch`.
