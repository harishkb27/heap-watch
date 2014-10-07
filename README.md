# MOM Heap Watch

Use *Mom Heap Watch* to monitor heap space usage by java applications. 

## Structure
   
	├── heap_watch.awk
	├── heap_watch.sh
	├── holder.html
	└── README.md

## Prerequisites

* **jvm** such as *java-x-sun-x.x.x.x*. Also, make sure *jmap* is available in */path/to/jvm/bin/* directory.
* **sendmail** utility. In ubuntu, it can be installed by *sudo apt-get install sendmail*.

## Usage

	sudo su
	cd /path/to/MomHeapWatch/
	heap_watch.sh -b <path/to/java/bin> -t <mail-recipient> -f <yes to get report even if heap space is normal>

Upon successful execution, an email would be sent with the stats related to *Heap configuration* and *Heap usage*.