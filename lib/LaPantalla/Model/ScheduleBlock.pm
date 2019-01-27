package LaPantalla::Model::ScheduleBlock;
use Mojo::Base -base;

use DateTime::Format::ISO8601;

has 'id';
has title => '';
has body  => '';
has [qw[ datetime_begin datetime_end ]];
has halls => sub {[]};

sub new {
	my $proto = shift;

	my $self = $proto->SUPER::new( @_ );

	if ( $self->datetime_begin ) {
		$self->datetime_begin( DateTime::Format::ISO8601->parse_datetime( $self->datetime_begin ) );
	}

	if ( $self->datetime_end ) {
		$self->datetime_end( DateTime::Format::ISO8601->parse_datetime( $self->datetime_end ) );
	}

	return $self;
}

sub TO_JSON {
	my ( $self ) = @_;

	my $dtb = $self->datetime_begin;
	my $dte = $self->datetime_end;

	return {
		id => $self->id,
		title => $self->title,
		body => $self->body,
		datetime_begin => $dtb->iso8601 . $dtb->time_zone->name,
		datetime_end => $dte->iso8601 . $dtb->time_zone->name,
		halls => $self->halls
	};
}

1;
