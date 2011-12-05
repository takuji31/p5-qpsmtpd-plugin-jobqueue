package Qpsmtpd::Plugin::JobQueue::Engine::Qudo;
use strict;
use warnings;
use 5.10.0;
use parent qw/Qpsmtpd::Plugin::JobQueue::Engine/;

use Qpsmtpd::Constants;

sub enqueue {
    my ($self, $data) = @_;
    use Data::Dumper;
    #TODO enqueue
    $self->qp->log(LOGDEBUG, Dumper $data);

}

1;
