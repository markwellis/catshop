use utf8;

package CatShop::Controller::Products;

use parent 'Catalyst::Controller';
use Moose;

sub base : PathPart('products') ChainedParent CaptureArgs(0) {
}

sub index : GET PathPart('') Chained(base) Args() {
    my ( $self, $c, @path ) = @_;

    my $category = $c->model( 'DB::Category' )->load_path( @path );
    $c->detach('/error/not_found') if !$category;
}

__PACKAGE__->meta->make_immutable;
