package LaPantalla::Controller::Main;
use Mojo::Base 'Mojolicious::Controller';

sub index {
  my $self = shift;

	my $halls = $self->model->halls;

  # Render template "main/index.html.ep" with message
  $self->render(halls => $halls);
}

1;
