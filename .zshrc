
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi


# Homebrew shell completions
if type brew &>/dev/null
then
  FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"

  autoload -Uz compinit
  compinit
fi


### Added by Zinit's installer
if [[ ! -f $HOME/.zinit/bin/zinit.zsh ]]; then
    print -P "%F{33}▓▒░ %F{220}Installing %F{33}DHARMA%F{220} Initiative Plugin Manager (%F{33}zdharma/zinit%F{220})…%f"
    command mkdir -p "$HOME/.zinit" && command chmod g-rwX "$HOME/.zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.zinit/bin" && \
        print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
        print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi

source "$HOME/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit


zinit light-mode depth=1 for \
	romkatv/powerlevel10k \
	OMZL::history.zsh \
	blockf OMZL::completion.zsh

POWERLEVEL9K_DISABLE_CONFIGURATION_WIZARD=true
# Load PowerLevel10K
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh



zinit wait lucid light-mode depth=1 for \
	pasky/speedread \
	atinit"zicompinit; zicdreplay" \
		zdharma-continuum/fast-syntax-highlighting \
	zdharma-continuum/history-search-multi-word \
	atload"bindkey '^[[A' history-substring-search-up; \
			bindkey '^[[B' history-substring-search-down" \
		zsh-users/zsh-history-substring-search


# Google Cloud SDK
# source "/opt/homebrew/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc"


#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
# __conda_setup="$('/Users/joaomatias/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
# if [ $? -eq 0 ]; then
#     eval "$__conda_setup"
# else
#     if [ -f "/Users/joaomatias/miniconda3/etc/profile.d/conda.sh" ]; then
#         . "/Users/joaomatias/miniconda3/etc/profile.d/conda.sh"
#     else
#         export PATH="/Users/joaomatias/miniconda3/bin:$PATH"
#     fi
# fi
# unset __conda_setup
# <<< conda initialize <<<


# >>> conda initialize, Matias style >>>
if [ "$(arch)" = "arm64" ]; then
    CONDA_PREFIX="${HOME}/miniconda3"
else
    CONDA_PREFIX="${HOME}/miniconda3-intel"
    export PYTHONHOME="${HOME}/miniconda3-intel"
fi

__conda_setup="$("${CONDA_PREFIX}/bin/conda" 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "${CONDA_PREFIX}/etc/profile.d/conda.sh" ]; then
        . "${CONDA_PREFIX}/etc/profile.d/conda.sh"
    else
        export PATH="${CONDA_PREFIX}/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize, Matias style <<<
