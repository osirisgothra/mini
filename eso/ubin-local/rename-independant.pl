use warnings;
use v5.20;
use strict;


my $debugmode = 1;
sub setup_debugging {
	# handle any debug related stuff here
	if ($debugmode) {
		return sub { print("DEBUG: @_ \n"); };
	} else {
		return sub { return 0; };
	}
}
my $dprint = setup_debugging();
sub dsay { &$dprint(@_); }	# shorthand, will be inlined (add 'return' to prevent inlining)

dsay("initiation of debug setup is completed (when not in this mode, you will see nothing).");
say("requires at least 2 arguments"), exit(1) if scalar(@ARGV) < 2;


my $perlexpr = shift(@ARGV);
my @sourcefiles = @ARGV;
my @destfiles = grep { eval $perlexpr;  } @sourcefiles;
my ($sfc, $dfc) = (scalar(@sourcefiles),scalar(@destfiles));
dsay <<EOF
	perl expression: $perlexpr

---------------------------------------------------------------------------

	source file list: @sourcefiles


	source file count: $sfc

---------------------------------------------------------------------------


	dest file list: @destfiles


	dest file count: $dfc


EOF
;
my $i;

for ($i=0;$i<$dfc;$i++)
{
	say("\nrename [32;1m$sourcefiles[$i][0m to [34;1m$destfiles[$i][0m");
	
}
CORE::say("\n");

#print for @sourcefiles;
