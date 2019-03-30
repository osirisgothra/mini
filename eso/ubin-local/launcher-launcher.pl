#!/usr/bin/perl
# vim:laststatus=2:backspace=eol,start,indent:nowrap:nocp#nano:syntax=github/osirisgothra/nanorc/perl.nanorc;linter=github/osirisgothra/mini/eso-ubin/perlint#atom:package=perlint;syntax=perl5#sublime:syntax=perl5		#notepadplus:wordwrap=false#preferred:vim,nano,atom,sublime,other#program(%local-usability-features)
#
#  	 launcher-launcher.pl (see FILE DETAILS below!)
#
#    Minecraft Launcher for FTB and Tehnic
#    
#    A Project That Gloriously Launches Launchers
#
#    Copyright (C) 1995-2018 Gabriel Thomas Sharp
#
#    Written by Gabriel T. Sharp <21shariria@gmail.com>
#    Latest versions of this and all of my projects can be
#    obtained by visiting the repository: 
#
#    <https://github.com/osirisgothra>
#
#  FILE DETAILS
#
#   "Real" File: launcher-launcher.pl
#
#  *Valid Links: tl	(technic launcher)
#   			 ft (feed the beast launcher)
#				mym (mine-your-mind server specialist launcher
#				 al (atl launcher**)
#				 cl (curse launcher**)
#   
#   * please read the FAQ for details about this
#
#	TODO (REPEAT): Possibly move much of this including the license to a universally-accessible URL
#				   and just supply a shortened url (possibly from adf.ly)    
#
# AUTHOR'S ADDENDUM
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
#  HISTORY
#
#	 Sun Apr 22 12:40:53 EDT 2018
#            osirisgothra@larnica initially created this file
#            with the original names, tl, ft (hard or soft link)
#
#	 Fri May 11 11:42:38 EDT 2018
#		osirisgothra@larnica made the following changes/updates:
#		1	changed core filename to launcher-launcher.pl
#			for clarity's sake, and committed to softlink-only use of the
#			command through launcher-launcher.pl.
#		2   began handling a TODO: which called for change of hard-coded
#			pre-run events to happen in a user-defined script, previously
#			defined to a future name 'tl.rc' but now renamed to a more
#			clear name '.llaunchrc'
#  FAQ
#		Q:why two names? (and the time, there were only two now there are more)
#		A:when the program runs, it checks it's base name. If it's base
#         name is "tl" it switches to the technic launcher and starts
#         that instead of ftb. Really, any other name will start ftb but
#         it is best to call it ft, since it is also a two-letter name and
#		  easy to remember (and parse!). 
#         At this time the code does NOT rely
#		  on the other name being 'ft' but this could change if I ever add
#		  support for the at launcher, curse launcher, etc. UPDATE: never will :)
#		  UPDATE: now using a 'source name' see above. The 'link names' are the
#	      links you will run now: 
#			the 'link' names are predefined above and in the code. The executable
#			must be one of these or else the script will result in an error because
#			it will not know which launcher you want to run. This is done to prevent
#			needing to use command '--switches' or '-s' to specify a mode, much like
#			is done in utilities like dash and other low-level multi-script use items.
#     		Always use a symbolic link not a hardlink, a symbolic link is created using
#     		the unix utility program (example 'ln -s file linktofile'. Please see your 
#			*nix documentation for further details or type 'info coreutils' at 
#           your prompt.
#		  ...whew!
#
#	    Q: why no ATL or CURSE support?
#       A: ATL and CURSE currently only reliable for M$ based operating systems
#          and are not implemented (at this time) here. This is due to someone
#          deciding to hand the reigns over to a money making powerhouse and this
#	       has caused the modded community to move far away from the vanilla 
#          community :(. I have no intention of supporting these but you can add
#          them on a fork if you like. (See LICENSE below!). UPDATE: ATL has a
#		   launcher, you can add it if you want. CURSE still does not.
#
#		Q: Windows?	MACOS?  Android?
#		A: you *may* run this in these situations and it just might work, but I
#		   will say this; you may need to do some tweaking to get it to be proper
#		   but THIS SCRIPT WAS WRITTEN FOR LINUX so please dont bother me about it.
#
#	CODE NOTES
#
#	comment control: notes are used instead of comments in the code, they are written
#   in this form: (#1). 
#   This means to refer to comment number 1 in this following list!
#
#   If there are commas (ie, (#4,#18,#12) that refers to the subsequent lines
#   in the code:
#			print('stuff') #(#14,#18)
#			print("more stuff")
#	that means that note number 14 will talk about the line 'print('stuff')' and the 
#	note number 18 will be talking about the line 'print("more stuff")' if there are
#	indentations, block starters/enders, control statements, they are skipped, so this
#	statement would be identically handled like the last one:
#			print("stuff") #(#14,#18)
#			
#			if ($needmorestufftalk) #33.5
#			{
#				print("more stuff")
#	note that the lines that are empty, have block starters, and the control statement (if)
#   are skipped. If a note is needed for a control statement it will be listed explicitly on
#	that same line however no commas will be used or parens either (as seen above, #33.5 is
#   listed separately outside in what we call 'naked context'.). This would be seen as note
#   number 33.5, so in the list you would see under NOTE NUMBER, '33     5' this is what is
#   known as 'note 33' and 'subnote 5' allowing grouping of simmilar note subjects, if needed.
#	TODO: Possibly move this documentation to a url and give the URL instead it is nearly
#	      self defeating to include it!
#
#   NOTE NUMBER			DESCRIPTION
#   --------------------------------------------------------------------------------------------
#	 0		0			Not a real note, just pay attention, it would have been (#0.0)
# 	 1                  can be changed, if you wish, for your own copy	
#
#
#  (this header was created using the gpl template generator (gtg) by Gabriel T. Sharp)
#
#

