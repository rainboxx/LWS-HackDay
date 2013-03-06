package LWS::HackDay::Model::Hooks;
use Moose;
use namespace::autoclean;

extends 'Catalyst::Model';

use WWW::Twilio::API;

has 'from'         => (is => 'ro', isa => 'Int', required => 1);
has 'to'           => (is => 'ro', isa => 'Str', required => 1);
has 'twilio_sid'   => (is => 'ro', isa => 'Str', required => 1);
has 'twilio_token' => (is => 'ro', isa => 'Str', required => 1);

=head1 NAME

LWS::HackDay::Model::Hooks - Catalyst Model

=head1 DESCRIPTION

Catalyst Model.

=head1 AUTHOR

Matthias Dietrich

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

sub add {
    my ($self, $event) = @_;

    my $entity = {
        From => $self->from,
        To   => $self->to,
        Body => 'Received '
            . sprintf('%.2f', $event->{origin_amount} / 100)
            . $event->{currency}
            . ' from '
            . $event->{payment}->{card_holder} . '.',
    };

    my $twilio = WWW::Twilio::API->new(AccountSid => $self->twilio_sid, AuthToken => $self->twilio_token);

    return $twilio->POST('SMS/Messages', %$entity);
}

__PACKAGE__->meta->make_immutable;

1;
