export PATH="$HOME/.local/bin:$PATH"

# Remove legacy nvm paths to avoid mixed Node tool resolution
PATH="$(printf '%s' "$PATH" | tr ':' '\n' | grep -vE "^$HOME/\\.nvm/versions/.*/bin$" | paste -sd: -)"
export PATH

# fnm for interactive non-login bash shells
if command -v fnm >/dev/null 2>&1; then
  eval "$(fnm env --use-on-cd --shell bash)"
fi

source ~/.safe-chain/scripts/init-posix.sh # Safe-chain bash initialization script

[[ "$TERM_PROGRAM" == "kiro" ]] && . "$(kiro --locate-shell-integration-path bash)"

# Avoid forcing editor in child tools (git rebase/commit, agents, etc).
unset EDITOR
unset VISUAL
unset GIT_EDITOR
unset GIT_SEQUENCE_EDITOR
