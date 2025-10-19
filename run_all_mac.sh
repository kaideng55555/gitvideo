#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")"
if ! command_v=$(command -v brew); then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile || true
  eval "$(/opt/homebrew/bin/brew shellenv)" || true
fi
if ! command -v ffmpeg >/dev/null 2>&1; then
  brew install ffmpeg
fi
mkdir -p project && cd project
# Unpack packs if present
[ -f ../pixels_intro_MASTER_package.zip ] && unzip -o ../pixels_intro_MASTER_package.zip >/dev/null || true
[ -f ../pixels_intro_ONECLICK_render_scripts.zip ] && unzip -o ../pixels_intro_ONECLICK_render_scripts.zip >/dev/null || true
chmod +x render_pixels_intro_16x9.sh render_pixels_intro_9x16.sh 2>/dev/null || true
caffeinate -dimsu &
./render_pixels_intro_16x9.sh
./render_pixels_intro_9x16.sh
echo DONE; echo "renders in: $(pwd)/renders"
