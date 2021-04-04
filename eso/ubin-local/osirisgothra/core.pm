#
# core.pm
# package core for namespace osirisgothra
# built upon the perlmod.pod example for packages
#

package osirisgothra::core;  # assumes osirisgothra/core.pm
      
use strict;
use warnings;
use POSIX;
use Path::Tiny;
use IPC::Open3;

BEGIN {
    require Exporter;
    our $VERSION     = 1.00;     						# version (for version checking)
    our @ISA         = qw(Exporter);    				# Inherits Exporter:: to export symbols
    our @EXPORT      = qw(@core_version cdo bgcdo); 	# symbols exported by default 
    our @EXPORT_OK   = qw(@core_revision cdo bgcdo);   # symbols optionally exported
}

# exported by default
our @core_version = ( 1, 0, 0, 1 );

# exported upon request
our @core_revision = ( 1, "alpha" );

# not exported (and not yet used)
my $core_callcount = 0;
my $core_cleanedup = 0;
my $core_status = 1;

# file-private as a closure: my $priv_func = sub {}; 

# public functions
sub bgcdo {
	my $prog = shift;
	my @args = shift;
	return __cdo(0,$prog,@args);	
}
sub cdo {
	my $prog = shift;
	my @args = shift;
	return __cdo(1,$prog,@args);
}

# unexportable functions
sub __cdo {
	my $waitforme = shift;	# 0 to not wait, nonzero to wait
	my $prog = shift;
	my @args = shift;
	my $forked = fork();
	exec ($prog,@args) unless $forked;	
	waitpid($forked,WNOHANG) if $waitforme;
	return $?;	# set by waitpid()	
}

END { 
	$core_cleanedup = 1; 
}
eval $core_status;
