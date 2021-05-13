# RouterCrack
A quick project testing router password security

Trying 3-4-5 word combinations against a captured hash. 

hcd.sh 
- create a ramdisk of 2GB and mount it
- create temporary working directories
- Start looping looking for generated wordlists
- If wordlists are found cat them together
- Pass the wordlist to hashcat assign it to Core 5

makedict.sh
- grab the master wordlist
- extract 3/4/5 letter words and write them to a temp file in ram disk
- start looping through 3 letter words, spawn 5 processes (writeout.sh) assign to each free core, generate 3lw-4lw-5lw
- sleep 30's if there isn't enough disk space
- check how many threads are running - don't spawn anymore till they are finished

writeout.sh
- read parameters passed by makedict.sh
- start a loop generating 3lw-4lw-5lw
- create a new wordlist file every 9000000 lines
- write the wordlist into a random file name

diskcheck.sh
- loops every 10 seconds
- pauses the hcd.sh if there are less than 5 wordlists (better flow to hashcat)
- pauses the hcd.sh if there isn't enough disk space for more wordlists



TODO 
- Checkpoint/resume file 
- Automatically detect number of cores
- Automatically switching between generating wordlists for 3-4-5, 3-5-4 etc..etc... has to be manually changed
- Auto-tuning on wordlist sizing?
- Alert when cracked and stop the bus...?


