package Qpsmtpd::Plugin::JobQueue::Engine;
use strict;
use warnings;
use 5.10.0;

use Carp ();
use Data::Validator;

sub queue { Carp::croak("Please implement queue method") }

sub get_engine {
    state $validator = Data::Validator->new(
        config => {isa => 'HashRef'},
    )->with(qw/Method/);
    my ($class, $args) = $validator->validate(@_);
    
}


1;
