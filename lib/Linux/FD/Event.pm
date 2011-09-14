package Linux::FD::Event;
BEGIN {
  $Linux::FD::Event::VERSION = '0.005';
}

use 5.006;

use strict;
use warnings FATAL => 'all';
use Carp qw/croak/;
use Const::Fast;
use Linux::FD ();

use parent 'IO::Handle';

const my $fail_fd => -1;

sub new {
	my ($class, $initial) = @_;
	$initial ||= 0;

	my $fd = _new_fd($initial);
	croak "Can't open eventfd descriptor: $!" if $fd == $fail_fd;
	open my $fh, '+<&', $fd or croak "Can't fdopen($fd): $!";
	bless $fh, $class;
	return $fh;
}

1;    # End of Linux::FD::Event



=pod

=head1 NAME

Linux::FD::Event - Event filehandles for Linux

=head1 VERSION

version 0.005

=head1 SYNOPSIS

 use Linux::FD::Event;
 
 my $foo = Linux::FD::Event->new(42);
 if (fork) {
	 say $foo->get while sleep 1
 }
 else {
     $foo->add($_) while <>;
 }

=head1 METHODS

=head2 new($initial_value)

This creates an eventfd object that can be used as an event wait/notify mechanism by userspace applications, and by the kernel to notify userspace applications of events. The object contains an unsigned 64-bit integer counter that is maintained by the kernel. This counter is initialized with the value specified in the argument $initial_value.

=head2 get()

If the eventfd counter has a non-zero value, then a C<get> returns 8 bytes containing that value, and the counter's value is reset to zero. If the counter is zero at the time of the C<get>, then the call either blocks until the counter becomes non-zero, or fails with the error EAGAIN if the file handle has been made non-blocking.

=head2 add($value)

A C<add> call adds the 8-byte integer value $value to the counter. The maximum value that may be stored in the counter is the largest unsigned 64-bit value minus 1 (i.e., 0xfffffffffffffffe). If the addition would cause the counter's value to exceed the maximum, then the C<add> either blocks until a C<get> is performed on the file descriptor, or fails with the error EAGAIN if the file descriptor has been made non- blocking. A C<add> will fail with the error EINVAL if an attempt is made to write the value 0xffffffffffffffff.

=head1 AUTHOR

Leon Timmermans <leont@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2010 by Leon Timmermans.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut


__END__

#ABSTRACT: Event filehandles for Linux

