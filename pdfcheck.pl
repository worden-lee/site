while(<>){
	last if $page=/\bPage\b/;
}
die ("PDF file has no pages\n") unless $page;
