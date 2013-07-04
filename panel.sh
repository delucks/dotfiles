#!/bin/bash

source ~/.colors/currentvars

# disable path name expansion or * will be expanded in the line
# cmd=( $line )
set -f

#############
#### GEOMETRY
#############

monitor=${1:-0}
geometry=( $(herbstclient monitor_rect "$monitor") )
if [ -z "$geometry" ] ;then
    echo "Invalid monitor $monitor"
    exit 1
fi
# geometry has the format: WxH+X+Y
x=${geometry[0]}
y=${geometry[1]}
panel_width=${geometry[2]}
panel_height=16
font="-aaron-bitocra13-*-*-normal-*-*-*-*-*-*-*-*-*"
bgcolor=$(herbstclient get frame_border_normal_color)
selbg=$(herbstclient get window_border_active_color)
selfg=$fg

if [ -e "$(which textwidth 2> /dev/null)" ] ; then
    textwidth="textwidth";
elif [ -e "$(which dzen2-textwidth 2> /dev/null)" ] ; then
    textwidth="dzen2-textwidth";
else
    echo "This script requires the textwidth tool of the dzen2 project."
    exit 1
fi

if dzen2 -v 2>&1 | head -n 1 | grep -q '^dzen-\([^,]*-svn\|\),'; then
    dzen2_svn="true"
else
    dzen2_svn=""
fi

#########
### ICONS
#########

iconpath=/home/jamie/.icons/dzen
function icon() {
	echo -n "^fg()^bg($bg)^fg($selbg) ^i(${iconpath}/${1}.xbm) ^fg($fg)"
}

#############
#### CPU TEMP
#############

function temperature() {
	cpu=$(sensors | grep "Core 0" | cut -b 17-19)
	echo -n "$(icon temp)${cpu}"
}

############
#### BATTERY
############

function batt() {
	b=$(acpi -b | awk '{print $4}' | tr -d ,)
	status=$(acpi -b | awk '{print $3}')
	echo -n "$(icon bat_full_02)${status} ${b}"
}

########
#### MPD
########

function m() {
	mpc --no-status -f %${1}% current | sed 's/ä/ae/g' | sed 's/ö/oe/g' | sed 's/ü/ue/g'
}

function current() {
	# if [[ $(mpc status | grep "playing") ]]; then
		echo -n "$(icon spkr_01) $(m title) » $(m artist) » $(m album)"
	# else
		# echo -n "$(icon spkr_02) $(m title) - $(m artist) - $(m album)"
	# fi
}

################
### SHIT & STUFF
################

function uniq_linebuffered() {
    awk -W interactive '$0 != l { print ; l=$0 ; fflush(); }' "$@"
}

herbstclient pad $monitor $panel_height
{
    # events:
    # mpc idleloop player &
    while true ; do
        date +'date ^fg(#efefef)%H:%M^fg(#909090), %Y-%m-^fg(#efefef)%d'
        sleep 1 || break
    done > >(uniq_linebuffered)  &
    childpid=$!
    herbstclient --idle
    kill $childpid
} 2> /dev/null | {
    TAGS=( $(herbstclient tag_status $monitor) )
    visible=true
    date=""
    windowtitle=""
    while true ; do
        # bordercolor="#26221C"
				bordercolor = $fg
        separator="^bg()^fg($selbg)«"

        # small adjustments
				right=""
				for func in temperature batt current; do
					right="^bg()^fg($fg)${right}$(${func})"
				done
        right="${right}^bg()$(icon clock)$date$(icon arch_10x10)"
        right_text_only=$(echo -n "$right"|sed 's.\^[^(]*([^)]*)..g')

        # get width of right aligned text.. and add some space..
        # width=$($textwidth "$font" "$right")
        echo -n "$right"
				# echo -n "^p(-RIGHT)^p(-$panel_width)$right"

        echo -n "$separator "
        echo -n "^bg()^fg($selbg)${windowtitle//^/^^}"

        # draw tags
				tags=""
        for i in "${TAGS[@]}" ; do
            case ${i:0:1} in
                '#')
                    tags="${tags}^bg($selbg)^fg($selfg)"
                    ;;
                '+')
                    tags="${tags}^bg(#9CA668)^fg(#141414)"
                    ;;
                ':')
                    tags="${tags}^bg()^fg($fg)"
                    ;;
                '!')
                    tags="${tags}^bg(#FF0675)^fg(#141414)"
                    ;;
                *)
                    tags="${tags}^bg()^fg($bk1)"
                    ;;
            esac
            if [ ! -z "$dzen2_svn" ] ; then
                tags="${tags}^ca(1,herbstclient focus_monitor $monitor &&"'herbstclient use "'${i:1}'") '"${i:1} ^ca()"
            else
                tags="${tags}${i:1} "
            fi
        done
				width=$($textwidth "$font" "$tags")
				echo -n "^pa($((panel_width - $width - 765)))$tags"

        echo
        # wait for next event
        read line || break
        cmd=( $line )
        # find out event origin
        case "${cmd[0]}" in
            tag*)
                #echo "resetting tags" >&2
                TAGS=( $(herbstclient tag_status $monitor) )
                ;;
            date)
                #echo "resetting date" >&2
                date="${cmd[@]:1}"
                ;;
            quit_panel)
                exit
                ;;
            togglehidepanel)
                currentmonidx=$(herbstclient list_monitors |grep ' \[FOCUS\]$'|cut -d: -f1)
                if [ -n "${cmd[1]}" ] && [ "${cmd[1]}" -ne "$monitor" ] ; then
                    continue
                fi
                if [ "${cmd[1]}" = "current" ] && [ "$currentmonidx" -ne "$monitor" ] ; then
                    continue
                fi
                echo "^togglehide()"
                if $visible ; then
                    visible=false
                    herbstclient pad $monitor 0
                else
                    visible=true
                    herbstclient pad $monitor $panel_height
                fi
                ;;
            reload)
                exit
                ;;
            focus_changed|window_title_changed)
                windowtitle="${cmd[@]:2}"
                ;;
            #player)
            #    ;;
        esac
    done
} 2> /dev/null | dzen2 -w $panel_width -x $x -y $y -fn "$font" -h $panel_height \
    -ta l -bg "$bgcolor" -fg "$bg"
