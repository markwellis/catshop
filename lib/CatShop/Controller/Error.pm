use utf8;

package CatShop::Controller::Error;

use parent 'Catalyst::Controller';
use Moose;

sub login_required : Private {
    my ( $self, $c, ) = @_;

    $c->res->status( 401 );
}

sub forbidden : Private {
    my ( $self, $c ) = @_;

    $c->res->status( 403 );
}

sub not_found : Private {
    my ( $self, $c ) = @_;

    $c->res->status( 404 );
}

sub gone : Private {
    my ( $self, $c ) = @_;

    $c->res->status( 410 );
}

sub server_error : Private {
    my ( $self, $c ) = @_;

    $c->res->status( 500 );
}

__PACKAGE__->meta->make_immutable;
