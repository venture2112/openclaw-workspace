# Memory Bank Skill (OpenClaw)
**Version:** 1.0.0

Build persistent, searchable knowledge bases from documents — PDFs, transcripts, links, or pasted text. Each bank grows over time as you feed it more sources.

## Installation
1. Drop the `memory-bank/` folder into your OpenClaw `skills/` directory (or import via your Skills Repository zip installer).
2. No API keys required.
3. No configuration required.

## Usage
Type `/memory bank` in chat with your bot.

### Standard flow
1. Choose input method: **(A) Paste text / (B) Share link / (C) VPS path**
2. Choose bank: **existing** or **new**
3. The bot ingests the source, updates the KB, logs the index, and confirms.

### Shortcut (one-liner)
Send everything at once:

> `/memory bank — Shadow Workshop — here's the link: https://…`

The bot will skip menus and process directly.

## Supported inputs
- **Paste text** (best for transcripts)
- **Share link** (best for PDFs)
  - Google Drive, Dropbox, or any public direct URL
- **VPS file path** (if the file already exists on the server)

### Telegram note (important)
Telegram **document attachments are not auto-downloaded** by this skill. If you upload a PDF into Telegram, the bot will ask you to use one of the supported input methods instead.

### Slides note (important)
Google Slides / PPTX links often export placeholder notes instead of real slide text. **Export decks to PDF first**, then bank the PDF.

## Where banks are stored

```
memory/banks/
  {bank_name}/
    knowledge-base.md  (append-only)
    index.md           (append-only)
    sources/           (original files + extracted text)
    recaps/            (workshop mode recaps)
```

## Workshop mode
Workshop mode auto-generates **summary + action steps** every time.

Trigger workshop mode by:
- Using `/memory bank workshop`, OR
- Naming your bank with “Workshop” or “Session”, OR
- Saying “workshop mode”.

## Shadow Workshop (7-day series)
Use one bank for the full series:
- **Day 1:** create bank `Shadow Workshop`
- **Days 2–7:** append to existing `Shadow Workshop`

Files are automatically named `Day1-…`, `Day2-…`, etc., and recaps are saved as `recaps/DayX-recap.md`.

## Support
https://nicelysupport.com