package LWS::HackDay::Controller::Hook;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller::REST'; }

use Data::Dumper;

__PACKAGE__->config(stash_key => 'rest', default => 'application/json');

=head1 NAME

LWS::HackDay::Controller::Hook - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub index : Path : Args(0) : ActionClass('REST') {
    my ($self, $c) = @_;
}

sub index_POST : Path : Args(0) {
    my ($self, $c) = @_;

    my $event_resource = $c->req->data->{event}->{event_resource};

    $c->model('DB::Hook')->create({ data => $event_resource });
    my $res_hooks = $c->model('Hooks')->add($event_resource);
    my $res_push  = $c->model('Push')->execute($event_resource);

    $c->log->debug(Dumper({ res => $event_resource, hooks => $res_hooks, push => $res_push }));

    $self->status_ok($c, entity => {});
}

=head1 AUTHOR

Matthias Dietrich

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
