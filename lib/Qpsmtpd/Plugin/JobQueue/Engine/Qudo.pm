package Qpsmtpd::Plugin::JobQueue::Engine::Qudo;
use strict;
use warnings;
use 5.10.0;
use parent qw/Qpsmtpd::Plugin::JobQueue::Engine/;

use Qudo;
use Data::GUID;

sub enqueue {
    my ($self, $data) = @_;

    my $q = Qudo->new(
        %{$self->conf->{qudo}},
    );
    $q->enqueue('Hoge', {arg => $data});
}

1;
