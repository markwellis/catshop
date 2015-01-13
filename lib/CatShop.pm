use utf8;

package CatShop;

use Moose;
use namespace::autoclean;

use Catalyst::Runtime 5.90;

our $VERSION = 0.001000;
$VERSION = eval $VERSION;

use Catalyst qw/
  ConfigLoader
  /;

extends 'Catalyst';

__PACKAGE__->setup;

1;
