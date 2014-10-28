use strict;
use 5.10.0;

my $wikiname;

my $header = grep /headerImage/, @ARGV;
my $banner = grep /bannerImage/, @ARGV;

@ARGV = grep /\./, @ARGV;

unless($#ARGV==0){
	my $err = 
		"pushlogo requires exactly one filename, found " .
		(1+$#ARGV) . ": " .
		(join " -- ", @ARGV) . "\n";
	die $err;
}

my ($fig) = @ARGV;
die ("pushlogo currently supports png only, not $fig\n") unless
	$fig =~ /\.png$/i;

foreach(split /\n/, `env`){
	if (/WW_PUBLISH_URL/){
		chomp;
		s|.*?theobio/||;
		s|/.*||;
		$wikiname= $_;
		last;
	}
}

$wikiname .= "_header" if $header;
$wikiname .= "_banner" if $banner;

my $com = "/bin/cp -f $fig /var/www/html/theobio/logos/$wikiname.png";
print "$com\n";
system $com;
