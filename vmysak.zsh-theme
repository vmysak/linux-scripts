function git_time_since_commit() {
    local COLOR MINUTES HOURS DAYS SUB_HOURS SUB_MINUTES
    local last_commit seconds_since_last_commit

    # Only proceed if there is actually a commit
    if ! last_commit=$(command git -c log.showSignature=false log --pretty=format:'%at' -1 2>/dev/null); then
        echo "[$ZSH_THEME_GIT_TIME_SINCE_COMMIT_NEUTRAL~%{$reset_color%}]"
        return
    fi

    # Totals
    seconds_since_last_commit=$(( EPOCHSECONDS - last_commit ))
    MINUTES=$(( seconds_since_last_commit / 60 ))
    HOURS=$(( MINUTES / 60 ))

    # Sub-hours and sub-minutes
    DAYS=$(( HOURS / 24 ))
    SUB_HOURS=$(( HOURS % 24 ))
    SUB_MINUTES=$(( MINUTES % 60 ))

    if [[ -z "$(command git status -s 2>/dev/null)" ]]; then
        COLOR="$ZSH_THEME_GIT_TIME_SINCE_COMMIT_NEUTRAL"
    else
        if [[ "$MINUTES" -gt 30 ]]; then
            COLOR="$ZSH_THEME_GIT_TIME_SINCE_COMMIT_LONG"
        elif [[ "$MINUTES" -gt 10 ]]; then
            COLOR="$ZSH_THEME_GIT_TIME_SHORT_COMMIT_MEDIUM"
        else
            COLOR="$ZSH_THEME_GIT_TIME_SINCE_COMMIT_SHORT"
        fi
    fi

    if [[ "$HOURS" -gt 24 ]]; then
        echo "${COLOR}${DAYS}d${SUB_HOURS}h${SUB_MINUTES}m%{$reset_color%}"
    elif [[ "$MINUTES" -gt 60 ]]; then
        echo "${COLOR}${HOURS}h${SUB_MINUTES}m%{$reset_color%}"
    else
        echo "${COLOR}${MINUTES}m%{$reset_color%}"
    fi
}



PROMPT='%m %B%F{blue}:: %b%F{green}%3~ $(hg_prompt_info)$(git_prompt_info)$(git_prompt_short_sha)%B%(!.%F{red}.%F{blue})>>%f%b '
RPS1='%(?..%F{red}%? ↵%f)'

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[yellow]%}‹"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}|"
ZSH_THEME_GIT_PROMPT_SHA_BEFORE="%{$fg_bold[yellow]%}"
ZSH_THEME_GIT_PROMPT_SHA_AFTER="%{$reset_color%}|$(git_time_since_commit)%{$fg[yellow]%}> %{$reset_color%}"

ZSH_THEME_HG_PROMPT_PREFIX="%{$fg[magenta]%}hg:‹%{$fg[yellow]%}"
ZSH_THEME_HG_PROMPT_SUFFIX="%{$fg[magenta]%}› %{$reset_color%}"
ZSH_THEME_HG_PROMPT_DIRTY=" %{$fg[red]%}✗"
ZSH_THEME_HG_PROMPT_CLEAN=""
