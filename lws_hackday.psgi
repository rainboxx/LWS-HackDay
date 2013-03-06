use strict;
use warnings;

use LWS::HackDay;

my $app = LWS::HackDay->apply_default_middlewares(LWS::HackDay->psgi_app);
$app;

