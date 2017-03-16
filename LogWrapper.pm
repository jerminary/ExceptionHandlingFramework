package LogWrapper;

use strict;
use warnings;

use Log::Log4perl qw(get_logger :levels);
use Carp qw(confess);

use Serializer;

sub new {
  my $class = shift;
  my $self  = { @_ };
  confess "bad arguments" unless defined $self->{file_path} and $self->{package};
  my $logger = get_logger($self->{package});
  $logger->level($INFO);

  my $appender = Log::Log4perl::Appender->new(
    "Log::Dispatch::File",
    filename => $self->{file_path},
    mode     => "append",
  );

  $logger->add_appender($appender);
  my $layout =
    Log::Log4perl::Layout::PatternLayout->new(
                  "%m%n");
  $appender->layout($layout);
  return bless $self, $class;
}

sub warn{
  my $self = shift;
  my $log_obj = shift;
  my $logger = get_logger($self->{package});
  $logger->warn(Serializer->serialize($log_obj));
}
1;
