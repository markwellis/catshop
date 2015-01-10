use strict;
use warnings;

use FindBin '$Bin';
use lib "$Bin/..";

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
        components         => [ 'TimeStamp', "InflateColumn::Authen::Passphrase" ],
        generate_pod       => 0,
        custom_column_info => sub {
            my ( $table, $column_name, $column_info ) = @_;

            my $return = {};
            if ( $column_name eq 'created_at' ) {
                $return->{set_on_create} = 1;
            }
            elsif ( $column_name eq 'updated_at' ) {
                $return->{set_on_update} = 1;
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

