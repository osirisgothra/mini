#!/usr/bin/env perl 
#===============================================================================
#
#         FILE: perlcolor.pl
#
#        USAGE: ./perlcolor.pl  
#
#  DESCRIPTION: colortest for konsole
#
#      OPTIONS: ---
# REQUIREMENTS: ---
#         BUGS: ---
#        NOTES: ---
#       AUTHOR: Gabriel Thomas Sharp (GTS), osirisgothra@hotmail.com
# ORGANIZATION: Paradisim, LLC
#      VERSION: 1.0
#      CREATED: 02/28/2015 11:43:37 AM
#     REVISION: ---
#===============================================================================

use strict;
use warnings;
use utf8;
my $lines = $ENV{LINES} // 25;
my $columns = $ENV{COLUMNS} // 80;
my ($r, $g, $b) = (0,0,0);

for my $r ( 1 .. 16 ) 
{ 
	for $g ( 1 .. 16 )
	{
		for $b ( 1 .. 16 ) 
		{
			printf '[38;2;' . ($r*16) . ';' . ($g*16) . ';' . ($b*16) . "m\xFE";
		}
	}
}

