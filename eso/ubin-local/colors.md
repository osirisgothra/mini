#!/bin/zsh
# colors
# color explorer for CLI/curses/terminals alike
# see LICENSE distributed within the repository for details
# this program adheres to the same license as it's exseq counterpart, which is a GNU LGPL v3 license
# see the file 'LICENSE' distributed with this project or if you are a contributor, the LICENSE that is on
# the 'mini/eso-ubinlocal' branch of the github.com/osirisgothra/mini repository.
# warning: this program requires exseq unless you are using the 'old' parameter
# which is why this check is not made (both are distributed in the same repository, so no checks will be made)
# if the license cannot be located, it falls back to being GNU LGPL v3 license for this and any dependency file(s).
#/bin/zsh eqseq start
# see annotations at end for description (A-004-008)
# see A-009
# see A-010
# annotations:
# A-010
# because of the way printf deals with %0s along with " " this special case gets dealt with separately, to ensure
# that an extra space does not get inserted when the user explicitly turns off spacing by giving us a zero
# for the said parameter (param 5). Some environments will work if the change is made from " " to "", but this is not
# specified in the documentation as an intentional behavior and is avoided to keep the program syntatically sounded.
# A-009
# exit early when nothing to be done
# A-008 "program description"
# simple, slightly better seq
# with a few less features: no fpu support
#        and more features: supports specific spacing
#							and colorizing
# A-007 "syntax description"
# simplex syntax (TODO: add getopt to handle this instead, so we dont always need 7 params for color control, etc)
# A-006 "syntax synopsis/summary"
#] [VALUE FIELD WIDTH] 
#                      [SPACING BETWEEN VALUES] [STARTING COLUMN!] [COLORIZE?]
# A-005 "syntax parameters detail"
# parameter name				explanation (default value)
#]						Number (or character) to start at. (1)
#]						Number (or character) to stop at. (255)
#]					No. of numbers or characters to skip per iteration. (1)
# [VALUE FIELD WIDTH]           Number of character spaces to reserve for displaying the values (8)
# [SPACING BETWEEN VALUES]      Fixed number of spaces to have between each value (1)
# [STARTING COLUMN!]            Where should we start X out as being (usually not needed, just have it as 0)
# [COLORIZE?]					1=colorized color codes (numbers only!) 0=disable color (1)
# A-004 "syntax params footnotes"
# footnotes: early exit will happen if parameters do not make any sense at all (A-009)
# A-003 "early development notes"
# this is considered build zero (alpha) so dont expect much in the way of replacing /bin/seq any time soon
# A-002 "requirements"
# requires zsh 5.1.1 (developed for this version)
# A-001 "author"
# authored by Gabriel Thomas Sharp <osirisgothra@hotmail.com>
# A-000 "LICENSE"
# this program falls under the license in github.com/osirisgothra/mini, which currently is the GNU LGPL v3
# please see http://gpl.gnu.org/lgpl3 for details.
# <<END OF FILE>> if this line is missing you are missing part of the file!
#
# table values are
# RBG palette is calculated from: 16-230 = 0-224 (224 color palette)
# R = 36*r
# G = 6*g
# B = b
# RGB = (36r)+(6g)+b
# hard-coded, no need for any nonstandard program installed, moderately faster but ugly as sin :(
# this passes the rest of the arguments to exseq (for testing exseq directly)
# this is the MUCH prettier, beautiful version
# if you just want a dump, you can use exseq by itself, this one is interactive (or use 's' as the first param)
# update: defaults start with a table that is easiest to view
# (gradiented standard by tint/chroma/sat values
# table width=12 indexrange=17 to 231 range-stepping=1 
# adjmsg must fit to screen
# but we dont care if apptitle
# fits because if thats the case i must be in X terminal
# and its titlebar will be used as well
#rem - $( echo -ne "$rem" | grep -o '\[[;0-9][^;0-9]' | wc -c ) ))
