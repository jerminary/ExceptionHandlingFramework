package main;

BEGIN {push @INC, '.'}

use strict;
use warnings;

use Exception;
#use Serializer;
use LogWrapper;
#$SIG{__WARN__} = sub { warn sprintf("[%s] ", scalar localtime), Serializer->serialize(@_) };
#$SIG{__DIE__}  = sub { die  sprintf("[%s] ", scalar localtime), Serializer->serialize(@_) };

#warn;
#die;

sub A { &D; }
sub D { &E; }
sub E { 
  my $exp = Exception->new(code => "100", message => "Error Message", timestamp => scalar localtime());
  my $logger = LogWrapper->new(file_path => "test.log", package => __PACKAGE__);
  $logger->warn($exp);
}

A();
