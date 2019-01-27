package LaPantalla::Model;
use Mojo::Base -base;

use YAML;

has halls => sub { [] };
has schedule_blocks => sub { [] };

use Mojo::Loader qw(find_modules load_class);
 
# Find modules in a namespace
for my $module (find_modules 'LaPantalla::Model') {
	# Load them safely
	my $e = load_class $module;
	warn qq{Loading "$module" failed: $e} and next if ref $e;
}

sub load {
	my ( $self ) = @_;

	my $data = YAML::LoadFile('data.yml');

	my $halls = [];

	for my $h ( @{ $data->{halls} } ) {
		push @$halls, LaPantalla::Model::Hall->new($h);
	}

	$self->halls( $halls );

	my $schedule_blocks = [];

	for my $h ( @{ $data->{schedule_blocks} } ) {
		push @$schedule_blocks, LaPantalla::Model::ScheduleBlock->new($h);
	}

	$self->schedule_blocks( $schedule_blocks );

	return $self;
}

sub find_schedule_blocks {
	my ( $self, %args ) = @_;

	my @blocks = @{$self->schedule_blocks};

	if ( defined $args{hall_id} ) {
		my $hid = $args{hall_id};
		@blocks = grep { scalar grep { $_ == $hid } @{$_->halls} } @blocks;
	}

	if ( defined $args{datetime} ) {
		my $dt = $args{datetime};
		@blocks = grep { DateTime->compare( $dt, $_->datetime_begin ) >= 0 && DateTime->compare( $dt, $_->datetime_end ) < 0 } @blocks;
	}

	return [ @blocks ];
}

1;
