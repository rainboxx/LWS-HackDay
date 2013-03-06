package LWS::HackDay;
use Moose;
use namespace::autoclean;

use Catalyst::Runtime 5.80;

# Set flags and add plugins for the application.
#
# Note that ORDERING IS IMPORTANT here as plugins are initialized in order,
# therefore you almost certainly want to keep ConfigLoader at the head of the
# list if you're using it.
#
#         -Debug: activates the debug mode for very useful log messages
#   ConfigLoader: will load the configuration from a Config::General file in the
#                 application's home directory
# Static::Simple: will serve static files from the application's root
#                 directory

use Catalyst qw/
    -Debug
    ConfigLoader
    Static::Simple
/;

extends 'Catalyst';

our $VERSION = '0.01';

# Configure the application.
#
# Note that settings in lws_hackday.conf (or other external
# configuration file that you set up manually) take precedence
# over this when using ConfigLoader. Thus configuration
# details given here can function as a default configuration,
# with an external configuration file acting as an override for
# local deployment.

__PACKAGE__->config(
    name => 'LWS::HackDay',
    # Disable deprecated behavior needed by old applications
    disable_component_resolution_regex_fallback => 1,
    enable_catalyst_header => 1, # Send X-Catalyst header
);

# Start the application
__PACKAGE__->setup();


=head1 NAME

LWS::HackDay - A Paymill's webhooks consuming Catalyst based application

=head1 SYNOPSIS

    script/lws_hackday_server.pl

=head1 DESCRIPTION

A simple application made during the L<London Websummit Hack Day 2013|http://lwshackday.eventbrite.com>
that receives webhooks from L<Paymill|https://www.paymill.com> to C</hook>, saves this to the
database, sends a text message through L<Twilio|https://www.twilio.com> and a push notification
through L<Pusher|http://pusher.com>.

All retrieved webhooks are returned when accessing C</> as JSONP.

This has been open sourced as a small show case.  There has also been
a frontend that receives the push notifications and shows some graphs.
This might also be open sourced by L<Tom Arnfeld|http://www.tarnfeld.com>.

=head1 INSTALLATION

I assume you already have Perl >= 5.10.1 installed.  The higher
the better!  (I used v5.16.1.)

Download the app and C<cd> into its directory.  Then execute the
following two commands, which will install L<cpanm>, a much better
and faster version than C<cpan>, and all dependencies of this app:

  % curl -L http://cpanmin.us | perl - --self-upgrade
  % cpanm -n --installdeps .

Now you should be able to start the integrated server with the
following command:

  % script/lws_hackday_server.pl

Now access it through your favorite browser on L<http://localhost:3000>.

=head1 CONFIGURATION

To configure this app to carry the correct API credentials, simply copy
C<lws_hackday.json> to C<lws_hackday_local.json> and paste in all
your credentials.  Restart the app if it's already running!

=head1 SEE ALSO

L<LWS::HackDay::Controller::Root>, L<Catalyst>, L<WWW::Pusher>, L<WWW::Twilio::API>

=head1 AUTHOR

Matthias Dietrich

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
