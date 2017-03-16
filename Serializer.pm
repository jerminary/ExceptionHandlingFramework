package Serializer;

use strict;
use warnings;

use JSON::XS;
use Data::Structure::Util qw/unbless/;

sub serialize {
  my $self = shift;
  my $obj = shift;
  my $class = ref $obj;
  unbless $obj;
  my $rslt = encode_json($obj);
  bless $obj, $class;
  return $rslt;
}

sub deserialize {
  my ($json, $class) = @_;
  my $obj = decode_json($json);
  return bless($obj, $class);
}

1;
