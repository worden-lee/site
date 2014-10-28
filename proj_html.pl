use strict;
use 5.10.0;

my ($target) = @ARGV;
$target =~ s/.proj.html$//
	or die ("Illegal target name $target in proj_html.pl");

say 
	'<pre><code>&lt;project-file filename="'
	. $target
	. '"/&gt</code></pre>'
;

