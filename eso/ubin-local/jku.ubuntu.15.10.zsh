#!/bin/zsh
# emulate zsh
#
#    jku
#    Java Kickdown Utility Manager v2.5
#    mini/eso/ubin-local
#    Esoteric Scripts/Projects/Executables
#
#    Copyright (C) 1995-2018 Gabriel Thomas Sharp
#
#    Written by Gabriel T. Sharp <21shariria@gmail.com>
#    Latest versions of this and all of my projects can be
#    obtained by visiting the repository:
#
#    <https://github.com/osirisgothra>
#
#    Because of the global availability of github at this point, hosting
#    any additional servers for public use no longer serves a purpose. All
#    content is available 24/7 through github. (Thanks to GITHUB!).
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
#	 Sat Nov 16 13:02:05 EST 2019
#            osirisgothra@ initially created this file
#            with the original name, jku
#
#
#	REQUIREMENTS
#
#		BINARIES
#
#           --------------------------------------------+------------------------------
#			| binary/package name(man-category/section) |  description/apropos/whatis |
#			|						minimum version #   |  archectecture required     |
#           --------------------------------------------+------------------------------
#				zsh					>=5.1.1				| the Z shell
#				grep				any					| print lines matching a pattern
#               <todo add rest>
#
#	COMMENTS
#
#	Do not place comments in source code, they make it hard to read. They will be in this section divided by subject->group[->target[->line]]
#
#	comment area / header
#
#		bang		written for zsh, and also checks for zsh-ness (in case sh picks it up by accident)
#		emulate(2)	usually placed here, commented out and moved because of sh-compatible zsh block check
#
#	sh compatible pre-checking
#
#		compatible with sh in order to verify zsh noncompliance and echo that to the user
#		so they know what they need to run the script.
#
#	directives
#
#		emulate zsh		place script (back) into zsh emulation mode, the default
#		disable hash	this keyword gets used locally in a different way so the
#						built-in [hash] command must be overriden.
#
#	shell options
#
#		nointeractive	This is a program and never is run by [source] or [.]
#		aliases			Some local aliases are used to simplify repeating one-liners too small for a function
#		nullglob		When searching file lists or collecting, do not want errors in windowed environment
#		extendedglob	Fully utilizing zsh extended globbing to find files, directories without needing external programs
#		promptsubst		Using some of the prompt symbols to make text formatting easier
#		nobeep			Its annoying to the user (and the developer)
#		nozle			No line editing features are needed (we are in a curses environment)
#		noautocd		Dangerous: can easily hide bugs in the code
#		nomonitor		Prevent user from destructively exiting/suspending the program
#
#	aliases
#		new keywords
#		 glexstr		global exported scalar
#		 glexint		global exported integer
#		 array			global esoteric array
#		 hash			global esoteric hash
#		 string			global esoteric string
#
#	modules
#		termcap			allows terminal transparent output (formatting and color, mostly)
#		terminfo		lets program identify what the terminal can do
#		mathfunc		allow floating-point math and triginomic functions within expressions
#
#
#	declarations
#
# 		noitems in j_defargs_ni, but not in j_defargs meant for treeview/itemview that needs tags for long names
#
#		not all declarations are listed (see code for details)
#
#	functions
#
#		init()	used to initialize variables, etc. call details follow:
#
#                 .-func name  .--- program name (this file name)
#                 |  .-zshflags|   .------------number of cmdline arguments
#                 |  |.-lastcmd|   |     .------cmdline argument list item(s)
#                 |  |`-.  .-last  |  .--|   .--no-more-flags marker(optional)
#                 v  v  v  v   |   v  v  v   v
#                fn fgs lc lr pn nXa Xa .. nfm
#                 0  1  2  3   4  5  6
#              example call:
#                init $- $_ $? $0 $# $@
#
#
#				init() NOTES:
#                     These lines commented out for cleanup and vim_options_file re-setup.
#					This is done because the main program will (eventually) move away from
#					re-running itself to reload the script and instead do this internally.
#					However, detection code will need written. To do this now at this time
#					shows that the benefits of doing so are not great enough. So for now I
#					have just decided to comment them out and leave them in-place.
#			 line notes:
#					 (pka) line 1: comment out next line to disable test program all together (distro versions usually do)
#					               note that the flag on the command line is still needed
#					 (pka) line 5: [setgamecontext] #  line no longer needed at startup (we have jku_gamedir for this now
#					               and it is far more stable as it plays with /proc/cmdline(s) directly)
#
#		editfilesmenu()
#				codemenu
#					subsection: ' "Edit Level Data File..." '
#						lines referencing $progctx/saves:
#							if the current context is valid, and has a 'saves' directory, dive into it
#							this only happens if there is no current save open, in the latter case, the
#							level.dat is chosen as it is the currently used savegame
#							if not done already, the plan will to have a fallback save (last used) just
#							as it is in progctx, where the starting point will be the last saved game.
#
#		not every function is listed (yet?) (For details, please see code area).
#
#	main program
#
#		calls init, which calls cleanup (entry cleanup)
#		enters main loop
#		cleanup is called after loop terminates (exit cleanup)
#
#	file I/O
#
#		some files may be created by this program, so far they are:
#
#			1	"/tmp/tmp.eaUjGKVyUr"
#				Created by mktemp (the name is actually random, not always what is listed above)
#			    It is used for storing temporary values for:
#						*	VIM Startup Options (for Edit functions)
#			2	"~/.jkurc"
#				Created by dialog when prompted by program and accepted, using the --create-rc option.
#				This file contains ONLY the dialog configuration file and nothing else.
#				Any other options needing stored in the future would be stored in a separate file with
#				the name "~/.jkuconf" or "~/.config/jku(/conf)".
#
# End of Header Text (template created by the template generator by Gabriel Sharp <osirisgothra@hotmail.com>)
# LICENSE is GNU LGPL 2.0/3.0
#
# sh compat

