use utf8;

package CatShop::Controller::Root;

use parent 'Catalyst::Controller';
use Moose;

__PACKAGE__->config( namespace => '', );

sub base : PathPart('') Chained(/) CaptureArgs(0) {
}

sub index : PathPart('') Chained(base) Args(0) {
}

sub default : Private {
    my ( $self, $c ) = @_;

    $c->go( '/error/not_found' );
}

sub end : ActionClass('RenderView') {
}

__PACKAGE__->meta->make_immutable;
