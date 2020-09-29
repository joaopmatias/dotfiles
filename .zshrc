
# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/joaomatias/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/joaomatias/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/Users/joaomatias/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/joaomatias/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

# startup prompt
PS1='Hello > '

### Added by Zinit's installer
if [[ ! -f $HOME/.zinit/bin/zinit.zsh ]]; then
    print -P "%F{33}▓▒░ %F{220}Installing %F{33}DHARMA%F{220} Initiative Plugin Manager (%F{33}zdharma/zinit%F{220})…%f"
    command mkdir -p "$HOME/.zinit" && command chmod g-rwX "$HOME/.zinit"
    command git clone https://github.com/zdharma/zinit "$HOME/.zinit/bin" && \
        print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
        print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi

source "$HOME/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

zinit light-mode depth=1 for \
	OMZL::history.zsh \
	blockf OMZL::completion.zsh

POWERLEVEL9K_DISABLE_CONFIGURATION_WIZARD=true

zinit svn wait'!' lucid light-mode depth=1 nocd atload"_p9k_precmd" for \
	romkatv/powerlevel10k

typeset -g POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=( \
	time                   dir                      vcs
	newline                prompt_char)
typeset -g POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(  \
	status                  command_execution_time  background_jobs
	virtualenv              anaconda                pyenv
	goenv                   scalaenv                context)
typeset -g POWERLEVEL9K_MODE=nerdfont-complete
typeset -g POWERLEVEL9K_ICON_PADDING=none
typeset -g POWERLEVEL9K_TIME_FOREGROUND=3
typeset -g POWERLEVEL9K_TIME_BACKGROUND=0
typeset -g POWERLEVEL9K_SHORTEN_DIR_LENGTH=2
typeset -g POWERLEVEL9K_SHORTEN_STRATEGY=truncate_beginning
function my_git_formatter() {
	emulate -L zsh
	if [[ -n $P9K_CONTENT ]]; then
	  typeset -g my_git_format=$P9K_CONTENT
	  return
	fi

	local       meta='%7F' # white foreground
	local      clean='%0F' # black foreground
	local   modified='%0F' # black foreground
	local  untracked='%0F' # black foreground
	local conflicted='%1F' # red foreground

	local res
	local where  # branch or tag
	if [[ -n $VCS_STATUS_LOCAL_BRANCH ]]; then
	  res+="${clean}${(g::)POWERLEVEL9K_VCS_BRANCH_ICON}"
	  where=${(V)VCS_STATUS_LOCAL_BRANCH}
	elif [[ -n $VCS_STATUS_TAG ]]; then
	  res+="${meta}#"
	  where=${(V)VCS_STATUS_TAG}
	fi
	res+="${clean}${where//\%/%%}"
	[[ -z $where ]] && res+="${meta}@${clean}${VCS_STATUS_COMMIT[1,8]}"
	if [[ -n ${VCS_STATUS_REMOTE_BRANCH:#$VCS_STATUS_LOCAL_BRANCH} ]]; then
	  res+="${meta}:${clean}${(V)VCS_STATUS_REMOTE_BRANCH//\%/%%}"  # escape %
	fi
	(( VCS_STATUS_COMMITS_BEHIND )) && \
		res+=" ${clean}⇣${VCS_STATUS_COMMITS_BEHIND}"
	(( VCS_STATUS_COMMITS_AHEAD && !VCS_STATUS_COMMITS_BEHIND )) && \
		res+=" "
	(( VCS_STATUS_COMMITS_AHEAD  )) && \
		res+="${clean}⇡${VCS_STATUS_COMMITS_AHEAD}"
	(( VCS_STATUS_PUSH_COMMITS_BEHIND )) && \
		res+=" ${clean}⇠${VCS_STATUS_PUSH_COMMITS_BEHIND}"
	(( VCS_STATUS_PUSH_COMMITS_AHEAD && !VCS_STATUS_PUSH_COMMITS_BEHIND )) && \
		res+=" "
	(( VCS_STATUS_PUSH_COMMITS_AHEAD  )) && \
		res+="${clean}⇢${VCS_STATUS_PUSH_COMMITS_AHEAD}"
	(( VCS_STATUS_STASHES        )) && \
		res+=" ${clean}*${VCS_STATUS_STASHES}"
	[[ -n $VCS_STATUS_ACTION     ]] && \
		res+=" ${conflicted}${VCS_STATUS_ACTION}"
	(( VCS_STATUS_NUM_CONFLICTED )) && \
		res+=" ${conflicted}~${VCS_STATUS_NUM_CONFLICTED}"
	(( VCS_STATUS_NUM_STAGED     )) && \
		res+=" ${modified}+${VCS_STATUS_NUM_STAGED}"
	(( VCS_STATUS_NUM_UNSTAGED   )) && \
		res+=" ${modified}!${VCS_STATUS_NUM_UNSTAGED}"
	(( VCS_STATUS_NUM_UNTRACKED  )) && \
		res+=" ${untracked}${(g::)POWERLEVEL9K_VCS_UNTRACKED_ICON}${VCS_STATUS_NUM_UNTRACKED}"
	(( VCS_STATUS_HAS_UNSTAGED == -1 )) && \
		res+=" ${modified}─"
	typeset -g my_git_format=$res
}
functions -M my_git_formatter 2>/dev/null
typeset -g POWERLEVEL9K_VCS_UNTRACKED_ICON='?'
typeset -g POWERLEVEL9K_VCS_CONTENT_EXPANSION='${$((my_git_formatter()))+${my_git_format}}'
typeset -g POWERLEVEL9K_VCS_DISABLE_GITSTATUS_FORMATTING=true
typeset -g POWERLEVEL9K_STATUS_OK=false
typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_FOREGROUND=0
typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_BACKGROUND=3
typeset -g POWERLEVEL9K_ANACONDA_CONTENT_EXPANSION='${${${${CONDA_PROMPT_MODIFIER#\(}% }%\)}:-${CONDA_PREFIX:t}}'
typeset -g POWERLEVEL9K_CONTEXT_BACKGROUND=0
typeset -g POWERLEVEL9K_MULTILINE_FIRST_PROMPT_GAP_CHAR=
typeset -g POWERLEVEL9K_PROMPT_CHAR_BACKGROUND=
typeset -g POWERLEVEL9K_PROMPT_CHAR_LEFT_{LEFT,RIGHT}_WHITESPACE=
typeset -g POWERLEVEL9K_PROMPT_CHAR_LEFT_PROMPT_LAST_SEGMENT_END_SYMBOL=

zinit wait lucid light-mode depth=1 for \
    zinit-zsh/z-a-patch-dl \
    zinit-zsh/z-a-bin-gem-node \
	atinit"zicompinit; zicdreplay" \
		zdharma/fast-syntax-highlighting \
	zdharma/history-search-multi-word \
	atload"bindkey '^[[A' history-substring-search-up; \
			bindkey '^[[B' history-substring-search-down" \
		zsh-users/zsh-history-substring-search

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
#[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