[ -x `which zsh` ] && zsh_exists=1 || zsh_exists=0

case $zsh_exists in
	1)	 eval $(zsh --version | command grep -Po '\b([0-9.]+)+[0-9]+\b' | tr '.' ' ' | sed -r 's/([0-9]+) ([0-9]+) ([0-9]+)/maj=\1 min=\2 rev=\3/g' )
		 if [ $maj -eq 5 ] && [ $min -ge 1 ]; then
			zsh_ok=1
		 elif [ $maj -gt 5 ]; then
			zsh_ok=1
		 elif [ $maj -lt 5 ]; then
			zsh_ok=0
		 else
			echo "unexpected error when parsing version: $maj $min $rev (maj min rev)"
			zsh_ok=0
		fi
		;;
	0)	echo "zsh is not installed or is unreachable by current user ($(id -nu):$(id -ng))"
		exit 126
		;;
esac
echo "zsh(1) detected v${maj}.${min} revision ${rev} ok, switching to zsh only mode..."

# directives

emulate zsh
disable hash
disable bg
disable fg

# shell options


setopt nointeractive
setopt aliases
setopt nullglob
setopt extendedglob
setopt promptsubst
setopt nobeep
setopt nozle
setopt noautocd
setopt nomonitor

# aliases

alias glexstr='declare -gx'
alias glexint='declare -gxi'
alias array='declare -ga'
alias hash='declare -gA'
alias string='declare -g'

# modules

zmodload zsh/termcap
zmodload zsh/terminfo
zmodload zsh/mathfunc

# variables

