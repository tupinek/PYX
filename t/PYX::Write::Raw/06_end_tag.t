# Test directory.
my $test_main_dir = "$ENV{'PWD'}/t";

# Modules.
use PYX::Write::Raw;
use Test::More 'tests' => 1;

# Include helpers.
do $test_main_dir.'/get_stdout.inc';

print "Testing: End tag writing.\n";
my $ret = get_stdout('PYX::Write::Raw', $test_main_dir.'/data/end_tag1.pyx');
is($ret, '</tag>');