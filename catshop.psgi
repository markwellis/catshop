use strict;
use warnings;

use FindBin qw/$Bin/;
use lib "$Bin/lib";

use CatShop;

use Plack::Builder;
use Plack::Middleware::Static;

my $app = CatShop->apply_default_middlewares( CatShop->psgi_app );

builder {
    enable "Plack::Middleware::Static",
            path    => sub { s|^/static/|| },
            root    => CatShop->path_to('root', 'static')->stringify;

    $app;
};
