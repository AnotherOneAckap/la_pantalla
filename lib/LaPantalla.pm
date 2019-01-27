package LaPantalla;
use Mojo::Base 'Mojolicious';

use LaPantalla::Model;

# This method will run once at server start
sub startup {
  my $self = shift;

  # Load configuration from hash returned by "my_app.conf"
  my $config = $self->plugin('Config');

  # Documentation browser under "/perldoc"
  $self->plugin('PODRenderer') if $config->{perldoc};

  # Router
  my $r = $self->routes;

  # Normal route to controller
  $r->get('/')->to('main#index');
  $r->get('/api/current')->to('api#current');

	$self->helper( model => sub { $self->{model} ||= LaPantalla::Model->new->load });
}

1;
