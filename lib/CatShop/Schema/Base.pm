package CatShop::Schema::Base;
use strict;
use warnings;

use parent 'DBIx::Class::Core';

sub _call_if_exists {
    my $self = shift;
    my $name = shift;

    $self->$name( @_ ) if $self->can( $name );
}

sub _call_set_normalized_name_if_exists {
    $_[0]->_call_if_exists('_set_normalized_name');
}

1;
