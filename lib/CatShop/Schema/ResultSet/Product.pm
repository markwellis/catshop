use utf8;

package CatShop::Schema::ResultSet::Product;
use strict;
use warnings;

use parent 'DBIx::Class::ResultSet';

sub load_sku {
    my ( $self, $sku ) = @_;

    return $self->search(
        {
            'sku' => $sku,
        }
    )->first;
}

1;
