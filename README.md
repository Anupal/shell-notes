# Shell scripting notes
My notes for Linux shell scripting notes based on:
- Flavio Copes Linux Handbook: https://www.freecodecamp.org/news/the-linux-commands-handbook/
- Freecodecamp Bash Scripting: https://www.youtube.com/watch?v=ZtqBQ68cfJc&t=120s
- Random Googling and Work Experience

#### ls
list stuff
```bash
ls -l # display as formatted list
ls -t # sort by time, recent first
ls -a # show hidden files as well
ls -r # sort in reverse
ls -h # show file sizes in human form
```
```bash
ls -ltah
anupal@MSI:~/workspace$ ls -ltah
total 28K
drwxr-xr-x 23 anupal anupal 4.0K May  1 21:20 ..
-rw-r--r--  1 anupal anupal  411 Apr 17 15:27 Dockerfile
drwxr-xr-x  2 anupal anupal 4.0K Apr 17 15:27 logs
-rwxr-xr-x  1 anupal anupal  263 Apr 17 15:16 build-image.sh
drwxr-xr-x  8 anupal anupal 4.0K Apr 17 14:54 .git
drwxr-xr-x  4 anupal anupal 4.0K Apr 17 14:53 .
-rw-r--r--  1 anupal anupal    0 Sep 25  2021 pip-packages
-rw-r--r--  1 anupal anupal  922 Sep 25  2021 README.md
```

#### pwd
shows current directory

#### mkdir
create new directory
```bash
mkdir directory-name
# create nested directory as well
mkdir -p directory/sub-directory
```

#### rmdir and rm
delete file or directory
```bash
# deletes empty directory
rmdir directory1
# deletes populated directory
rm -r directory1
# delete file
rm file1 file2
# force delete file or directory
rm -rf file1 directory1
```

#### mv
move or rename file or directory
```bash
# move file
mv file1 ~/some/other/path/
# move directory
mv dir1 ~/some/other/path/
# rename
mv old-name new-name
```

#### cp
copy stuff
```bash
# copy file
cp file1 file1-copy
# copy directory
cp -r dir1 dir2
```

#### open (Mac Only)
opens directory or application in Finder
```bash
# open current directory
open .
# open specified directory
open dir1
# open application
open <app-name>
```

#### touch
create new file or update timestamp of existing file
```bash
touch file1
```

#### find
Find files and directories, optionally execute stuff on results
```bash
# find files by name and wildcard in current directory
find . -name '*.js'
# find only files
find . -type f -name file1
# find only directories
find . -type d -name dir1
# find only links
find . -type l -name link1
# case insensitive search
find . -iname name1

# filter by size
# greater than 100 bytes
find . -size +100c -name somename
# greater than 100KB and smaller than 1M
find . -size +100KB -size -1M -name somename

# timestamp
# last modified more than 3 days ago
find . -type f -mtime +3
# last modified in last 24 hours
find -mtime -1
```

Find and execute on each result
```bash
find . -type -f -exec rm -rf {} \;
find . -type -f -exec cat {} \;
```

#### ln
Creates link (like shortcut on windows) for file or directory
##### hard link
- Points to the memory location where file is stored
- Still valid if original file is deleted
```bash
ln original-file link-name
```

##### soft link
- points to the path of the original
- becomes invalid if original is deleted
```bash
anupal@MSI:~/scratchpad$ ln -s ../alt-party/Dockerfile
anupal@MSI:~/scratchpad$ ls -ltha
total 8.0K
drwxr-xr-x  2 anupal anupal 4.0K May  1 22:15 .
lrwxrwxrwx  1 anupal anupal   23 May  1 22:15 Dockerfile -> ../alt-party/Dockerfile
drwxr-xr-x 24 anupal anupal 4.0K May  1 22:14 ..
```

#### gzip
compress a file using LZ777 compression protocol
```bash
# deletes original
gzip file
# retains original
gzip -k file

# compress all files in a directory
anupal@MSI:~/scratchpad$ gzip -kr temp
anupal@MSI:~/scratchpad$ cd temp
anupal@MSI:~/scratchpad/temp$ ls
a.txt  a.txt.gz  b.txt  b.txt.gz
```

compression levels 1 (fastest) to 9 (slowest, best)
```bash
gzip -9 file1
```

decompress
```bash
gzip -d file.gz
```

#### tar
creates an archive of specified files and folders (optionally gzip as well), can also extract
```bash
# create an archive of files
tar -cf archive.tar file1 file2
# extract archive
tar -xf archive.tar
# extract archive to specified directory
tar -xf archive.tar -C directory

# create archive and compress
tar -czf archive.tar.gz file1 file2
# extract and decompress
tar -xf archive.tar.gz
```

#### alias
create alias for commonly used commands to save time
```bash
alias psgrep='ps aux | grep'
```

##### RC file stuff
- only saved to current terminal session. So, save to rc file for future use.
- distiction between single and double quotes
```bash
# gets executed when rc file is sources so shows incorrect value of PWD
alias lsthis="ls $PWD"
# gets executed everytime the alias is called
alias lscurrent='ls $PWD'
```