declare -gx progname="$0"
declare -gx progctx="$(jku_gamedir $jku_gamedir_arg)"
declare -gx fallbackctx="$HOME/.minecraft"
declare -xi DIALOG_OK=0 DIALOG_CANCEL=1 DIALOG_ITEM_HELP=4 DIALOG_HELP=2 DIALOG_EXTRA=3 DIALOG_ERROR=127 DIALOG_ESC=128
declare -gx DIALOGRC="$HOME/.jkurc"
declare -gx name="JKU v2.0 Java Kickdown Utility Management Console Context=CONTEXT"
declare -ga j_defargs=( '--keep-window' '--backtitle' "$name" )
declare -ga j_defargs_ni=( '--no-items' $j_defargs )
declare -ga j_capargs_ni=( '--output-fd' '1' $j_defargs_ni )
declare -ga j_capargs=( '--output-fd' '1' $j_defargs )
declare -ga codeargs=( '--no-tags' '--help-button' $j_capargs )
declare -g  sep="$( repeat $((COLUMNS/2)) printf '-')) )"
declare -g 	context_help="No Help for this Topic"
declare -g  help=( "Select an action by mouse or spacebar; Click OK or press ENTER to accept/execute it." 0 0 )
declare -g  badopt=( "Invalid Option, Please Try Again" 0 0 )
declare -ga sizes=( $[LINES/2] $[COLUMNS/2] )
declare -gi timeout=5
declare -gi tvmin=5
declare -gi tvmax=20
declare -gi tvprefw=$((LINES - (LINES/4)))
declare -gi tvsize=$(( tvprefw<tvmin?tvmin:(tvprefw>tvmax?tvmax:tvprefw)  ))
declare -g  cycletimeout=0.75
declare -gi ishell_bg=232
declare -gi ishell_fg=159
declare -ga it_files_prefix=( config/InvTweaksTree.txt config/InvTweaksRules.txt )
declare -gx vim_options_file="$(mktemp)"
declare -gx vim_startup_cmds="set nowrap\nset noet\nset ts=2\nset sw=2\nset ls=2\nset cc=80\nset nomore\nset fdl=999\nset fdm=indent\nset fdo=all\nset fcl=all\ncolodw_blue\n"
declare -gi jku_debug=0
declare -gx jku_lctx="${HOME}/.config/jku/lastcontext"
declare -gx name="jku shell" # will be set by precmd -needs declared global however-
declare -gi jku_mintimeout=0.25	# choke value for timeouts via function td() (== d() => timeout-secs )
declare -gx jku_gamedir_arg="-n"	# should be either "-n" (fallback to ~/.minecraft) or "-N" (fallback to nothing, indicated as 'nil') or "-Nq" to fallback to a true empty string (not recommended as this is ambiguous and this program expects at least "nil")

# math expression functions
# a) function prototype+body declarations

max () {
        zr=0
        for x
        do
                [[ $x -gt $zr ]] && zr=$x
        done
        return $zr
}

min () {
        zr=0412020695241
        for x
        do
                [[ $x -lt $zr ]] && zr=$x
        done
        return $zr
}

mid () {
		mmin=$( min "$@" )
		mmax=$( max "$@" )
		last=$(( ( mmax($*) - mmin($*) ) / 2 ))
		return $last
}

# b) function math expression function bindings

functions -M max
functions -M min


# functions

function precmd() { name="$basename ${$(basename $progctx)//./}"; }
function rst() { echotc r2; }
function fg() { echotc AF $1 0 0; }
function bg() { echotc AB $1 0 0; }
function fbg() { fg $1; bg $2; }
function fbp() { fg $(( $1 & 0x0FF )); bg $(( $1 & 0x0FF00 >> 8 )); }
function hi()
{
	while read r; do
		hipart="${r##*|}"
		textpart="${r%%|*}"
		hiparts="${(s:;:)hipart}"
		for x in $hiparts; do
			echo "$r with $x"
		done
	done
}
function fatalstate()
{
	echo "the program is now in a fatal state:"
	echo "either re-run the install program or set it yourself by editing the program file (${progname-this script})"
	echo "CAN NOT PROCEED! PRESS ANY KEY TO EXIT JKU"
	read -sk1
	exit 254
}
function setgamecontext()
{
	echo "updating context"
	# jku_gamedir will take care of old context fallback, bad context fallback,etc!
	progctx="$(jku_gamedir $jku_gamedir_arg)"
	[[ -d $progctx ]] && return 0 || return 1
## old hack
	if [[ -d $progctx ]]; then
		if [[ -d $newctx ]] && [[ $newctx != $progctx ]]; then
			echo "context updated to $newctx"
			progctx="$newctx"
		else
			if [[ -d $newctx ]]; then
				echo "context update not needed (is still $progctx)"
			else
				echo "context update not possible (no game context could be obtained)"
				echo "current context is still valid, keeping $progctx as fallback context"
			fi
		fi
	else
		if [[ -d $newctx ]]; then
			echo "context set to $newctx"
			progctx="$newctx"
		else
			if [[ -d $fallbackctx ]]; then
				echo "context cannot be updated (no context obtainable)"
				echo "current context is also invalid, setting to fallback context"
				echo "which is $fallbackctx"
				progctx="$fallbackctx"
			else
				echo "fatal: fallbackctx is not valid"
				echo "this must be setup before jku can be used"
				fatalstate 254
			fi
		fi
	fi
	if [[ -d $progctx ]]; then
		cd "$progctx"
	else
		echo "fatal: program state is unstable (this line should never be executed in any normal circumstance) check for file corruption or volitile filesystem state"
		fatalstate 253
	fi
}
function cleanup()
{
	rm "$vim_options_file"
}

