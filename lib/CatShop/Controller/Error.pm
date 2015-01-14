use utf8;

package CatShop::Controller::Error;

use parent 'Catalyst::Controller';
use Moose;

#XXX: make templates
sub unauthorized : Private {
    my ( $self, $c ) = @_;

    $c->res->status( 401 );
    $c->res->body( '401 - Unauthorized' );
}

sub not_found : Private {
    my ( $self, $c ) = @_;

    $c->res->status( 404 );
    $c->res->body( '404 - Not found' );
}

sub gone : Private {
    my ( $self, $c ) = @_;

    $c->res->status( 410 );
    $c->res->body( '410 - Gone' );
}

sub error : Private {
    my ( $self, $c ) = @_;

    $c->res->status( 500 );
    $c->res->body( '500 - Error' );
}

__PACKAGE__->meta->make_immutable;