#
use v5.20;
use warnings;
use strict;
use Path::Tiny qw! path !;
use IPC::Run qw! run !;
use File::Slurp qw! read_file !;

# pre-run stuff that should eventually be integrated
system("drop","3s");
system("i3","workspace","2 M Y M");


# jar files (for running/checking)
my $ftb_jarfile_path = "ftb.jar";
my $minfree="2.5G";
my $ppid=getppid();
my $pid=$$;

#print ("would you like to close the parent after this? [y/n]");
my $freeme=1; #(readline() == "y"?1:0);

my $rcname = '.llaunchrc';	#(#1,#2,#3)
my $homedir = path( $ENV{"HOME"} );		# #2 this is universal on almost every operating system (though we may not be portable)
my $rcfile = $homedir->child($rcname);	# #3 can do this before check because $path class does not check existence automatically
my $clear_first = 0;
my $do_pleasant_pauses = 0;
my $show_preruns = 0;
my $args = scalar(@ARGV);

if ( $args > 0 ) 
{
	if ( $ARGV[0] =~ "--?q(uiet)?" ) 
	{
		say("running silent...");
		if( fork() ) {
			# nonzero, we are the parent process!
			# since we are, we shall exit now 
			exit(0)
		}
		else
		{
			# zero: we are the forked process
			# since we are, we shall continue to handle the rest of the script
			# quietly
			open(STDOUT, '>', "/dev/null");
			open(STDERR, '>', "/dev/null");
		} # fork == 0|pid
	}
	else
	{
		say("ignoring the other args and passing them to this main program");
	} # arg0=--quiet/-q/--q/-quiet|not
}
else
{
	say("running with default arguments (none specified)");

} # args>0

