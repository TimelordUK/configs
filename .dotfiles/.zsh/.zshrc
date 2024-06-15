# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zsh/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export DISABLE_AUTO_TITLE='true'

#
bindkey -v

if [ "$TERM_PROGRAM" = tmux ]; then
      # dont set term in tmux
  else
      export TERM=screen-256color
fi

export EDITOR=nvim
autoload -U compinit; compinit
autoload -U promptinit
export NVM_COMPLETION=true
. "$HOME/.cargo/env"
export NAVI_PATH=$HOME/.navi:$HOME/.local/share/navi/cheats

## History file configuration
[ -z "$HISTFILE" ] && HISTFILE="$HOME/.zsh_history"
HISTSIZE=10000
SAVEHIST=10000
setopt EXTENDED_HISTORY

# The plugin will auto execute this zvm_config function
zvm_config() {
  # Retrieve default cursor styles
  ZVM_INSERT_MODE_CURSOR=$ZVM_CURSOR_BLINKING_BEAM
  local ncur=$(zvm_cursor_style $ZVM_NORMAL_MODE_CURSOR)
  local icur=$(zvm_cursor_style $ZVM_INSERT_MODE_CURSOR)
  # The prompt cursor in insert mode

  # Append your custom color for your cursor
  ZVM_INSERT_MODE_CURSOR=$icur'\e\e]12;#d79921\a'
  ZVM_NORMAL_MODE_CURSOR=$ncur'\e\e]12;#a89984\a'
}

export PATH=$PATH:~/opt/local/bin:/usr/local/go/bin:$HOME/go/bin:$HOME/.local/bin:~/.fzf/bin
export ZDOTDIR=$HOME/.zsh
source $ZDOTDIR/.antidote/antidote.zsh
eval "$(batpipe)"
antidote load ${ZDOTDIR:-$HOME}/.zsh_plugins.txt

ZSH_HIGHLIGHT_HIGHLIGHTERS+=(brackets pattern cursor)

# History command configuration
setopt extended_history       # record timestamp of command in HISTFILE
setopt hist_expire_dups_first # delete duplicates first when HISTFILE size exceeds HISTSIZE
setopt hist_ignore_dups       # ignore duplicated commands history list
setopt hist_ignore_space      # ignore commands that start with space
setopt hist_verify            # show command with history expansion to user before running it
setopt inc_append_history     # add commands to HISTFILE in order of execution
setopt share_history          # share command history data
setopt hist_ignore_all_dups  # do not put duplicated command into history list
setopt hist_save_no_dups  # do not save duplicated command
setopt hist_reduce_blanks  # remove unnecessary blanks
setopt inc_append_history_time  # append command to history file immediately after execution

compinit
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|=*' 'l:|=* r:|=*'
fpath=(/usr/local/share/zsh-completions $HOME/.zfunc $fpath)

bindkey -v

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('$HOME/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
  eval "$__conda_setup"
else
  if [ -f "$HOME/miniconda3/etc/profile.d/conda.sh" ]; then
    . "$HOME/miniconda3/etc/profile.d/conda.sh"
  else
    export PATH="$HOME/miniconda3/bin:$PATH"
  fi
fi
unset __conda_setup

# disable sort when completing `git checkout`
zstyle ':completion:*:git-checkout:*' sort false
# set descriptions format to enable group support
# NOTE: don't use escape sequences here, fzf-tab will ignore them
zstyle ':completion:*:descriptions' format '[%d]'
# set list-colors to enable filename colorizing
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
# force zsh not to show completion menu, which allows fzf-tab to capture the unambiguous prefix
zstyle ':completion:*' menu no
# preview directory's content with eza when completing cd
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always $realpath'
# switch group using `<` and `>`
zstyle ':fzf-tab:*' switch-group '<' '>'

zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:kill:*' force-list always

eval "$(fzf --zsh)"
eval "$(zoxide init zsh --cmd cd)"
eval "$(navi widget zsh)"
eval "$(atuin init zsh --disable-up-arrow)"

# zsh-history-substring-search configuration
HISTORY_SUBSTRING_SEARCH_ENSURE_UNIQUE=1

bindkey '^[[A' history-substring-search-up # or '\eOA'
bindkey '^[[B' history-substring-search-down # or '\eOB'

alias idea=~/opt/idea-IU-241.17011.79/bin/idea.sh
alias config="vim ~/.zshrc"
alias rhp=". ~/.zshrc"
alias reload=". ~/.zshrc"
alias ll="eza --icons always --grid -long -a --time-style=relative -s modified --extended --header --dereference"
alias lt="eza --tree --long"
alias fzfp="fzf --preview 'bat --color=always {}' --preview-window '~3'"
alias tmuxsess='tmuxp load ~/dev/configs/.config/tmux/tmuxsess.yaml'
autoload -Uz compinit
export PATH=$HOME/opt/llvm/install/bin:/usr/local/gcc-14/bin:$PATH
export LD_LIBRARY_PATH=/usr/local/lib:$LD_LIBRARY_PATH:/usr/local/gcc-14/lib64:${HOME}/g/miniconda3/lib
alias q='QHOME=~/q rlwrap -r ~/q/l64/q -p 7788'
bindkey -s '^p' 'fzfp^M'
bindkey -s '^x' 'xplr^M'
conda activate krypton
compinit

# To customize prompt, run `p10k configure` or edit ~/.zsh/.p10k.zsh.
[[ ! -f ~/.zsh/.p10k.zsh ]] || source ~/.zsh/.p10k.zsh

bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

# bind to the up key, which depends on terminal mode
bindkey -r '^r' 
bindkey '^r' atuin-search
bindkey '^z' atuin-up-search
eval "$(luarocks path --lua-version 5.4)"


PATH="${HOME}/g/perl5/bin${PATH:+:${PATH}}"; export PATH;
PERL5LIB="${HOME}/g/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="${HOME}/g/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"${HOME}/g/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=${HOME}/g/perl5"; export PERL_MM_OPT;

source /home/me/.config/broot/launcher/bash/br
