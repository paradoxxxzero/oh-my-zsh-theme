PROMPT_PRIMARY_COLOR="$fg_bold[green]"
PROMPT_SECONDARY_COLOR="$fg_bold[yellow]"
PROMPT_TERTIARY_COLOR="$fg_bold[blue]"

if [ "`id -u`" -eq 0 ];
then
    PROMPT_PRIMARY_COLOR="$fg[red]"
else
    local host_sum="$(echo $HOST | md5sum -)"
    host_sum="0x$host_sum[0,1]"
    host_sum=$(( host_sum % 12 + 1))
    if (( host_sum > 6 )); then
    host_sum=$(( host_sum - 6))
    PROMPT_PRIMARY_COLOR="%B"
    fi
    PROMPT_PRIMARY_COLOR="${PROMPT_PRIMARY_COLOR}%F{$host_sum}"

    host_sum="0x$host_sum[1,2]"
    host_sum=$(( host_sum % 12 + 1))
    if (( host_sum > 6 )); then
    host_sum=$(( host_sum - 6))
    PROMPT_SECONDARY_COLOR="%B"
    fi
    PROMPT_SECONDARY_COLOR="${PROMPT_SECONDARY_COLOR}%F{$host_sum}"

    host_sum="0x$host_sum[2,3]"
    host_sum=$(( host_sum % 12 + 1))
    if (( host_sum > 6 )); then
    host_sum=$(( host_sum - 6))
    PROMPT_TERTIARY_COLOR="%B"
    fi
    PROMPT_TERTIARY_COLOR="${PROMPT_TERTIARY_COLOR}%F{$host_sum}"
fi

# Format for git_prompt_info()
ZSH_THEME_GIT_PROMPT_PREFIX=""
ZSH_THEME_GIT_PROMPT_SUFFIX=""

# Format for parse_git_dirty()
ZSH_THEME_GIT_PROMPT_DIRTY=" %{$fg[red]%}(*)"
ZSH_THEME_GIT_PROMPT_CLEAN=""

# Format for git_prompt_status()
ZSH_THEME_GIT_PROMPT_UNMERGED=" %{$fg[red]%}unmerged"
ZSH_THEME_GIT_PROMPT_DELETED=" %{$fg[red]%}deleted"
ZSH_THEME_GIT_PROMPT_RENAMED=" %{$fg[yellow]%}renamed"
ZSH_THEME_GIT_PROMPT_MODIFIED=" %{$fg[yellow]%}modified"
ZSH_THEME_GIT_PROMPT_ADDED=" %{$fg[green]%}added"
ZSH_THEME_GIT_PROMPT_UNTRACKED=" %{$fg[white]%}untracked"

# Format for git_prompt_ahead()
ZSH_THEME_GIT_PROMPT_AHEAD=" %{$fg[red]%}(!)"

# Format for git_prompt_long_sha() and git_prompt_short_sha()
ZSH_THEME_GIT_PROMPT_SHA_BEFORE=" %{$fg[white]%}[%{$fg[yellow]%}"
ZSH_THEME_GIT_PROMPT_SHA_AFTER="%{$fg[white]%}]"

# Prompt format
PROMPT='
%{$PROMPT_PRIMARY_COLOR%}%n@%m%{$fg[white]%}:%{$PROMPT_SECONDARY_COLOR%}%~%u$(parse_git_dirty)$(git_prompt_ahead)%{$reset_color%}
%{$PROMPT_TERTIARY_COLOR%}>%{$reset_color%} '
RPROMPT='%{$PROMPT_PRIMARY_COLOR%}$(current_branch)$(git_prompt_short_sha)$(git_prompt_status) $(virtualenv_prompt_info)%{$reset_color%}'
