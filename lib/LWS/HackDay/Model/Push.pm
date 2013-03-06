package LWS::HackDay::Model::Push;
use Moose;
use namespace::autoclean;

extends 'Catalyst::Model';

use WWW::Pusher;

has 'auth_key' => (is => 'ro', isa => 'Str', required => 1);
has 'secret'   => (is => 'ro', isa => 'Str', required => 1);
has 'app_id'   => (is => 'ro', isa => 'Str', required => 1);
has 'channel'  => (is => 'ro', isa => 'Str', required => 1);

=head1 NAME

LWS::HackDay::Model::Push - Catalyst Model

=head1 DESCRIPTION

Catalyst Model.

=head1 AUTHOR

Matthias Dietrich

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

sub execute {
    my ($self, $event) = @_;

    my $pusher = WWW::Pusher->new(
        auth_key => $self->auth_key,
        secret   => $self->secret,
        app_id   => $self->app_id,
        channel  => $self->channel,
    );

    my $push_data = {
        amount    => $event->{origin_amount},
        currency  => $event->{currency},
        date      => $event->{created_at},
        card_type => $event->{payment}->{card_type},
    };

    return $pusher->trigger(event => 'transaction_received', data => $push_data);
}

__PACKAGE__->meta->make_immutable;

1;
