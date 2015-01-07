package CatShop::View::TT;
use strict;
use warnings;

use parent 'Catalyst::View::TT';

use Carp;
use Data::Dumper::Concise;

__PACKAGE__->config(
    {
        expose_methods => [ qw/warn warn_dumper/ ],
    }
);

sub warn {
    my ( $self, $c, @args ) = @_;

    carp @args;
}

sub warn_dumper {
    my ( $self, $c, @args ) = @_;

    carp Dumper( @args );
}

1;
