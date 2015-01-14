use utf8;
package CatShop::Schema::Result::MetaType;

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
__PACKAGE__->table("meta_types");
__PACKAGE__->add_columns(
  "id",
  {
    data_type         => "integer",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "meta_types_id_seq",
  },
  "name",
  { data_type => "varchar", is_nullable => 0, size => 256 },
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
__PACKAGE__->add_unique_constraint("meta_types_name", ["name"]);
__PACKAGE__->has_many(
  "product_metas",
  "CatShop::Schema::Result::ProductMeta",
  { "foreign.meta_type_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07042 @ 2015-01-14 23:19:49
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:r4yInotvpI+N70Lv0TObaA


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
