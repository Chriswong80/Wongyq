#!/bin/bash

# Configuration
SOURCE="slides.md"
OUTPUT="index.html"
BIB="references.bib"
THEME="serif"

echo "🚀 Building Slides..."

# The Pandoc One-Liner
pandoc -t revealjs -s "$SOURCE" -o "$OUTPUT" \
  --citeproc --bibliography="$BIB" \
  --katex \
  -V revealjs-url=https://unpkg.com/reveal.js@4 \
  -V theme="$THEME" \
  -V transition=none \
  -V width=\"90%\" \
  -V margin=0.1 \
  --include-in-header=custom-styles.html

echo "✅ Success: $OUTPUT generated."
