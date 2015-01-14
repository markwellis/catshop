use utf8;
package CatShop::Schema::Result::ProductMeta;

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
__PACKAGE__->table("product_meta");
__PACKAGE__->add_columns(
  "id",
  {
    data_type         => "integer",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "product_meta_id_seq",
  },
  "product_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "meta_type_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "value",
  { data_type => "text", is_nullable => 1 },
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
__PACKAGE__->belongs_to(
  "meta_type",
  "CatShop::Schema::Result::MetaType",
  { id => "meta_type_id" },
  {
    is_deferrable => 0,
    join_type     => "LEFT",
    on_delete     => "NO ACTION",
    on_update     => "NO ACTION",
  },
);
__PACKAGE__->belongs_to(
  "product",
  "CatShop::Schema::Result::Product",
  { id => "product_id" },
  {
    is_deferrable => 0,
    join_type     => "LEFT",
    on_delete     => "NO ACTION",
    on_update     => "NO ACTION",
  },
);


# Created by DBIx::Class::Schema::Loader v0.07042 @ 2015-01-14 23:19:49
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:EHBJpl0Aze5/+5eMPwA0gA


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
