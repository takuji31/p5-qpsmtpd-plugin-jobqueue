package Qpsmtpd::Plugin::JobQueue::Engine;
use strict;
use warnings;
use 5.10.0;

use Carp ();

sub queue { Carp::croak("Please implement queue method") }



1;
