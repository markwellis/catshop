use strict;
use warnings;

use FindBin '$Bin';
use lib "$Bin/../lib";

use DBIx::Class::Schema::Loader qw/ make_schema_at /;

use Config::ZOMG;
my $config = Config::ZOMG->new(
    name => 'catshop',
    path => "$Bin/..",
)->load->{'Model::DB'};

make_schema_at(
    $config->{schema_class},
    {
        dump_directory     => "$Bin/../lib",
        use_moose          => 1,
        components         => [ "TimeStamp", "InflateColumn::Authen::Passphrase", "DynamicDefault" ],
        generate_pod       => 0,
        result_base_class  => $config->{schema_class} . '::Base',
        custom_column_info => sub {
            my ( $table, $column_name, $column_info ) = @_;

            my $return = {};
            if ( $column_name eq 'created_at' ) {
                $return->{set_on_create} = 1;
            }
            elsif ( $column_name eq 'updated_at' ) {
                $return->{set_on_update} = 1;
            }

            if ( $table eq 'categories' ) {
                if ( $column_name eq 'normalized_name' ) {
                    for ( qw/dynamic_default_on_update dynamic_default_on_create/ ) {
                        $return->{$_} = '_set_normalized_name_if_exists';
                    }
                }
            }

            $return;
        },
    },
    [
        $config->{connect_info}->{dsn},
        $config->{connect_info}->{user},
        $config->{connect_info}->{password},
    ],
);

