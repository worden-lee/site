#!/usr/bin/perl
my $pdffile = $ARGV[0];
my $pages = `pdfinfo $pdffile | grep Pages`;
$pages =~ s/Pages:\s+//;
my $base = $pdffile;
$base =~ s/\.pdf$//;
for my $page (0 .. ($pages - 1)) {
  my $cmd = "convert $pdffile\[$page] $base.$page.png";
  print STDERR "$cmd\n";
  system($cmd) == 0 or die "Convert failed";
  print "<project-file filename=\"$base.$page.png\" make=\"no\"/><br/>";
}
