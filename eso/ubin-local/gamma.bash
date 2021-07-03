#!/bin/bash
#
#    gamma.bash
#    old version of my single gamma program for monitors
#    mini/eso
#    small projects and stand-alone programs or documents, esoteric or dependant
#
#    Copyright (C) 1995-2021 Gabriel T. Sharp
#
#    Written by Gabriel T. Sharp <21shariria@gmail.com>
#    Latest versions of this and all projects can be
#    obtained by visiting the repository at:
#
#    <https://github.com/osirisgothra>
#
#    This program is free software; you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation; either version 2 of the License, or
#    (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License along
#    with this program; if not, write to the Free Software Foundation, Inc.,
#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
#
#    HISTORY
#
#    ?? 201?
#            osirisgothra@????.??? initially created this file, and named it 'gamma'
#            which didnt include this lovely template
#
#	 Sat 03 Jul 2021 06:44:37 PM EDT
#            osirisgothra@larnica.whyfi.net initially created this template
#            and moved the 'gamma' script to a new file, with the name 'gamma.bash'
#
#
#   DANGER!
#   DEPRECIATED
#
#   dont use this program, use the newer gamma script (written in perl)
#
#  This template and header was created using the template generator by Gabriel T. Sharp
#  You can download the latest version at: <https://www.github.com/osirisgothra/mini.git/eso/ubin-local/template>
#  (the url is subject to changes on github's behalf, please submit a pull request to fix or request a fix on any url changes)
#

declare -gi XGAMMA_ADDING=0
declare -g XGAMMA_INC=${G_INC-0.05}


# --add flag; allow it to be --add, -add, -a, or --a
if [[ $1 =~ ^--?a(dd)? ]]; then
	XGAMMA_ADDING=1
	shift
fi

# -a GRGB=( "r" "g" "b" )
eval $(echo -ne "GRGB=( "; xgamma |& tr -Cd '[0-9. ]' | tr -s ' ' | tr ' ' ',' | grep -P '[0-9.]+,?' -o | tr ',\n' ' ' | tr -s ' '; echo -ne ")\n")

if [[ $# -eq 0 ]] || [[ $1 == 'oneshot' ]]; then
	while true; do
		[[ $XGAMMA_ADDING -eq 1 ]] && echo "warning: --add does not influence randomgen, ignoring..."
		if [[ $1 != oneshot ]]; then
			echo "keep pressing enter until you see a gamma you like and"
			echo "then press [Y]..."
		fi
		MAJOR=$[ ${RANDOM:1:1} / 3 ]
		MINOR=$[ ${RANDOM:1:2} ]
		CMDLINE=( /usr/bin/xgamma -gamma "${MAJOR}.${MINOR}" )
		echo "${CMDLINE[@]}"
		eval "${CMDLINE[@]}"
		if [[ $1 != oneshot ]]; then
			read -sn1
			if [[ $REPLY == Y ]]; then
				exit 0
			fi
		else
			exit 0
		fi
	done
else
	if [[ "$*" =~ ^(-?[0-9.\ ]+)+$ ]]; then
		echo "digit(s) only, sending as gamma value...$*"
		case $# in
			3)
				if [[ $XGAMMA_ADDING -eq 1 ]]; then
					declare -a NEWVALS=( $(calc -e -- "${1}+${GRGB[0]};${2}+${GRGB[1]};${3}+${GRGB[2]}" | tr -d ' \t' | tr '\n' ' ') )
				else
					declare -a NEWVALS=( $1 $2 $3 )
				fi
				echo "old->new"
				echo "${GRGB[@]} -> ${NEWVALS[@]} ( +/- $@ )"
				xgamma -rgamma "${NEWVALS[0]}" -ggamma "${NEWVALS[1]}" -bgamma "${NEWVALS[2]}"
				;;
			*)
				[[ $# -ne 1 ]] && echo "warning: $# values given, only first will be used!"
				echo "items: $@"
				echo "GRGB: ${GRGB[@]}"
				if [[ $XGAMMA_ADDING -eq 1 ]]; then
					xgamma -gamma $( calc -e -- "${1}+(( ${GRGB[0]} + ${GRGB[1]} + ${GRGB[2]} ) / 3)")
				else
					xgamma -gamma ${1}
				fi
				;;
		esac
	else
		echo "nondigit parameters detected, delegating to xgamma..."
		xgamma "$@"
	fi
	exit $?
fi
echo "abnormal termination"
exit 127