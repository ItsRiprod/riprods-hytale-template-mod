#!/usr/bin/env bash
# Turn this template into a new mod.
#
#   ./init.sh <ModName> ["Short description"]
#
# ModName must be PascalCase (e.g. Yeetly). It becomes the main class, mod id, jar name and
# GitHub repo name; its lowercase form becomes the package (com.riprod.<modname>) and artifact id.
# Runs once: it deletes TEMPLATE.md and itself when done.
set -euo pipefail
cd "$(dirname "$0")"

if [[ $# -lt 1 || $# -gt 2 ]]; then
    echo "Usage: ./init.sh <ModName> [\"Short description\"]" >&2
    exit 1
fi

NAME="$1"
DESC="${2:-$1 for Hytale}"
LOWER="$(tr '[:upper:]' '[:lower:]' <<<"$NAME")"

if [[ ! "$NAME" =~ ^[A-Z][A-Za-z0-9]*$ ]]; then
    echo "ModName must be PascalCase letters/digits, starting with a capital (got '$NAME')." >&2
    exit 1
fi
if [[ "$DESC" == *'"'* || "$DESC" == *'\'* ]]; then
    echo "Description can't contain double quotes or backslashes (it goes into manifest.json)." >&2
    exit 1
fi
if [[ ! -f src/main/java/com/riprod/template/Template.java ]]; then
    echo "Already initialised (src/main/java/com/riprod/template/Template.java is gone)." >&2
    exit 1
fi

export NAME LOWER DESC

# Rewrite placeholders in every text file except this script, the wrapper and build output.
find . -type f \
    -not -path './.git/*' -not -path './build/*' -not -path './.gradle/*' -not -path './run/*' \
    -not -name 'init.sh' -not -name 'TEMPLATE.md' -not -name 'gradlew*' \
    -not -name '*.jar' -not -name '*.png' -print0 |
    xargs -0 perl -pi -e 's/Template/$ENV{NAME}/g; s/template/$ENV{LOWER}/g; s/__DESCRIPTION__/$ENV{DESC}/g'

mv src/main/java/com/riprod/template/Template.java "src/main/java/com/riprod/template/$NAME.java"
mv src/main/java/com/riprod/template "src/main/java/com/riprod/$LOWER"

rm -f TEMPLATE.md init.sh

# Start fresh: drop the template's git history/remote and any stale build output copied along.
rm -rf .git bin build .gradle
git init -q -b main

echo "Initialised $NAME (package com.riprod.$LOWER) with a fresh git repo on 'main'."
echo "Next: fill in publishing IDs in gradle.properties, then ./gradlew build"
echo "To push: git remote add origin <url> && git add -A && git commit -m 'Initial commit' && git push -u origin main"
