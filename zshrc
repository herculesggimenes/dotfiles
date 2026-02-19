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
# Homebrew ships many completion definitions here (gh, docker, git, pnpm, ...)
fpath=(/opt/homebrew/share/zsh/site-functions $fpath)
autoload -Uz compinit && compinit
zstyle ':completion:*' menu select
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/.zcompcache
zstyle ':completion:*' matcher-list \
  'm:{a-z}={A-Z}' \
  'r:|=*' \
  'l:|=* r:|=*'
zstyle ':completion:*' completer _extensions _complete _approximate
zstyle ':completion:*:approximate:*' max-errors 1 numeric
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' group-name ''
zstyle ':completion:*' verbose yes

# ── Key bindings ──────────────────────────────────────────
bindkey -e
bindkey '^[[A' history-search-backward
bindkey '^[[B' history-search-forward

# ── fzf shell integration ─────────────────────────────────
if [ -f /opt/homebrew/opt/fzf/shell/completion.zsh ]; then
  source /opt/homebrew/opt/fzf/shell/completion.zsh
fi
if [[ -o interactive ]] && [[ -t 0 ]] && [[ -t 1 ]]; then
  if [ -f /opt/homebrew/opt/fzf/shell/key-bindings.zsh ]; then
    source /opt/homebrew/opt/fzf/shell/key-bindings.zsh
  fi
fi

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

# Remove legacy nvm paths to avoid mixed Node tool resolution
path=(${path:#$HOME/.nvm/versions/*/bin})

# ── zoxide (smarter cd) ───────────────────────────────────
if command -v zoxide &> /dev/null; then
  eval "$(zoxide init zsh)"
fi

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

# ── Atuin (shell history search/sync) ─────────────────────
# Keep your up-arrow history search mapping and let Atuin own Ctrl-R.
if [[ -o interactive ]] && [[ -t 0 ]] && [[ -t 1 ]] && command -v atuin &> /dev/null; then
  eval "$(atuin init zsh --disable-up-arrow)"
fi

# ── Zsh Autosuggestions ───────────────────────────────────
if [ -f /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]; then
  source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
  ZSH_AUTOSUGGEST_STRATEGY=(history completion)
  bindkey '^[[C' autosuggest-accept
fi

# ── Zsh Syntax Highlighting (keep near end of file) ─────
if [ -f /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
  source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

# Avoid forcing editor in child tools (git rebase/commit, agents, etc).
unset EDITOR
unset VISUAL
unset GIT_EDITOR
unset GIT_SEQUENCE_EDITOR
