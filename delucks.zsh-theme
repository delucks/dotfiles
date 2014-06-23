# new
# control codes are 2500 for the line, 257c for the line to right box, 257e for left box
# 251c for left vertical line into right straight out 2524 for left line into right vertical
#local ret_status="%(?:%{$fg[grey]%}└─────╼:%{$fg[grey]%}└┤%{$fg_bold[red]%}ERR%{$fg[grey]%}├╼)"
local ret_status="%(?:%{$fg[green]%};:%{$fg[grey]%}%{$fg_bold[red]%}>%{$fg[grey]%})"
PROMPT='${ret_status} '
RPROMPT='%~'
