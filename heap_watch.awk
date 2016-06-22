BEGIN {
	print "starting heap_watch..."
}
/used/ && /%/ {
	perc = sub(/%/,"",$1);
	if($1 >= 80){
		print "danger!";
	}
}
END {
	print "Done..."
}

