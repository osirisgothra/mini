#!/bin/sh -c echo "do not run me, for synhi only"
#
#    common.sh
#    common sh library for mini/eso/ubin-local
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
#	 Sat 12 Jun 2021 09:54:17 PM EDT
#            osirisgothra@ initially created this file
#            with the original name, common.sh
#
#
#
#  This template and header was created using the template generator by Gabriel T. Sharp
#  You can download the latest version at: <https://www.github.com/osirisgothra/mini.git/eso/ubin-local/template>
#  (the url is subject to changes on github's behalf, please submit a pull request to fix or request a fix on any url changes)
#
__commonsh_version()
{
    echo "[1mcommon.sh v1.0[0m
common sh library for mini/eso/ubin-local
project mini/eso/ubin-local;
small projects and stand-alone programs or documents, esoteric or dependant
Copyright (C) 1995-2021 Gabriel T. Sharp
startup time: $(date)
    "
}
test -r ~/.nocommonshversion || __commonsh_version

# __isrunning(task)
# task - returns true if task is in /proc/PID/stat:1
# ONLY ONE COMMAND LINE OPTION ALLOWED
__isrunning()
{
    test -r /proc/`pidof -x -s $1`/attr
}

# __killrunning(task,[...])
#  task - name of task (from /proc/PID/stat field 1)
#  ... - more tasks (optional, separate with whitespace, only valid command names can be used, no special chars)
__killrunning()
{
    while [ $# -gt 0 ]; do
        __isrunning $1 && killall -KILL $1
        shift
    done
}

# __ifrunning(item,[args],[...])
#  item - item to test if running, also is the command run if it is along with [args]
#  args - arguments to pass with item, optionally
#  ...  - more arguments, whitespace separated, enclose space literals in quotes or doublequotes
__ifrunning()
{
    __isrunning $1 && {
        $@
    }
}
