package Qpsmtpd::Plugin::JobQueue;
use strict;
use warnings;
our $VERSION = '0.01';

use parent qw/Qpsmtpd::Plugin/;

use Class::Accessor::Lite (
    new => 0,
    rw  => [qw/engine conf/],
);


use Data::Validator;

use Qpsmtpd::Constants;
use Qpsmtpd::Plugin::JobQueue::Engine;

sub register {
    my ($self, $qp, @args) = @_;
    #TODO read config?
    my @conf = $self->qp->config('jobqueue');
    $self->conf($self->parse_config(conf => \@conf));
}

sub parse_config {
    state $validator = Data::Validator->new(
        conf => {isa => 'ArrayRef'}
    )->with(qw/Method/);
    my ($class, $args) = $validator->validate(@_);
    #TODO parse config
    return {};
}

sub hook_queue {
    my ($self, $transaction) = @_;
    #TODO call queue method

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
