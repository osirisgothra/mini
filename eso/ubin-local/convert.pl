#!/usr/bin/env perl
#
# FILE
#    convert.pl
#    convert hex color values in an xml encoded stream
#
# PROJECT
#    mini/eso/ubin-local
#	 local projects and scripts that are esoteric in nature
#
# AUTHOR / COPYRIGHT
#
#    Copyright (C) 2020, Gabriel Thomas Sharp
#
#    Written by Gabriel Thomas Sharp osirisgothra@larnica.(none)
#    Latest versions of this and all of Gabriel Thomas Sharp's projects can be
#    obtained from:
#
#     <<projbranch>>
#
#    Documentation Available At:
#
#     <http://www.github.com/osirisgothra/mini/eso/ubin-local.git>
#
# LICENSE
#
#    mini/eso/ubin-local/convert.pl  is free software; you can redistribute it and/or modify
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
#  NOTES
#
#     * TODO: move 'use' statements to top if you want to keep them**
#    ** this feature will be added to the next version of perltemplate (hopefully)
#   *** warnings are disabled for experimental and once because they are pretty
#       annoying here, you might want to re-enable them for your own program
#       to do this during testing and development.
#
#  HISTORY
#
#	Thu Mar 19 20:42:41 2020
#         osirisgothra@larnica.(none) created this file using the template generator 'perltemplate'
#         and named it convert.pl for the project 'mini.git'.
#
#
# (created with perltemplate by Gabriel T. Sharp <osirisgothra@hotmail.com>)
#

use warnings;
use v5.18;
use strict;
no warnings "experimental";			# 	allow given/when/default and smartmatching without their warnings***
no warnings "once";					# 	allow variables to be used just once without warning***


## GETOPT ##
use Getopt::Long::Descriptive; # opt|shortchar[kind] (kind is =s[tr],=i[nt], or none)
my ($opt, $usage) = describe_options(
    '$0 %o TRANSFORMATION FILE',
	['Options'],
    [ 'verbose|v',  "print extra stuff"            ],
    [ 'help',       "print usage message and exit" ],
	[],
	[ "Arguments 
		TRANSFORMATION 
			By default, the amount to add (or subtract if negative) to the original hex 
			color value. The color within the stream must be in this form inside quotes: \"#xxxxxx\". 
	       The value of TRANSFORMATION must be (unless otherwise noted) one of the following: 
				Decimal number: 0 to 65535 or -65535 to -1 
				Hexidecimal number: must be in form 0x0xxxxxx 
				Octal numbers and Binary numbers are not allowed. 
			The aforementioned \"xxxxxx\" must be a digit from 0 to 9 or A to F (lowercase will be forced to uppercase). 
		FILE 
			Either a regular file, or none if streaming from a pipe like stdin. 
			A file with the name \"-\" is assumed to be /dev/stdin. 
		LICENSE/AUTHOR 
			See \"perldoc convert.pl\" for license and author information." =~ s/.*/IMA MORON/mmr ],
);
say($usage->text), exit if $opt->help;
say("getopt: arguments processed: $#ARGV");

## GETOPT END ##


## ANSI* ##

use Term::ANSIColor 4.0  qw ( colorstrip color colored uncolor coloralias :constants colorvalid :pushpop );

# color
print color 'bold blue';
print "This text is bold blue.\n";
print color 'reset';
print "This text is normal.\n";
print colored("Yellow on magenta.", 'yellow on_magenta'), "\n";
print "This text is normal.\n";
print colored ['yellow on_magenta'], 'Yellow on magenta.', "\n";
print colored ['red on_bright_yellow'], 'Red on bright yellow.', "\n";
print colored ['bright_red on_black'], 'Bright red on black.', "\n";
print "\n";
# Strip all color escape sequences.
print colorstrip '\e[1mThis is bold\e[0m', "\n";
# Determine whether a color is valid.
my $valid = colorvalid('blue bold', 'on_magenta');
print "Color string is ", $valid ? "valid\n" : "invalid\n";
# Create new aliases for colors.
coloralias('alert', 'red');
print "Alert is ", coloralias('alert'), "\n";
print colored("This is in red.", 'alert'), "\n";
print BOLD, BLUE, "This text is in bold blue.\n", RESET;
# localized
{
	local $Term::ANSIColor::AUTORESET = 1;
	print BOLD BLUE "This text is in bold blue.\n";
	print "This text is normal.\n";
}
print PUSHCOLOR RED ON_GREEN "This text is red on green.\n";
print PUSHCOLOR BRIGHT_BLUE "This text is bright blue on green.\n";
print RESET BRIGHT_BLUE "This text is just bright blue.\n";
print POPCOLOR "Back to red on green.\n";
print LOCALCOLOR GREEN ON_BLUE "This text is green on blue.\n";
# localized 
print "This text is red on green.\n";
{
	local $Term::ANSIColor::AUTOLOCAL = 1;
	print ON_BLUE "This text is red on blue.\n";
	print "This text is red on green.\n";
}
print POPCOLOR "Back to whatever we started as.\n";
## END ANSI ## 

## OPEN3 ##
print "do open3 example? [y/[n]]";
$_ = readline();
if (/y/) {
	use IPC::Open3  qw( open3 );
	my $pid = open3( \*CHLD_IN, \*CHLD_OUT, \*CHLD_ERR, 'xcalc','-fg','red' );
	my @handles = ( \*CHLD_IN, \*CHLD_OUT, \*CHLD_ERR );	
	my($wtr, $rdr, $err);
	use Symbol "gensym"; $err = gensym;
	$pid = open3($wtr, $rdr, $err, 'xcalc','-fg','red' ); 
	waitpid( $pid, 0 );
	my $child_exit_status = $? >> 8;
}
## END OPEN3 ##

## PATH ##
use Path::Tiny;
# creating Path::Tiny objects
print("for this to work, must have /tmp/foo.txt and /tmp/foo/bar.txt first, attempt will be made to create them...");
sleep(1);
my $data1 = `ls -l /`;
my $data2 = `ls /etc`;
path('/tmp/foo/bar.txt')->spew($data1);
path('/tmp/foo.txt')->spew($data2);
my $dir = path("/tmp");
my $foo = path("foo.txt");
my $subdir = $dir->child("foo");
my $bar = $subdir->child("bar.txt");
# stringifies as cleaned up path
my $file = path("./foo.txt");
say $file; # "foo.txt"
# reading files
my $guts = $file->slurp;
$guts = $file->slurp_utf8;
my @lines = $file->lines;
@lines = $file->lines_utf8;
my ($head) = $file->lines( {count => 1} );
my ($tail) = $file->lines( {count => -1} );
say "head";
say $head;
say "tail";
say $tail;
say "write data...";
# writing files
my @data = qw ( sample data );
$bar->spew( @data );
$bar->spew_utf8( @data );
# reading directories
for ( $dir->children ) { say("children: $_"); }
my $iter = $dir->iterator;
while ( my $next = $iter->() ) { say("iterated: $next"); }
## PATH END ##
