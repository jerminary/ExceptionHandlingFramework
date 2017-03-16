package main;

BEGIN {push @INC, '.'}

use strict;
use warnings;

use Exception;
use LogWrapper;


sub A { &D; }
sub D { &E; }
sub E { 
  my $exp = Exception->new(code => "100", message => "Error Message", timestamp => scalar localtime());
  my $logger = LogWrapper->new(file_path => "test.log", package => __PACKAGE__);
  $logger->warn($exp);
}

A();
