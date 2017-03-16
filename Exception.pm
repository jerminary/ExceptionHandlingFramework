package Exception;

BEGIN {push @INC, '.'}

use strict;
use warnings;

use Carp qw(confess);
use StackTracer;

sub new {
    my $class = shift;
    my $self  = { @_ };
    @{$self->{stacktrace}} = StackTracer->get_stack();
    confess "bad arguments" unless defined $self->{code} and defined $self->{message} and defined $self->{timestamp}; 
    return bless $self, $class;
}

sub code {
    my $self = shift;
    return $self->{code}
}

sub messgae {
    my $self = shift;
    return $self->{message};
}

sub timestamp {
    my $self = shift;
    return $self->{timestamp};
}

1;
