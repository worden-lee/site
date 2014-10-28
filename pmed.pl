#!/usr/bin/perl
use strict;
 
my $get = "wget -O -";
my $pub = '"http://www.ncbi.nlm.nih.gov/pubmed/PMID?dopt=MEDLINE"';
 
my $pmid = shift(@ARGV);
$pub =~ s/PMID/$pmid/;
 
my $comm = "$get $pub";
print "# $comm\n";
print `$comm`;
