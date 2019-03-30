#!/bin/bash

shopt -s expand_aliases
shopt -s interactive_comments
shopt -s extglob


# needed to be global (for cleanup purposes)
declare -g tfile="$(mktemp)"

# for debugging
set -x
declare -gi DEBUGNOTES=0
declare -gi DEBUGTRAPS=0
declare -gi DEBUGLOOP=0
declare -gi DEBUG_CALLERS=0
if ((DEBUGTRAPS)); then
	for s in `compgen -A signal`; do
		if [[ $s =~ SIGRT|SIGJUNK ]]; then
			echo "skipped $s signal, it is not useful for us"
		else
			echo "mapping watch to $s"
			trap -- "echo \"Trap Triggered: $s\"" $s
		fi
	done
	if ((DEBUGLOOP)); then
		while true; do
			read -p "trap tests run here-use ctrl+d or type exit to end:" -a TEST_CMD
			echo "running: ${TEST_CMD} and its $(( ${#TEST_CMD[@]} - 1)) argument(s)"
			eval "${TEST_CMD[@]}"
		done
	fi
fi

# traps 
trap -- "trap_exec exit" EXIT
[[ $DEBUG_CALLERS -eq 1 ]] && trap -- "trap_exec dbg"  DEBUG

trap_exec()
{
	case $1 in
		exit)	# end-of-life cleanup
			note "cleaning up..."
			[[ -r "$tfile" ]] && rm "$tfile" || echo "warn: $tfile was already gone"
			sync
			note "cleanup is done ($?)"
			;;
		dbg)	# just debugging info
			caller
			;;
		*)
			note "message: unhandlable trap: $1"
			;;
	esac
}

declare -ga USAGE_TEXT=( "$(basename $BASH_SOURCE)" "[[path/]filename] [...]" "filename(s)" "complete path to file or files you wish to scan, you need to at least supply one filename. The files must exist" )

usage() { printf "%s - %s\n" "${USAGE_TEXT[@]}"; }
note()  { ((DEBUGNOTES)) && printf "[34;1m%s[0m\n" "$@";       }
trim()  { printf "$*" | perl -wne 's~( \A  \h+ | \h+ \Z ) ~~gx'; }
rtrim() { printf "$*" | perl -wne 's~  \h+ \Z             ~~gx'; }
ltrim() { printf "$*" | perl -wne 's~  \A  \h+            ~~gx'; }
begin() {
	file="$1"
	[[ $# -ne 1 ]] && note "ERROR: given $# arguments, expected one (1) argument"
	[[ $# -eq 0 ]] && note "CRITICAL: cannot proceed without argument, aborting begin!" && return
	if [[ -r $file ]]; then
		local -a anext=( )
		local SECTION="global"
		local -i SKIP=0
		local -i MISS=0
		local next=""
		local KEY=""
		local -a VALUE=( )
		local -i pti=0
		local -i SKIP=0
		local filter='/^\s*[^#]+/b A; T B; :A s/(^\s*)|(\s*$)//g;/^\s*$/b B; s/^([^= ]+)\s*=\s*/\1=/g;p; :B'
		sed -rn "$filter" "$file" > "$tfile"
		# map file into data string array
		# and get the length to ensure accuracy
		mapfile lines < "$tfile"
		len=${#lines[@]}
		# process each line, starting with first,
		# and keeping the pti updated (pointer-to-index)
		for ((pti=0;pti < len;pti++)); do
			next="${lines[pti]}"
			anext=( ${lines[pti]} )
			SKIP=0
			# pass 1
			case $next in
				+(!(#| ))+( )+(!(#| )))
					note "this is a two-value line: $next"
					SKIP=0
					;;
				+(	| ))	# entire line is spaces or tabs

					note "skipped empty line"
					SKIP=1
					;;
				+(*( |	)#*)) # entire line is commented out (preceeded only by spaces)
					note "skipped comment line"
					SKIP=1
					;;
				+(*#*))		# line contains a comment to be stripped
					note "stripping comment from:\n\t$next"
					next="${next%%#*}"
					note "line is now:\n\t$next"
					if [[ "$next" == "" ]]; then
						note "now its blank, will skip"
						SKIP=1
					fi
					;;
			esac
			if ((!SKIP)); then
				# trim whitespace (not checked scriptside - we know there is no empty string here)
				next="$(trim "$next")"
				# pass 2 - bearing in mind that all leading/trailing whitespace is gone
				MISS=0
				case $next in
					\[*\])# section marker
						if [[ -v SECTION ]]; then
							note "ending section: $SECTION"
						fi
						note "beginning section: $next"
						SECTION="$next"
						;;
					*=*)# key/value pair
						KEY=${next%%=*}
						VALUE=( ${next##*=} )
						note "$SECTION has a k/v pair: KEY=$KEY VALUE=$VALUE"
						;;
					!(*=*))
						KEY="${anext[0]}"
						VALUE=( "${anext[@]: 1}" )
						note "$SECTION with k/v: K=$KEY V=$VALUE (${#anext[@]})"
						;;
					*)	# an unknown line that does not fit (this is a bad thing)
						note "error: malformed line:\n\t[${next}]"
						MISS=1
						# move on after this
						;;
				esac
				# we now should have a KEY/VALUE pair unless we MISSed
				if ((MISS)); then
					true debug echo "skip this line because we MISSed (line was unparsable)"
				else
					echo "declare -gxa ${SECTION}__${KEY//./_}=( ${VALUE[@]} )"
				fi
			else
				# skipped this
				true placeholder for future use
			fi # SKIP==0
		done # for pti, next=lines[pti] (lines mapped from 'file' passed from argument $1)
	fi
}

case $# in
	0)	usage;;
	1)	begin "$1";;
	*)	while [[ $# -ne 0 ]]; do begin "$1"; done;;
esac