trap cleanup SIGINT			#
trap cleanup SIGERR			# see notes: cleanup() traps
trap cleanup SIGTERM		# 
trap cleanup SIGKILL		#

function init() # init(0=init,1=shellopt_charcodes,2=lastcmdexecuted,3=lasterrcode,4=programname,5=prog_argcount,6=prog_args, ...) [mff]
{
	testprogram "$@"
	setterm -reset
	setterm -init
	stty sane

	if ((jku_debug)) {
		for ((i=0;i<=$#+1;i++)); do
			case $i in
				0) val=$0
					n="funcname";;
				1)	n="shellopts";|
				2)	n="lastcmd";|
				3)  n="lasterrcode";|
				4)  n="progname";|
				5)  n="cli_argcount";|
				6)  n="cli_first_arg";|
				*) val=$@[i];;
			esac
			echo "argument $i($n) = \"$val\""
		done
		declare -p progname
		echo "progname before: $progname"
	}

	declare -gx progname="$4"

	if ((jku_debug)) {
		echo "progname->$4 or $0 ($progname)"
		declare -p progname
		read -sk1 'pressakey?keypress'
	}
	#cleanup					 # dont remove these lines (see documentation on init()
	#vim_options_file="$(mktemp)"

	if ((jku_debug)) {
		[[ -w $vim_options_file ]] || assert false
	}
	echo "$vim_startup_cmds" > "$vim_options_file"

}

function clear()
{
	echotc clear	# requires zsh/termcap module
}
function assert()
{
	local -i code=${?} ps=( $pipestatus )
	local -a expr=( "${1-unspecified}" 'echo -e $msg' 'exit $retv' )
	local msg=${2-assertion failed on $1 (code $code, ps=[$ps])}
	local retv=${3-$code}
	for lex ($expr) eval $lex

}
function HELP()
{
	# called directly via dialog return value of HELP [topic]
	# use context_help to set help prior to display of dialog
	dialog --colors ${j_defargs_ni/CONTEXT/$progctx} --msgbox "$context_help" $sizes
	read -sk1
}

