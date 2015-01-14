use utf8;

package CatShop::Controller::Product;

use parent 'Catalyst::Controller';
use Moose;

sub base : PathPart('product') ChainedParent CaptureArgs(0) {
}

sub index : GET PathPart('') Chained(base) Args(1) {
    my ( $self, $c, $sku ) = @_;

    #XXX: finalize the format of $sku, probably SKU-normalized-name
    my $product = $c->model( 'DB::Product' )->load_sku( $sku );
    $c->detach('/error/not_found') if !$product;
}

__PACKAGE__->meta->make_immutable;