sub pleasant_pause() { return @_ unless $do_pleasant_pauses; say("\e[1;30m[\e[0;1mPress ANY Key To Continue\e[0;1m]\e[0m"); readline(); return @_ // undef; }
sub str2size
{
	my $item = shift;
	my ($numberpart, $suffix) = ( $item =~ /^([0-9]+\.?[0-9]*)([KBGTkbgtMm])$/ );
	
	my $cursize = `command free | tail -n+2 | awk \'{ print \$4; }\' | head -n1`;
	chomp($cursize);
	print("free memory checking... [32;1m " . $cursize . " bytes available [0m\n");
	print("checking user defined upper-limit...  [33;1m" . $minfree . "bytes [0m\n");
	if (( ( $numberpart * (($suffix eq "G")?(1024*1024):(1)) ) ) < $cursize)
	{
		print("free memory check: passed\n");
	}
	
	
}
str2size($minfree) or die($! . $? . " - Error getting free memory or memory not enough available!");

die("home directory $homedir does not APPEAR to exist, check it before running (we need the HOME environment variable!!") unless
	$homedir->exists();
print("\e[2J\e[1;1H") if $clear_first;	


# example actions before the fact (each being array refs, be so warned!)
# TODO: move to ~/.tlrc file maybe
say "Scanning for personal setup file...";
my @prerun_actions = $rcfile->exists() ? ( grep { !/^\s*#/ } read_file($rcfile) ) : qw();

say "---" if $show_preruns;
if ($show_preruns) { say for @prerun_actions; };
say "---" if $show_preruns;

pleasant_pause;

my @default_prerun_actions = ( [ 'killall','-SIGKILL','java' ],
					   [ 'nvidia-tweak' ],
					   [ 'drop','1','2','3','s','3','s' ],
					   [ 'xgamma', '-gamma', '1.2' ],
					   [ 'stopservices' ],
					   [ 'rea' ],
					   
						 );
					 
my ($in,$out,$err);


# not crutial so dont die or report errors on these
foreach my $action (@prerun_actions)
{
	my @action = split(' ',$action);   # DISABLED:	my @action = @{$action};	# get array ref into local ref
	print("[s[u[2Kexecuting pre-run action: @action ... "); # ansi: s=savepos u=restorepos k=homecol(2=eraseline)
	run \@action, \$in, \$out, \$err ? print("ok\n") : print("no\n");	
}

pleasant_pause;

sub do_exit
{
	my $returncode = shift // 0;
	kill $ppid if $freeme;
	exit($returncode);
}

sub ldo 
{
	my $pack = shift // "NONAME";
	my $pfx = shift // "$0";
	my @prog = @_;  # die("caller did not give program arguments (args: @_  pack+pfx: $pack $pfx)");
	unless ( $pfx eq "ftb" ) 
	{		
		say "command name matches $pack ($pfx); electing to run the $pack launcher...";

		say "forking @prog from $$ into child...";
		my $cpid = fork();
		if ($cpid == 0)
		{
			run \@prog, \$in, \$out, \$err or die("($?=$!):$err $out");		
			my $errcode = $?;
			my $errmsg = $!;
			say "forked process returned with code: [$errcode]";
			if ($errcode) {
				say "exit codes above zero usually indicate errors, displaying stream details...";		
				say "last error message (if any): [$errmsg]";
				say "last err stream output (if any): [$err]";
				say "last out stream output (if any): [$out]"; 	
			}
			else { say "process reports that it has returned without errors.";	
			}		
			do_exit($?);
		}
	}
	else # ~ if $pfx =~ "ftb"
	{
		if ($pack =~ m/^feed.*beast$/ ) 
		{			
			my $progtype = shift;
			my $progsub = shift;
			say("specialized catagory: $progtype");
			say("sub-catagory or sub: $progsub");
			# TODO: evolve to allow for multiple 'specialized' calls where their functions are hooked to other routines
			#  (this is needed to allow a plugin architecture for other developers or end users to take advantage of
			#   progtype should always be "specialized", that gets us <here>
			#    progsub should be a scalar containing an pointer to a &subroutine which can be then called with @prog as
			#     the accompanied arguments (just as in a generic launch). Also, expose some sort of class to allow for th is as
			#       well, or implement a file-based relationship (store in a system or internally executable script file).
			
			my $default_launcher_install_path = ".ftblauncher";
			my $installpath = path($ENV{"HOME"})->child($default_launcher_install_path);
			if ( $installpath->child("ftblaunch.cfg")->exists() ) 
			{
				say "found installation at $installpath and reading configuration...";
				my $modpack_dir = (grep { /^installPath=.*/ && s/^installPath=//g  } File::Slurp::read_file($installpath->child("ftblaunch.cfg")) )[0];
				chomp $modpack_dir;
				my $jarpath = $installpath->child($ftb_jarfile_path);	
				chomp $jarpath;
				my @ftb = ( "java", "-jar", "" .  $jarpath->stringify . "" ); 		
				say("checking to make sure $modpack_dir exists...");
				if ( path($modpack_dir)->exists() )	
				{	
					say "detected modpack directory from configuration: $modpack_dir";		
					# modpacks
					say "reading modpack names...";
					my @modpacknames = grep { s!^.*/([^/]+)/minecraft/mods!$1!g; } glob "/home/osirisgothra/.ftblauncher/play/*/minecraft/mods";
					say("detected $_ (confirmed)") foreach (@modpacknames);
					my ($in, $out, $err);
					say "forking @ftb...";	
					my $newpid = fork();
					if ($newpid == 0) 
					{
						say "fork succeeded (new pid is $$), giving control to program...";
						run \@ftb, \$in, \$out, \$err
							or die("ftblauncher: $!($?) (program output: ${err}${out} ");				
					}
					else 
					{
						say "process $newpid started, cleaning up script and returning to caller...";
						do_exit(0);						
					}
				} 
				else 
				{ 
					die("err(1):could not determine your modpack dir, edit this file to point at your custom location or check permissions!"); 
				}	
			} 
			else 
			{ 
				die("err(2):could not find install path to read config file, please install ftb or correct the install path in this file to point to your custom location!"); 
			}
		}
		else	# pfx is ftb but pack is not ^feed.*beast$
		{
			die ("err(3): prefix is $pfx, but pack is not feed the beast (its $pack) $! $?");
		} # if-else: pack ~ ^feed.*beast$
	} # unless-else: pfx = ftb
} # end: sub ldo()

#------------------------------------------------------------------------------
#  section: MAIN PROGRAM
# abstract: ldo() processes each case depending on what we got with $0
#     nota: ldo has special way of handling 'ftb:feed the beast' pack/pfx
#         : you could add your own packs here, just make sure you point
#         : at them in the right place, dont use hardwired personal or
#         : install-unique names, keep the file i/o portable, testing needed
#         : for portability as this was developed on linux, not windows.
#------------ -----------------------------------------------------------------

ldo("mineyourmind",	"mym", "java", "-jar",
 path($ENV{HOME})->child("MyM-Launcher.jar")) if ($0 =~ m!/mym$!);
	
ldo("technic", "tl", "java", "-jar", 
 path($ENV{HOME})->child(".technic")->child("technic.jar")) if ($0 =~ m!/tl$!);

ldo("feed the beast","ftb","specialized",
 \&fdo) if ($0 =~ m!/ft$!);


	