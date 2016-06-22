# heap-watch

heap-watch is a utility to monitor heap space used by java applications. It uses in-built java tools to get information about the running processes and parses it to trigger email alerts upon finding excessive usage of the allocated memory.

## prerequisites
- jvm (java virtual machine) such as java-x-sun-x.x.x.x. Also, make sure `jmap` executable is available in /path/to/jvm/bin/ directory
- sendmail utility. On ubuntu,
    ```sh
    sudo apt-get install sendmail
    ```
    
## usage
To send an email when the heap space used is more than 80% of the allocated space, use the commands as below. Note that the directory path to java bin is usually `/usr/bin/`.
```sh
$ sudo su
$ cd /path/to/MomHeapWatch/
$ ./heap_watch.sh -b <path/to/java/bin-directory> -t <mail-recipient>
```
To send an email with the statistics about the heap space usage, irrespective of the heap space usage percentage, use the command below.
```sh
$ ./heap_watch.sh -b <path/to/java/bin-directory> -t <mail-recipient> -i
```
An example body of the email is as follows.
```sh
Heap Configuration:
   MinHeapFreeRatio = 40
   MaxHeapFreeRatio = 70
   MaxHeapSize      = 2105540608 (2008.0MB)
   NewSize          = 1310720 (1.25MB)
   MaxNewSize       = 17592186044415 MB
   OldSize          = 5439488 (5.1875MB)
   NewRatio         = 2
   SurvivorRatio    = 8
   PermSize         = 21757952 (20.75MB)
   MaxPermSize      = 174063616 (166.0MB)
   G1HeapRegionSize = 0 (0.0MB)

Heap Usage:
PS Young Generation
Eden Space:
   capacity = 33554432 (32.0MB)
   used     = 671200 (0.640106201171875MB)
   free     = 32883232 (31.359893798828125MB)
   2.0003318786621094% used
From Space:
   capacity = 5242880 (5.0MB)
   used     = 0 (0.0MB)
   free     = 5242880 (5.0MB)
   0.0% used
To Space:
   capacity = 5242880 (5.0MB)
   used     = 0 (0.0MB)
   free     = 5242880 (5.0MB)
   0.0% used
PS Old Generation
   capacity = 87556096 (83.5MB)
   used     = 0 (0.0MB)
   free     = 87556096 (83.5MB)
   0.0% used
PS Perm Generation
   capacity = 22020096 (21.0MB)
   used     = 2793200 (2.6638031005859375MB)
   free     = 19226896 (18.336196899414062MB)
   12.684776669456845% used

657 interned Strings occupying 42704 bytes.
```


## License

MIT


**Free Software, Hell Yeah!**
