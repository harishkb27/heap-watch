#!/bin/bash
# @author: Harish K B
# @email: harish.kb27@gmail.com

function usage {
	echo "usage: `basename $0` -b <path/to/java/bindir> [-t <mail-recipient>] [-i to receive emails with heap conditions being normal]"
        exit
}

if [[ "$#" -ne 2 && "$#" -ne 4 && "$#" -ne 5 ]]; then
	usage
fi

INFO="no"
while getopts ":b:t:i" opt;do
	case $opt in
	  b) JAVA_BIN_DIR="$OPTARG"
	  ;;
	  t) RECPT="$OPTARG"
	  ;;
	  i) INFO="yes"
	  ;;
	  \?) echo "Invalid option -$OPTARG" >&2;
	      usage
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
MAIL_HDR="Subject: $HOSTNAME heap space alert"$'\nFROM: heapwatch@example.com\nMIME-Version: 1.0\nContent-Type: text/html;charset="us-ascii"\n\n'
HOLDER_HTML="$( cat "$HEAP_WATCH_HOME/holder.html" )"

for i in `ps aux |grep java | awk '{print $2;}'`;do 
	echo "checking $i...";
	stats="`$JAMP -heap $i`"
	out="`echo "$stats" | awk -f $HEAP_WATCH_AWK 2>&1`"
	if [[ "$out" =~ "danger"  || "$INFO" == "yes" ]]; then
		ps="`date`"$'\n'"$( ps $i | awk '!/TTY/ {print $(NF-2);}' )"$'\n\n'
		mail_cont="$MAIL_HDR"${HOLDER_HTML/heap_watch_input/"$ps""$stats"}
		echo "$mail_cont" | sendmail "$RECPT"
	else
		echo "$stats"
	fi
done
