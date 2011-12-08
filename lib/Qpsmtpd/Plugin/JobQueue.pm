package Qpsmtpd::Plugin::JobQueue;
use strict;
use warnings;
use 5.10.0;

our $VERSION = '0.01';

use parent qw/Qpsmtpd::Plugin/;

use Class::Accessor::Lite (
    new => 0,
    rw  => [qw/engine conf/],
);


use Class::Load ();
use Data::Validator;

use Qpsmtpd::Constants;
use Qpsmtpd::Plugin::JobQueue::Engine;

sub register {
    my ($self, $qp, @args) = @_;
    #TODO read config?
    my @conf = $self->qp->config('jobqueue');
    $self->conf($self->parse_config(conf => \@conf));
    $self->engine($args[0] || $self->conf->{engine});
}

sub parse_config {
    state $validator = Data::Validator->new(
        conf => {isa => 'ArrayRef'}
    )->with(qw/Method/);
    my ($class, $args) = $validator->validate(@_);
    #TODO parse config
    my $conf_string = join "\n", @{$args->{conf}};
    my $conf = eval $conf_string;
    die "Parse config failure! cause: $@" if $@;
    return $conf;
}

sub get_engine {
    state $validator = Data::Validator->new(
        engine => {isa => 'Str'},
    )->with(qw/Method/);
    my ($self, $args) = $validator->validate(@_);
    my $pkg = $args->{engine};
    if($pkg =~ /^\+/) {
        $pkg =~ s/^\+//;
    } else {
        $pkg = "Qpsmtpd::Plugin::JobQueue::Engine::$pkg";
    }

    Class::Load::load_class($pkg);
    my $engine = $pkg->new(conf => $self->conf, qp => $self);
    return $engine;
}

sub hook_queue {
    my ($self, $transaction) = @_;
    #TODO call queue method

    my $engine = $self->get_engine(engine => $self->engine);
    
    $engine->parse_and_enqueue(transaction => $transaction);
    return DECLINED;
}

1;
__END__

=head1 NAME

Qpsmtpd::Plugin::JobQueue -

=head1 SYNOPSIS

  use Qpsmtpd::Plugin::JobQueue;

=head1 DESCRIPTION

Qpsmtpd::Plugin::JobQueue is

=head1 AUTHOR

Nishibayashi Takuji E<lt>takuji {at} senchan.jpE<gt>

=head1 SEE ALSO

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
