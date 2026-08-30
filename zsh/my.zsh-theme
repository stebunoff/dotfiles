PROMPT="%(?:%{$fg_bold[green]%}➜ :%{$fg_bold[red]%}➜ %{$reset_color%}) %B%F{75}%c%f%b"
PROMPT+=' $(git_prompt_info)'

ZSH_THEME_GIT_PROMPT_PREFIX="%B%F{15}· "
ZSH_THEME_GIT_PROMPT_SUFFIX="%f%b "
ZSH_THEME_GIT_PROMPT_DIRTY="%F{167} ✗%f"
ZSH_THEME_GIT_PROMPT_CLEAN=""
