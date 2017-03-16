package StackTracer;

use strict;
use warnings;

sub get_stack{
  my $i = 2;
  my @retarr = ();
  while ( (my ($package, $filename, $line, $subroutine) = (caller($i++))) ){
    push @retarr, {"package" => $package, "filename" => $filename, line => $line, subroutine => $subroutine};
  }
  return @retarr;
}

1;
