#!/bin/bash
# @author: Harish Bujanga
# @email: harish.bujanga@mapofmedicine.com

if [[ "$#" -ne 4 && "$#" -ne 6 ]]; then
	echo "usage: `basename $0` -b <path/to/java/bin> -t <mail-recipient> -f <yes to get report even if heap space is normal>"
	exit
fi

INFO="no"
while getopts ":b:t:f:" opt;do
	case $opt in
	  b) JAVA_BIN_DIR="$OPTARG"
	  ;;
	  t) RECPT="$OPTARG"
	  ;;
	  f) INFO="$OPTARG"
	  ;;
	  \?) echo "Invalid option -$OPTARG" >&2;
	      echo "usage: `basename $0` -b <path/to/java/bin> -t <mail-recipient> -f <yes to get report even if heap space is normal>"
	      exit
	  ;;
	esac	
done

if [ ! -d "$JAVA_BIN_DIR" ]; then
	echo "No such directory: $JAVA_BIN_DIR" >&2
	exit
fi

HEAP_WATCH_HOME="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd)"
HEAP_WATCH_AWK=$HEAP_WATCH_HOME/heap_watch.awk
JAMP=$JAVA_BIN_DIR/jmap
MAIL_HDR="Subject: $HOSTNAME heap space alert"$'\nFROM: heapwatch@mapofmedicine.com\nMIME-Version: 1.0\nContent-Type: text/html;charset="us-ascii"\n\n'
HOLDER_HTML="$( cat "$HEAP_WATCH_HOME/holder.html" )"

for i in `ps aux |grep java | awk '{print $2;}'`;do 
	echo "checking $i...";
	stats="`$JAMP -heap $i`"
	out="`echo "$stats" | awk -f $HEAP_WATCH_AWK 2>&1`"
	if [[ "$out" =~ "danger"  || "$INFO" == "yes" ]]; then
		ps="`date`"$'\n'"$( ps $i | awk '!/TTY/ {print $(NF-2);}' )"$'\n\n'
		mail_cont="$MAIL_HDR"${HOLDER_HTML/heap_watch_input/"$ps""$stats"}
		echo "$mail_cont" | sendmail "$RECPT"
	fi
done
