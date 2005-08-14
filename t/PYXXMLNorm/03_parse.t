# $Id: 03_parse.t,v 1.1 2005-08-14 09:41:01 skim Exp $

# Test directory.
my $test_dir = "$ENV{'PWD'}/t/PYXXMLNorm";

print "Testing: parse() method.\n" if $debug;
my $rules = {
	'tr' => ['td', 'tr'],
	'td' => ['td'],
	'table' => ['td', 'tr'],
	'html' => ['body'],
	'*' => ['br', 'hr', 'link', 'meta', 'input']
};
my $ret = go($class, "$test_dir/data/example1.pyx", $rules);
my $right_ret = <<"END";
(html
(head
(link
)link
(meta
)meta
)head
(body
(input
)input
(br
)br
(hr
)hr
)body
)html
END
ok($ret, $right_ret);

$ret = go($class, "$test_dir/data/example2.pyx", $rules);
$right_ret = <<"END";
(table
(tr
(td
-example1
)td
(td
-example2
)td
)tr
(tr
(td
-example1
)td
(td
-example2
)td
)tr
)table
END
ok($ret, $right_ret);

$ret = go($class, "$test_dir/data/example3.pyx", $rules);
ok($ret, $right_ret);