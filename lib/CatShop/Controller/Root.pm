package CatShop::Controller::Root;
use parent 'Catalyst::Controller';
use Moose;

__PACKAGE__->config(
    namespace   => '',
);

sub base : PathPart('') Chained(/) CaptureArgs(0) {
}

sub default: Private {
}

sub end: ActionClass('RenderView') {
}

__PACKAGE__->meta->make_immutable;
