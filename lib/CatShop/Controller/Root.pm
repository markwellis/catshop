use utf8;

package CatShop::Controller::Root;

use parent 'Catalyst::Controller';
use Moose;

__PACKAGE__->config( namespace => '', );

sub base : PathPart('') Chained(/) CaptureArgs(0) {
}

sub create : GET Chained(base) Args(0) {
}

sub default : Private {
    my ( $self, $c ) = @_;

    $c->detach( '/error/not_found' );
}

sub end : ActionClass('RenderView') {
}

__PACKAGE__->meta->make_immutable;
