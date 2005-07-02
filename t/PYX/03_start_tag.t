# $Id: 03_start_tag.t,v 1.1 2005-06-26 16:36:08 skim Exp $

print "Testing: start_tag() function.\n" if $debug;
my $tag = 'tag';
my @attr = ();
my ($ret) = eval $class.'::start_tag($tag, @attr)';
ok($ret, '(tag');

@attr = ('par', 'val');
($ret, my $ret2) = eval $class.'::start_tag($tag, @attr)';
ok($ret, '(tag');
ok($ret2, 'Apar val');

@attr = ('par', "val\nval");
($ret, $ret2) = eval $class.'::start_tag($tag, @attr)';
ok($ret, '(tag');
ok($ret2, 'Apar val\nval');