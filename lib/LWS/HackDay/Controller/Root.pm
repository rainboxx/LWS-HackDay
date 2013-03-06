package LWS::HackDay::Controller::Root;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller' }

use JSON qw//;

#
# Sets the actions in this controller to be registered with no prefix
# so they function identically to actions created in MyApp.pm
#
__PACKAGE__->config(namespace => '');

=head1 NAME

LWS::HackDay::Controller::Root - Root Controller for LWS::HackDay

=head1 DESCRIPTION

[enter your description here]

=head1 METHODS

=head2 index

The root page (/)

=cut

sub index : Path : Args(0) {
    my ($self, $c) = @_;

    my $hooks = $c->model('DB::Hook');

    my $response_data;
    foreach ($hooks->all) {
        push @{ $response_data->{transactions} },
            {
            amount    => $_->data->{origin_amount},
            currency  => $_->data->{currency},
            date      => $_->data->{created_at},
            card_type => $_->data->{payment}->{card_type},
            };

        $response_data->{summaries}->{ $_->data->{currency} } = 0
            unless exists $response_data->{summaries}->{ $_->data->{currency} };
        $response_data->{summaries}->{ $_->data->{currency} } += $_->data->{origin_amount};
    }

    $c->response->body($c->req->params->{callback} . '(' . JSON::to_json($response_data) . ')');
}

=head2 default

Standard 404 error page

=cut

sub default : Path {
    my ($self, $c) = @_;
    $c->response->body('Page not found');
    $c->response->status(404);
}

=head2 end

Attempt to render a view, if needed.

=cut

sub end : ActionClass('RenderView') { }

=head1 AUTHOR

Matthias Dietrich

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
