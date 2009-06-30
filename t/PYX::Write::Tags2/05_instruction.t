# Modules.
use File::Object;
use PYX::Write::Tags2;
use Tags2::Output::Raw;
use Test::More 'tests' => 2;

# Directories.
my $data_dir = File::Object->new->up->dir('data')->serialize;

# Include helpers.
do File::Object->new->up->file('get_stdout.inc')->serialize;

print "Testing: Instruction writing.\n";
my $tags2 = Tags2::Output::Raw->new(
	'xml' => 1,
);
my $obj = PYX::Write::Tags2->new(
	'tags_obj' => $tags2,
);
get_stdout($obj, "$data_dir/instruction1.pyx");
is($tags2->flush, '<?target code?>');

$tags2->reset;
get_stdout($obj, "$data_dir/instruction2.pyx");
is($tags2->flush, "<?target data\\ndata?>");
