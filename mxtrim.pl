#!/usr/bin/perl -w

use strict;

while(<>){
	last if /batching/;
	last if /interpret file/;
}

# Allow suppression of save lines, last record line
while(<>){
	print unless (/NOPRINT/ or /^\(%o[0-9]+\) *\w+\.mx/);
}

