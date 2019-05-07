#!/bin/bash
ED="\e[31m"
GREEN="\e[32m"
YELLOW="\e[33m"
CYAN="\e[36m"
LIGHTGREEN="\e[92m"
MARGENTA="\e[35m"
BLUE="\e[34m"
BOLD="\e[1m"
NOCOLOR="\e[0m"
wordpress(){
	joomla $1
	ngecurl=$(curl -s -I "$1/wp-login.php")
	if [[ $ngecurl =~ "200" ]]; then
		printf "${GREEN}WordPress Vuln => $1/wp-admin/${NOCOLOR}\n"
		echo "WordPress => $1/wp-admin/">> wordpress.txt
	elif [[ $ngecurl =~ "404" ]]; then
		printf "404 Not Found => $1/wp-admin/\n"
	else
		printf "WordPress Not Vuln => $1/wp-admin/\n"
	fi
}
joomla(){
	ngecurl1=$(curl -s -I "$1/administrator/")
	if [[ $ngecurl1 =~ "200" ]]; then
		printf "${GREEN}Joomla Vuln => $1/administrator/${NOCOLOR}\n"
		echo "Joomla => $1/administrator/">> Joomla.txt
	elif [[ $ngecurl1 =~ "404" ]]; then
		printf "404 Not Found => $1/administrator/\n"
	else
		printf "Joomla Not Vuln => $1/administrator/\n"
	fi
}
echo ""
echo "List In This Directory : "
ls
echo "Delimeter list -> url"
echo -n "Masukan File List : "
read list
if [ ! -f $list ]; then
	echo "$list No Such File"
	exit
fi
persend=1
setleep=4
itung=1
x=$(gawk '{ print $1 }' $list)
IFS=$'\r\n' GLOBIGNORE='*' command eval  'url=($x)'
for (( i = 0; i < "${#url[@]}"; i++ )); do
	set_kirik=$(expr $itung % $persend)
	if [[ $set_kirik == 0 && $itung > 0 ]]; then
		sleep $setleep
	fi
	urnna="${url[$i]}"
	wordpress $urnna &
	itung=$[$itung+1]
done
wait