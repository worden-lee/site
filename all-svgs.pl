#!/usr/bin/perl
my $pdffile = $ARGV[0];
my $pages = `pdfinfo $pdffile | grep Pages`;
$pages =~ s/Pages:\s+//;
my $base = $pdffile;
$base =~ s/\.pdf$//;
for my $page (1 .. $pages) {
  my $cmd = "pdf2svg $pdffile $base.$page.svg $page";
  print STDERR "$cmd\n";
  system($cmd) == 0 or die "Convert failed";
  print "<project-file filename=\"$base.$page.svg\" make=\"no\"/><br/>";
}
