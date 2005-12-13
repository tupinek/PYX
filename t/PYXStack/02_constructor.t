# $Id: 02_constructor.t,v 1.4 2005-12-13 22:58:03 skim Exp $

# Modules.
use IO::Scalar;

print "Testing: new('') bad constructor.\n" if $debug;
my $obj;
eval {
	$obj = $class->new('');
};
ok($@, "Unknown parameter ''.\n");

print "Testing: new('something' => 'value') bad constructor.\n" if $debug;
eval {
	$obj = $class->new('something' => 'value');
};
ok($@, "Unknown parameter 'something'.\n");

