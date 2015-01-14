use utf8;
package CatShop::Schema::Result::Category;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use Moose;
use MooseX::NonMoose;
use MooseX::MarkAsMethods autoclean => 1;
extends 'CatShop::Schema::Base';
__PACKAGE__->load_components(
  "TimeStamp",
  "InflateColumn::Authen::Passphrase",
  "DynamicDefault",
);
__PACKAGE__->table("categories");
__PACKAGE__->add_columns(
  "id",
  {
    data_type         => "integer",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "categories_id_seq",
  },
  "name",
  { data_type => "varchar", is_nullable => 0, size => 256 },
  "normalized_name",
  {
    data_type => "varchar",
    dynamic_default_on_create => "_set_normalized_name_if_exists",
    dynamic_default_on_update => "_set_normalized_name_if_exists",
    is_nullable => 0,
    size => 256,
  },
  "parent_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "parent_path",
  { data_type => "varchar", is_nullable => 1, size => 256 },
  "created_at",
  {
    data_type     => "timestamp with time zone",
    default_value => \"current_timestamp",
    is_nullable   => 0,
    original      => { default_value => \"now()" },
    set_on_create => 1,
  },
  "updated_at",
  {
    data_type     => "timestamp with time zone",
    is_nullable   => 1,
    set_on_update => 1,
  },
);
__PACKAGE__->set_primary_key("id");
__PACKAGE__->add_unique_constraint(
  "categories_normalized_name_parent_id",
  ["normalized_name", "parent_id"],
);
__PACKAGE__->has_many(
  "categories",
  "CatShop::Schema::Result::Category",
  { "foreign.parent_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);
__PACKAGE__->belongs_to(
  "parent",
  "CatShop::Schema::Result::Category",
  { id => "parent_id" },
  {
    is_deferrable => 0,
    join_type     => "LEFT",
    on_delete     => "NO ACTION",
    on_update     => "NO ACTION",
  },
);
__PACKAGE__->has_many(
  "product_categories",
  "CatShop::Schema::Result::ProductCategory",
  { "foreign.category_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07042 @ 2015-01-14 23:19:49
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:zsm334bTLEXpLNzUFppUWQ

__PACKAGE__->load_components('MaterializedPath');
sub materialized_path_columns {
   return {
      parent => {
         parent_column                => 'parent_id',
         parent_fk_column             => 'id',
         materialized_path_column     => 'parent_path',
         include_self_in_path         => 1,
         include_self_in_reverse_path => 0,
         separator                    => '/',
         parent_relationship          => 'parent',
         children_relationship        => 'categories',
         full_path                    => 'parents',
         reverse_full_path            => 'children',
      },
   }
}
use v5.16;
sub _set_normalized_name {
    my ( $self ) = @_;

    my $name = fc $self->name;
    $name =~ s/\W+/-/g;

    $name;
}

# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
