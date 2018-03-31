#!/bin/bash

CMDPOOLDIR=/tmp/cmdpool
__failed="echo \"FAILED!\""
__okay="echo \"OKAY!\""
__status="$__okay || $__failed"
function echo()
{ builtin echo -e "$@" }
function necho()
{ builtin echo -ne "$@" }

function cleanup()
{
	necho "removing orders..."
	rm -f * && $__status
	echo "removing order directory..."
	cd $OLDDIR
	rm -fr "$CMDPOOLDIR" && $__status
}
function init()
{
	shopt -s nullglob
	declare -g CMDPOOLDIR=/tmp/cmdpool
	mkdir "$CMDPOOLDIR" && echo "created $CMDPOOLDIR."
	[[ -d $HOME ]] || declare -gr HOME=~
	[[ -d $PWD ]] && declare -gr OLDDIR="$PWD" || declare -gr OLDDIR=$HOME
	cd "$CMDPOOLDIR"
	echo "set PWD from $PWD to $CMDPOOLDIR"
	declare -g -a 	ORDERS
	declare -g -i 	COUNT
	declare -g 	ORDER
}

while true; do

	echo "Cycle Start -- Waiting For Orders in $PWD"

	ORDERS=( * )
	COUNT=${#ORDERS[@]}
	if [[ $COUNT -gt 0 ]]; then
		"Got $COUNT orders, processing them now..."
		for ORDER in "${ORDERS[@]}"; do
			if [[ $ORDER == quit ]]; then
				echo "got quit order -- terminating script!"
				cleanup
				break 2
			fi
			if [[ -x $ORDER ]]; then
				echo "executable, executing..."
				./$ORDER
			else
				if file $ORDER | grep bourne; then
					echo "bourne script, sourcing..."
					source $ORDER
				else
					echo "bad script, ignoring..."
					(exit 2)
				fi
			fi
			if (($?)); then
				echo "got error code $?: making a copy in /tmp..."
				cp $ORDER /tmp -f
			else
				echo "order completed with no errors ($ORDER)"
			fi
		echo -ne "removing order from queue..."
		rm -f $ORDER && echo "ok" || { echo -e "failed\n\nCRITICAL: CANT DELETE ORDER - STOP CONDITION!"; exit 122; }
	else
		sleep 1.5
	fi
done
cleanup
exit 0