function yn()
{
	dialog ${j_defargs_ni/CONTEXT/$progctx} --yesno "$*" $sizes
}
function menu()
{
 	local title="$1"
	shift
	result=$(dialog --output-fd 1 --no-items --menu "$title" $sizes $# ${@})
	DIALOG_EXIT_CODE=$?

	case $DIALOG_EXIT_CODE in
		$DIALOG_OK)
			for ((i=1;i<=$#;i++)); do
				if [[ ${@[i]} == $result ]]; then
					return $i
				fi
			done;;
		$DIALOG_CANCEL)
			return 0;;
		$DIALOG_ITEM_HELP)
			return 0;;
		$DIALOG_HELP)
			return 0;;
		*)
			echo "fatal error"
			exit $DIALOG_RETURN_CODE;;
	esac
	# invalid or unhandlable (or error)
	return $DIALOG_ERROR
}
function read_fs_entries()
{
	setopt nullglob
	for x in $1/*; do
		attr=$(stat -c "%A" "$x")
		echo "$x ${x##*/} $attr $level"
			if [[ -d $x ]] && ! [[ -L "$x" ]]; then
			let level++
			read_fs_entries "$x"
			let level--
		fi
	done
}
function levelcount()
{
	dialog ${j_defargs_ni/CONTEXT/$progctx} --msgbox "unsupported operation: levelcount $*" $sizes
	exit 127
}
function I()
{
	dialog ${j_capargs_ni/CONTEXT/$progctx} --inputbox "$1" $sizes;
}
function select_filenames()
{
	pushd "$PWD"
	cd "${1-/r}"
	t=$(dialog ${j_capargs/CONTEXT/$progctx} --dselect $PWD $sizes);
	cd "$t"
	ipane "Gathering File List..."
	rv=$(dialog ${j_capargs/CONTEXT/$progctx} --treeview text $sizes $tvsize `find -L -maxdepth 2 -printf '%p %f off %d '` || echo nil)
	if [[ -r $rv ]]; then
		ra=( $rv(:A) )
		REPLY="$ra"
		return 0
	else
		REPLY="nil"
		return 1
	fi;

}
function D() { op=$1; shift; tx="$1"; shift; rest=( $@ );  dialog ${j_defargs_ni/CONTEXT/$progctx} --$op "$tx" $sizes $rest; }
function C() { #for x; do echo "-$x -" > /dev/stderr; done; read -sk1;
	op=$1;		shift;
	tx="$1";	shift;		rest=( $@ );
	if [[ $tx == none ]]; then
		dialog $j_capargs_ni --$op "$rest" $sizes
	else
		dialog $j_capargs_ni --$op "$tx" $sizes $rest
	fi
}
function sleepclear() { sleep ${1-0.5}; echotc clear; }
function msgbox() { D msgbox "$*"; }
function ipane() { dialog ${j_defargs_ni/CONTEXT/$progctx} --keep-window --begin 2 2 --infobox "$1" $sizes; sleep ${2-0.25}; }
function parse_menu() { title=$1; shift; items=( "$@" ); C --menu "$title" $sizes $[(LINES /2)+1] $items; }
function tmsgbox() { dialog ${j_defargs_ni/CONTEXT/$progctx} --pause "$1" $sizes $2; sleepclear 0; }
function tinfobox() { dialog ${j_defargs_ni/CONTEXT/$progctx} --infobox "$1" $sizes; sleepclear ${2-0.5}; }
function d() { title="$1"; shift; $@ | dialog ${j_defargs_ni/CONTEXT/$progctx} --progressbox "$title" ${LINES-5} ${COLUMNS-5}; }
function td() { local timeout=$1; shift; d "$@"; sleep $[ $timeout>0?$timeout:$jku_mintimeout ]; }
function ensure_conf_loadable()
{
	if ! [[ -r $DIALOGRC ]]; then
		if dialog ${j_defargs_ni/CONTEXT/$progctx} --yesno "$DIALOGRC does not exist, create it automatically now?" 0 0; then
			dialog --create-rc "$DIALOGRC"
		else
			dialog ${j_defargs_ni/CONTEXT/$progctx} --msgbox "Warning: program may not function properly without a configuration file, it is suggested that you install one as soon as possible to $DIALOGRC" 0 0
		fi
	fi
}
function be2le()
{
	if (( $# % 2 )) {
			echo "fatal: be2le requires even-numbered list!";
			echo "given: $# items (not even)";
			exit 127;
	} else {
		for ((x=1;x<$#;x+=2)) {
			[[ x -gt 1 ]] && echo -ne " ";
			echo -ne "\"${@[x+1]}\"" "\"${@[x]}\"";
		}
	}
}
function codemenu()
{
	if [[ $1 == "nocancel" ]]; then
		cancelargs=( "--no-cancel" )
		shift
	else
		cancelargs=( )
	fi
	title="$1"
	context_help="$2"
	# empty, used to keep formatting pretty
	# when defining menu blocks:
	# ie; ..demenu title contexthelpmsg '<newline> ' "First Item" ' <newline> items code <newline> ' "Next Item " ' ...
	# since normally the last and next item is ended/began on the same line with that menu's text
	empty="$3"
	shift 3
	declare -a items=( )
	for ((x=1;x<=$#;x+=2))	{ items+=( "${@[x+1]}" "${@[x]}" ); }
	set -- "${items[@]}"
	mr=0
	#for x in $items; do
	#	mr=$(( max(mr,${#x}) ))
	#done
	eval "$(dialog $addargs ${codeargs/CONTEXT/$progctx} $cancelargs --menu $title $sizes $# ${@} )"
}

function get_current_save_inuse()
{
	# gcsi(context)
	gcname=$(dirname $(dirname "$(lsof $progctx/saves/*/*/* | tail -n1 | perl -wpe 's/^((\S+)\s+){8}//g')"))
	if [[ -d $gcname ]]; then
		gcname='nil'
	else
		files=( `find -newermm $progname -and -name 'level.dat'` )
		for f in $files; do
			if [[ -r "$f" ]]; then
				gcname="$f"
				break
			else
				gcname="nil"
			fi
		done
	fi
	nopen=$(lsof +D "$gcname" | wc -l)
	if [[ $nopen -gt 0 ]]; then
		echo "nil"
	else
		echo "$gcname"
	fi

}
function submenu()
{
	if [[ $1 == "cascaded" ]]; then
		addargs=( --keep-window --begin $[COLUMNS-(COLUMNS/2)] $[LINES-(LINES/2)] )
		shift
	fi
	codemenu "$@"
}
function editfiles_submenu()
{
	codemenu nocancel "Edit Files" \
			"${help_editfiles-Help Unavailable}" '
			' "JKU Script ($progname)" '
				nano "$progname" --syntax=zsh
			' "JKU Configuration (~/.jkurc)" '
				if ! [[ -r ~/.jkurc ]]; then
					d "Creating jkurc..." dialog --create-rc ~/.jkurc
				fi
				nano ~/.jkurc
			' "ComputerCraft Source Code Files" '
				get_current_save_inuse
			' "InventoryTweaks Tree & Rules" '
				/usr/bin/vim -u $vim_options_file $it_files
			' "Textures/Resource(s)..." '
				ipane "Finding Resource Pack Directory for Current Context, and its configured Pack (if any)"
				local n=$progctx
				local r=""
				r=$(find -L $n -maxdepth 3 -iname $(grep "(?<=skin.|resourcePacks...)[^\"]+" $n/options.txt -o))
				msgbox "$r"
				msgbox "$n"
				if [[ -d $r ]]; then
					ipane "Found Resources in $r"
					sleep 1
					ipane "Pick a texture directory, then select the file or group of files to edit"
					if select_filenames $r; then
						msgbox "You picked $REPLY"
					else
						msgbox "Cancelled"
					fi
				else
					msgbox "Cannot find any resourcepack configured for game $progctx, note that vanilla and zipped resource packs cannot be edited, make sure you unzip the resourcepack before trying to edit a resource"
				fi
			' "Edit Level Data File (Specify Yourself)" '
				ok=0
				if [[ -d $progctx ]]; then
					csiu=$(get_current_save_inuse)
					if [[ -r $csiu ]]; then
						gzhexedit $csiu
						ok=1
					fi
				fi
				if [[ $ok == 0 ]]; then
					original="$PWD"
					[[ -d $progctx/saves ]] && cd "$progctx/saves"
					while true; do
						if newd=$(dialog  --backtitle "Select Directory With Level To Edit" --begin 1 1 --infobox "Select a Directory that Contains a level.dat to edit" 0 0 --and-widget --begin 12 12 --dselect "" 0 0 --output-fd 1); then
							cd "$newd"
							if [[ -r level.dat ]]; then
								final="$PWD/level.dat"
								break
							fi
						else
							final=cancel
							break
						fi
					done
					cd "$original"
					if [[ $final != cancel ]]; then
						pushd .
						cd "$(dirname $final)"
						gzhexedit "$(basename $final)"
						popd
					fi
				fi

			'
	#end_codemenu
}
function priority_thrgrep()
{
	local -i amt=4
	local -i LINES=${LINES-24}-amt
	local -i COLUMNS=${COLUMNS-80}-amt
	while x=$(eval dialog --output-fd 1 --menu threadpreset 0 0 25 custom \"specify own parameters\" ${$(thrgrep list | tr -d '[' | sed 's/20C/ /g' | sed -r 's/^(\S+)\s*(\S+.*)$/"\1" "\2"/g' | between '---' '---')})
	do
		dialog --prgbox "Preset '$x'" "thrgrep $x" $LINES $COLUMNS
	done
}
function priority_submenu()
{
	codemenu "Priority Setting" \
		"${help_pri-No help yet}" '
		' "Pick a Thrgrep Profile" '
			priority_thrgrep
		' "Realtime" '
			d "Applying Realtime Priority Preset..." thrgrep minecraft
		' "High" '
			d "Applying High Priority Preset..." thrgrep mchi
		' "Normal" '
			d "Applying Normal/Default Priority Preset..." thrgrep mcavg
		' "Low" '
			d "Applying Low Priority Preset..." thrgrep mclo
		'
	#end_codemenu
}
function tasks_submenu()
{
	if pgrep java &> /dev/null; then
		jkstart="OPTIMIZE (Running)"
		if ! ps -p `pidof java` -o state= | grep 'T'; then
			jkpause="Pause"
			jkpausing="Pausing"
		else
			jkpause="Resume"
			jkpausing="Resuming"
		fi
	else
		jkpause="<cannot pause, not started>"
		jkstart="INITIATE (Not Running)"
	fi

	codemenu "Tasks..." \
			"${help_tasks-No help available}" '
			' "Manage Running Tasks" '
				clear
				htop
			' "Update System Time" '
				x=$( I "Enter Time or Time Difference (ie; 7pm, +50min, -5sec, 12:30, tomarrow, etc)" )
 				td 1 "Update System Time" sudo date --set "$x"
 				msgbox "The Time Is Now:\n$(date)"
			' "NVidia: Set Video Adapter Optimal Settings" '
				d "Setting Defaults..." nvidia-tweak
			' "NVidia: Set Video Gamma" '
				gam
			' "Nvidia: Random Gamma Level (Monochromatic)" '
				before=( `while read r; do printf "%1.02f " "$r"; done <<< $(xgamma |& grep -Po "[.0-9]+")` )
				gamma oneshot
				after=( `while read r; do printf "%1.02f " "$r"; done <<< $(xgamma |& grep -Po "[.0-9]+")` )
				chg=( $(( $before[1]-$after[1] )) $(( $before[2]-$after[2] )) $(( $before[3]-$after[3] )) )
				msgbox "before: $before   after: $after  change: $chg"
			' "$jkpause Main JKU Task" '
				d "${jkpausing}..." javapause
			' "$jkstart Main JKU Task" '
				if [ -x `which javaku` ]; then
					d "found javaku ok...launching (without forking)" javaku
				else
					timed_msgbox"error: javaku missing or unreachable by current user  ($(id -nu):$(id -ng))" 127 $timeout
				fi
			' "Set Task Priority" '
				priority_submenu
			' "Stop Non-Primary Services" '
				d "Stopping Services 50%" stopservices --fix
				d "Stopping Services 75%" stopservices
				d "Stopping Services 100%" sync
			' "Kill JKU Main Task" '
				d "Killing off Java" killall -KILL java
		'
	#endcodemenu

}
function shells_submenu()
{
	codemenu "Shells" \
			"${help_shells-No Help Available}" '
					' "Internal Diagnostic Shell" '
						echo "[0;1;44m[1;1H[2J"
						echo "Type [38;5;155mEND[0;1;44m to end the shell"
						typeset -a response=( "true" )
						setopt localoptions
						setopt noxtrace
						setopt nomonitor
						setopt zle
						until [[ END == $response ]] {
							eval $response
							read -A "response?[48;5;${ishell_bg}m[38;5;${ishell_fg}m[$? ${pipestatus-n} $PWD] jkushell> ";
						}
					' "External Shell: ZSH" '
						clear
						echo "Type exit to return to JKU"
						zsh
						clear
			'
		#endcodemenu
}
function main_topmenu()
{
	while true; do						# main program loop #
		codemenu nocancel "Main Menu"	\
			 "$help_mainmenu" '
					' "View Game Runtime Log" '
							d "Game Log" jku_gamelog
					' "Detect JKU Context (Game Directory)" '
							d "Attempting to (re)detect context..." setgamecontext
							msgbox "Game Context Now $progctx"
					' "JKU Tasks..." '
							tasks_submenu
					' "Edit Files..." '
							editfiles_submenu
					' "Reclaim Memory Used by Disk Cache..." '
							d "Reclaiming Memory..." drop -v -c sf1sf2fs3sfs
					' "Configure Swap Partitions..." '
							d "Configuring Swap..." sync
							~/bin/swapon
					' "Reload Settings and Script" '
							exec "$progname"
					' "Launch Shells..." '
							shells_submenu
					' "Exit JKU" '
							if yn "Really Exit?"; then
								tput clear
								exit 0
							fi
				'
		#end_codemenu
	done
}
##############################################################
### TEST PROGRAM #########################################################################################
##############################################################

function testprogram()
{
	if [[ $1 == --special-testme ]]; then
		function testme()
		{
		techo() { echo -ne "$(date %c) [$cmnum]: ";
				  case $# in
					0) echo "(empty line)" | phi;;
					1) echo "$1";;
					*) case $1 in
							-s) shift; echo "$*";;
							-e) shift; eval "echo \"$*\"";;
							 *) printf "$@";;
					   esac;;
				  esac
				}
		techo "test shell initiated, please use [exit] to end."
		while true; do
			let cmnum++
			read -a 'testme> ?tmcmd'
			case ${(L)tmcmd[1]} in
				exit|end|quit|stop|break)
					[[ $#tmcmd -gt 1 ]] && techo "warning: extra parameters ignored."
					techo "test shell ended: user gave termination command ($tmcmd)"
					exit 123;;
				resume)
					techo "ending shell and starting jku..."
					break;;
				*)	eval $tmcmd;;
			esac
		done
		unfunction techo
		unfunction testme
		}
		shift
		testme "$@"
	fi
}

# these are the only two commands given outside a function
 init "$-" "$_" "$?" "$0" "$#" "$@"
 main_topmenu "$@"
 