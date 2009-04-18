#------------------------------------------------------------------------------
package PYX::Stack;
#------------------------------------------------------------------------------

# Pragmas.
use strict;
use warnings;

# Modules.
use Error::Simple::Multiple qw(err);
use PYX::Parser;

# Version.
our $VERSION = 0.01;

# Global variables.
use vars qw($stack $verbose);

#------------------------------------------------------------------------------
sub new {
#------------------------------------------------------------------------------
# Constructor.

	my ($class, @params) = @_;
	my $self = bless {}, $class;

	# Output handler.
	$self->{'output_handler'} = \*STDOUT;

	# Verbose.
	$self->{'verbose'} = 0;

	# Process params.
	while (@params) {
		my $key = shift @params;
		my $val = shift @params;
		if (! exists $self->{$key}) {
			err "Unknown parameter '$key'.";
		}
		$self->{$key} = $val;
	}

	# PYX::Parser object.
	$self->{'pyx_parser'} = PYX::Parser->new(
		'end_tag' => \&_end_tag,
		'output_handler' => $self->{'output_handler'},
		'start_tag' => \&_start_tag,
	);

	# Tag values.
	$stack = [];

	# Verbose.
	$verbose = $self->{'verbose'};

	# Object.
	return $self;
}

#------------------------------------------------------------------------------
sub parse {
#------------------------------------------------------------------------------
# Parse pyx text or array of pyx text.

	my ($self, $pyx, $out) = @_;
	$self->{'pyx_parser'}->parse($pyx, $out);
	return;
}

#------------------------------------------------------------------------------
sub parse_file {
#------------------------------------------------------------------------------
# Parse file with pyx text.

	my ($self, $file) = @_;
	$self->{'pyx_parser'}->parse_file($file);
	return;
}

#------------------------------------------------------------------------------
sub parse_handler {
#------------------------------------------------------------------------------
# Parse from handler.

	my ($self, $input_file_handler, $out) = @_;
	$self->{'pyx_parser'}->parse_handler($input_file_handler, $out);
	return;
}

#------------------------------------------------------------------------------
# Internal methods.
#------------------------------------------------------------------------------

#------------------------------------------------------------------------------
sub _start_tag {
#------------------------------------------------------------------------------
# Process tag.

	my $pyx_parser_obj = shift;
	my $tag = shift;
	my $out = $pyx_parser_obj->{'output_handler'};
	push @{$stack}, $tag;
	if ($verbose) {
		print {$out} join('/', @{$stack}), "\n";
	}
	return;
}

#------------------------------------------------------------------------------
sub _end_tag {
#------------------------------------------------------------------------------
# Process tag.

	my $pyx_parser_obj = shift;
	my $tag = shift;
	my $out = $pyx_parser_obj->{'output_handler'};
	if ($stack->[-1] eq $tag) {
		pop @{$stack};
	}
	if ($verbose && $#{$stack} > -1) {
		print {$out} join('/', @{$stack}), "\n";
	}
	return;
}

1;
