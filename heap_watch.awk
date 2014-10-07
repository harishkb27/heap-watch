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

#sudo jmap -heap 8556 2>&1  | awk '/used/ && /%/ {perc = sub(/%/,"",$1);if($1 >= 75){print "danger!";}}'
