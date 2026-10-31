skill := "cascade-literature-review"

# List capabilities
default:
    @just --list

# Check that every references/ file cited in SKILL.md exists, and vice versa
check:
    #!/usr/bin/env bash
    set -euo pipefail
    cd {{skill}}
    status=0
    for f in $(grep -o 'references/[a-z-]*\.md' SKILL.md | sort -u); do
        [ -f "$f" ] || { echo "cited but missing: $f"; status=1; }
    done
    for f in references/*.md; do
        grep -q "$f" SKILL.md || { echo "present but not cited: $f"; status=1; }
    done
    exit $status

# Build the distributable archive in dist/
build: check
    mkdir -p dist
    rm -f dist/{{skill}}.skill
    zip -qr dist/{{skill}}.skill {{skill}} -x '*.DS_Store'
    @unzip -l dist/{{skill}}.skill

# Symlink the skill into ~/.claude/skills for local use (refuses to overwrite)
install:
    ln -s "$PWD/{{skill}}" "$HOME/.claude/skills/{{skill}}"
