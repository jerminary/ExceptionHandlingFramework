package StackTracer;

use strict;
use warnings;

use Carp qw(longmess);

my $stack_frame_re = qr{
    ^                # Beginning of line
    \s*              # Any number of spaces
    ( [\w:]+ )       # Package + sub
    (?: [(] ( .*? ) [)] )? # Anything between two parens
    \s+              # At least one space
    called [ ] at    # "called" followed by a single space
    \s+ ( \S+ ) \s+  # Spaces surrounding at least one non-space character
    line [ ] (\d+)   # line designation
}x;

sub get_stack {
    my @lines = split /\s*\n\s*/, longmess;
    shift @lines for ( 1 .. 2 );
    my @frames
        = map {
              my ( $sub_name, $arg_str, $file, $line ) = /$stack_frame_re/;
              my $ref =  { sub_name => $sub_name
                         , file     => $file
                         , line     => $line
                         };
              bless $ref, $_[0] if @_;
              $ref
          }
          @lines
       ;
    return wantarray ? @frames : \@frames;
}

1;
