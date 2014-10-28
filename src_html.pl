use strict;
use 5.10.0;
use HTML::Entities;

my $target = shift @ARGV;
$target =~ s/.src.html$//
	or die ("Illegal target name $target");

print '<pre><code>';
say '&lt;source-file filename="' . $target . '"&gt;';
while(<>){
	chomp;
	$_ = encode_entities($_);
	s/\t/   /g;
	s/ /&nbsp;/g;
	say;
}
print '&lt;source-file /&gt;';
say '</code></pre>';

