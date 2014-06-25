# new
# control codes are 2500 for the line, 257c for the line to right box, 257e for left box
# 251c for left vertical line into right straight out 2524 for left line into right vertical
#local ret_status="%(?:%{$fg[grey]%}└─────╼:%{$fg[grey]%}└┤%{$fg_bold[red]%}ERR%{$fg[grey]%}├╼)"
local ret_status="%(?:%{$fg[green]%};%{$reset_color%}:%{$fg[red]%}>%{$reset_color%})"
PROMPT='${ret_status} '
RPROMPT='%{$fg[grey]%}%~ %m%{$reset_color%}'
