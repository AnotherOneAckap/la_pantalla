package LaPantalla::Controller::Api;
use Mojo::Base 'Mojolicious::Controller';

use DateTime::Format::ISO8601;

sub current {
	my ( $self ) = @_;

	my $hall_id = $self->req->param('hall_id');
	my $now = DateTime::Format::ISO8601->parse_datetime( $self->req->param('now') );

	$self->render( json => $self->model->find_schedule_blocks( hall_id => $hall_id, datetime => $now )->[0] );
}

1;
