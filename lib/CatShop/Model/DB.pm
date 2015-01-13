use utf8;

package CatShop::Model::DB;

use Moose;
extends 'Catalyst::Model::DBIC::Schema';

__PACKAGE__->meta->make_immutable;
