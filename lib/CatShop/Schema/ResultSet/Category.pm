use utf8;

package CatShop::Schema::ResultSet::Category;
use strict;
use warnings;

use parent 'DBIx::Class::ResultSet';

sub load_path {
    my ( $self, @path ) = @_;

    my $category = $self->search(
        {
            'me.normalized_name' => shift @path,
        }
    );

    my $level = 1;
    while ( my $child_name = shift @path ) {
        my $rel_name = "categories";

        if ( $level > 1 ) {
            $rel_name .= "_$level";
        }

        $category = $category->search_related(
            'categories',
            {
                "$rel_name.normalized_name" => $child_name,
            }
        );
        ++$level;
    }

    return $category->first;
}

sub nav_options {
}

1;
