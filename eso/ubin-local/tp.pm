#!/usr/bin/perl

use warnings;
use strict;
use v5.20.2;

package teepee;

sub _clsinit {

    my $self = shift;
    print("initializing a new $self again\n");
    $self->_setuni(int(rand() * 1024));
}
sub _setuni
{
    my $self = shift;
    $$self{'universal_data'} = shift;    
}
sub _getuni 
{
    my $self = shift;
    return $$self{'universal_data'};
}

sub new {
    my $class = shift;
    my $self = {};    
    bless $self, $class;

    $self->_clsinit();
    
    return $self;
}

1;

