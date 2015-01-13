use utf8;

package CatShop::Schema::Base;

use strict;
use warnings;

use parent 'DBIx::Class::Core';

sub _set_normalized_name_if_exists {
    $_[ 0 ]->_set_normalized_name if $_[0]->can('_set_normalized_name');
}

1;
