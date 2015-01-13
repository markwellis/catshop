package CatShop::Controller::Products;
use parent 'Catalyst::Controller';
use Moose;

sub base : PathPart('products') ChainedParent CaptureArgs(0) {
}

sub load: GET PathPart('') Chained(base) Args() {
    my ( $self, $c, @path ) = @_;

    my $category = $c->model('DB::Category')->search_related( 'parents', {
        'me.parent_path' => join '/', @path,
    } );

    map { warn $_->name } $category->all;
}

__PACKAGE__->meta->make_immutable;
