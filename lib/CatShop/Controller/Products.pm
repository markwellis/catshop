use utf8;

package CatShop::Controller::Products;

use parent 'Catalyst::Controller';
use Moose;

sub base : PathPart('products') ChainedParent CaptureArgs(0) {
}

sub load : GET PathPart('') Chained(base) Args() {
    my ( $self, $c, @path ) = @_;

    #XXX check that $path[-1] is not a product (XXX create products :p)

    my $category = $c->model('DB::Category')->load_path( @path );
    #XXX check category is defined
}

__PACKAGE__->meta->make_immutable;
