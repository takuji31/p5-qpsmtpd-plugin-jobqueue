package Qpsmtpd::Plugin::JobQueue::Engine;
use strict;
use warnings;
use 5.10.0;

use Carp ();
use Data::Validator;

use Class::Accessor::Lite (
    new => 1,
    ro  => [qw/qp conf/],
);

sub enqueue { Carp::croak("Please implement queue method") }

sub parse_and_enqueue {
    state $validator = Data::Validator->new(
        transaction => {isa => 'Qpsmtpd::Transaction'},
    )->with(qw/Method/);
    my ($self, $args) = $validator->validate(@_);
    my $t = $args->{transaction};
    my %data = (
        to     => [map {$_->address} $t->recipients],
        from   => $t->sender->address,
        header => $t->header->header_hashref,
        body   => $t->body_as_string,
    );

    my @result = $self->enqueue(\%data);

    return @result;
}


1;
