## My server ~/.profile
## delucks <jamesluck.com>

# ANSI Color Escapes
txtund=$(tput sgr 0 1)
txtbld=$(tput bold)
txtrst=$(tput sgr0)

blk=$(tput setaf 0)
bldblk=${txtbld}$(tput setaf 0)
red=$(tput setaf 1)
bldred=${txtbld}$(tput setaf 1)
grn=$(tput setaf 2)
bldgrn=${txtbld}$(tput setaf 2)
ylw=$(tput setaf 3)
bldylw=${txtbld}$(tput setaf 3)
blu=$(tput setaf 4)
bldblu=${txtbld}$(tput setaf 4)
mag=$(tput setaf 5)
bldmag=${txtbld}$(tput setaf 5)
cyn=$(tput setaf 6)
bldcyn=${txtbld}$(tput setaf 6)
wht=$(tput setaf 7)
bldwht=${txtbld}$(tput setaf 7)

# Begin Welcome Message

echo "$blu+------------------------+"
echo "|                        |"
echo "|$ylw Welcome, Administrator $blu|"
echo "|                        |"
echo "+------------------------+$txtrst"
echo "|"
echo "|$blu Username:$txtrst $(whoami)"
echo "|$blu Uptime:$txtrst $(uptime|awk '{for (i=10;i<NF;i++) printf $i " "; print $NF}')"
echo "|"
echo "|$blu Last:$txtrst"
bash -c "last -ai -n 5 | head -n5 | awk '{print \$1,\$4,\$5,\$6,\$8,\$9,\$10}' | sed 's/^/\|\ \ \ /g'"
echo "|"
echo "|$blu Disk Space:$txtrst"
sudo df -h / /home /var | sed 's/^/\|\ \ \ /g'
echo "|"
echo "|$blu Disk Temperature:$txtrst"
sudo smartctl -x /dev/sda | grep Min/Max\ Temperature | head -n2 | awk '{print $1,$(NF-2),$(NF-1)}'| sed 's/^/\|\ \ \ /g'
echo "|"
echo "|$blu Disk Quota Usage:$txtrst"
sudo repquota -a | sed 1,5d |head -n -2| awk '{printf $1;if($4!=0){printf " "$3/($4+1)"\n"}else{printf " Unlimited\n"};}' | column -t| sed 's/^/\|\ \ \ /g'
echo "|"
echo "|$blu Top Processes:$txtrst"
ps xc -eF --sort -pmem | head -n10 | awk '{print $1,$2,$3,$8,$11,$12}' | column -t| sed 's/^/\|\ \ \ /g'
echo "|"
echo "|$ylw Enjoy your stay.$txtrst"
echo "+------------------------+"
