# $Id: 06_comment.t,v 1.2 2005-06-26 16:36:52 skim Exp $

print "Testing: comment() function.\n" if $debug;
my $comment = 'comment';
my $ret = eval $class.'::comment($comment)';
ok($ret, 'Ccomment');

$comment = "comment\ncomment";
$ret = eval $class.'::comment($comment)';
ok($ret, 'Ccomment\ncomment');
