package Linux::FD;
BEGIN {
  $Linux::FD::VERSION = '0.005';
}

use 5.006;

use strict;
use warnings FATAL => 'all';

use Sub::Exporter -setup => { exports => [qw/eventfd signalfd timerfd/] };

use XSLoader;
XSLoader::load(__PACKAGE__, __PACKAGE__->VERSION);

sub eventfd {
	my @args = @_;
	require Linux::FD::Event;
	return Linux::FD::Event->new(@args);
}

sub signalfd {
	my @args = @_;
	require Linux::FD::Signal;
	return Linux::FD::Signal->new(@args);
}

sub timerfd {
	my @args = @_;
	require Linux::FD::Timer;
	return Linux::FD::Timer->new(@args);
}

1;



=pod

=head1 NAME

Linux::FD - Linux specific special filehandles

=head1 VERSION

version 0.005

=head1 DESCRIPTION

Linux::FD provides you Linux specific special file handles. These are

 * Event filehandles
 * Signal filehandles
 * Timer filehandles

These allow you to use conventional polling mechanisms to wait for a large variety of events.

=head1 FUNCTIONS

=head2 eventfd($initial_value)

This creates an eventfd handle. See L<Linux::FD::Event> for more information on it.

=head2 signalfd($sigset)

This creates an signalfd handle. See L<Linux::FD::Signal> for more information on it.

=head2 timerfd($clock_id)

This creates an timerfd handle. See L<Linux::FD::Timer> for more information on it.

=head1 AUTHOR

Leon Timmermans <leont@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2010 by Leon Timmermans.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut


__END__

#ABSTRACT: Linux specific special filehandles

