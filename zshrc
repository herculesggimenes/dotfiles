# ── Homebrew ──────────────────────────────────────────────
eval "$(/opt/homebrew/bin/brew shellenv)"

# ── History ───────────────────────────────────────────────
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt SHARE_HISTORY
setopt APPEND_HISTORY

# ── Completion ────────────────────────────────────────────
autoload -Uz compinit && compinit
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' menu select

# ── Key bindings ──────────────────────────────────────────
bindkey -e
bindkey '^[[A' history-search-backward
bindkey '^[[B' history-search-forward

# ── Prompt ────────────────────────────────────────────────
autoload -Uz vcs_info
precmd() { vcs_info }
zstyle ':vcs_info:git:*' formats ' %F{magenta}(%b)%f'
setopt PROMPT_SUBST
PROMPT='%F{blue}%~%f${vcs_info_msg_0_} %F{yellow}>%f '

# ── Aliases ───────────────────────────────────────────────
alias ll="ls -lAh"
alias gst="git status"
alias gd="git diff"
alias gl="git log --oneline -20"
alias gp="git push"

# ── PATH ──────────────────────────────────────────────────
export PATH="$HOME/.local/bin:$PATH"

# ── fnm (Node version manager) ───────────────────────────
if command -v fnm &> /dev/null; then
  eval "$(fnm env --use-on-cd --shell zsh)"
fi

# ── SSH agent ─────────────────────────────────────────────
if [ -z "$SSH_AUTH_SOCK" ]; then
  eval "$(ssh-agent -s)" > /dev/null 2>&1
  ssh-add ~/.ssh/id_ed25519 2> /dev/null
fi
export PATH="/opt/homebrew/opt/libpq/bin:$PATH"
