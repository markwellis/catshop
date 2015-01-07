package CatShop::Controller::Root;
use parent 'Catalyst::Controller';
use Moose;

__PACKAGE__->config(
    namespace   => '',
);

sub default: Private {
    my ( $self, $c ) = @_;

}

sub end: ActionClass('RenderView') {}

__PACKAGE__->meta->make_immutable;
