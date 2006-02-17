# $Id: 03_parse.t,v 1.6 2006-02-17 13:49:29 skim Exp $

# Test directory.
my $test_dir = "$ENV{'PWD'}/t/PYXParser";

print "Testing: parse_file() method.\n" if $debug;

# PYX::Parser object.
my $obj = $class->new(
	'attribute' => \&attribute,
	'start_tag' => \&start_tag,
	'end_tag' => \&end_tag,
	'data' => \&data,
	'instruction' => \&instruction,
	'comment' => \&comment,
	'other' => \&other,
);

# Parse.
$obj->parse_file($test_dir.'/data/parse.pyx');

#------------------------------------------------------------------------------
sub attribute {
#------------------------------------------------------------------------------
# Process attributes.

	my ($self, $att, $attval) = @_;
	ok($self->{'line'}, "A$att $attval");
}

#------------------------------------------------------------------------------
sub start_tag {
#------------------------------------------------------------------------------
# Process start tag.

	my ($self, $tag) = @_;
	ok($self->{'line'}, "($tag");
}

#------------------------------------------------------------------------------
sub end_tag {
#------------------------------------------------------------------------------
# Process end tag.

	my ($self, $tag) = @_;
	ok($self->{'line'}, ")$tag");
}

#------------------------------------------------------------------------------
sub data {
#------------------------------------------------------------------------------
# Process data.

	my ($self, $data) = @_;
	ok($self->{'line'}, "-$data");
}

#------------------------------------------------------------------------------
sub instruction {
#------------------------------------------------------------------------------
# Process instruction.

	my ($self, $target, $data) = @_;
	ok($self->{'line'}, "?$target $data");
}

#------------------------------------------------------------------------------
sub comment {
#------------------------------------------------------------------------------
# Process comment.

	my ($self, $comment) = @_;
	ok($self->{'line'}, "_$comment");
}

#------------------------------------------------------------------------------
sub other {
#------------------------------------------------------------------------------
# Process other.

	my ($self, $other) = @_;
	ok($self->{'line'}, $other);
}
