# Shell scripting notes

#### TODO: add ToC

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

#### cat
contatenate files to stdout
```bash
# print contents of files concatened in terminal window
cat file1 file2
# save output to a file
cat file1 file2 > file3
# print line numbers as well
cat -n file1 file2
# remove all multiple empty lins
cat -s file1
```

#### less
preview contents of a file in a dedicated view with extra features
```bash
less file1
```
- `q` to quit
- `up` and `down` to navigate line by line
- `space` and `b` to navigate page by page
- `g` go to start of file
- `G` go to end of file
- search for word using `/` and move forward and `?` to move backward
- `F` to tail

##### Open multiple files
```bash
less file1 file2
```
- `:n` next file
- `:p` previous file

#### tail
view from end of file
```bash
# print last 10 lines
tail -n 10 file1
# print new content as it gets added to file
tail -f file1.log
# print content starting from specific line
tail -n +10 file1.log
```

#### wc
prints number of characters, words, and lines
```bash
# check in file
wc file1
# check in piped output
ls -la | wc
```
- `-w` for only word count
- `-c` for only char count
- `-l` for only line count
- `m` for non-ASCII charsets

#### grep
search for strings in file or output
```bash
# find occurences of string with line numbers
grep -n string file1
# find and print 2 lines before and after
grep -nC 2 string file1
# search case insensitive
grep -n -i string file1
# print only the match
grep -n -o string file1

# search regex
anupal@MSI:~/alt-party$ ls -ltha | grep -E "*Apr*"
-rw-r--r--  1 anupal anupal  411 Apr 17 15:27 Dockerfile
drwxr-xr-x  2 anupal anupal 4.0K Apr 17 15:27 logs
-rwxr-xr-x  1 anupal anupal  263 Apr 17 15:16 build-image.sh
drwxr-xr-x  8 anupal anupal 4.0K Apr 17 14:54 .git
drwxr-xr-x  4 anupal anupal 4.0K Apr 17 14:53 .
```

#### sort
sorts lines in output or file
```bash
sort file1
# reverse
sort -r file1
# case insensitive
sort --ignore-case file1
# numeric sort
sort -n file1
# remove duplicates
sort -u file1
# piped
ls -ltah | sort
```

#### uniq
- remove or show duplicate lines
- works only on adjacent duplicates
```bash
# remove duplicates
sort list.txt | uniq
# show only duplicates
sort list.txt | uniq -d
# print occurences of each line
sort list.txt | uniq -c
# print occurences of each line and sort by occurence
sort list.txt | uniq -c | sort -nr
```

#### diff
display difference between two files
```bash
diff file1 file2
```
##### interprettin changes
- `2a3` line 3 added after 2
- `3d2` line 3 deleted
- `1c1,2` change on line 1 and 2

##### extras
- `-y` show side by side
- `u` show like git
- `-r` compare directories, `-q` will only tell which files differ

```bash
anupal@MSI:~/scratchpad$ diff anupal.txt anupal2.txt
1c1,2
< anupal mishra
---
> anupal-mishra--
> mishra anupal
anupal@MSI:~/scratchpad$
anupal@MSI:~/scratchpad$ diff anupal.txt anupal2.txt -u
--- anupal.txt  2022-05-02 00:03:09.827219900 +0530
+++ anupal2.txt 2022-05-02 00:04:48.387219900 +0530
@@ -1 +1,2 @@
-anupal mishra
+anupal-mishra--
+mishra anupal
anupal@MSI:~/scratchpad$ diff anupal.txt anupal2.txt -y
anupal mishra                                                 | anupal-mishra--
                                                              > mishra anupal
```

#### echo
prints stuff
- `-n` no trailing new line
- `-e` support escape sequence

```bash
# output to file
echo "something" >> file
# use env variables
echo "some variable $VAR"

# expansions
# echo all files that start with o
echo o*
# execute and echo
echo $(ls -al)
# echo range as list of strings
echo {1..5}
```

#### chown
change ownership of files and directories
```bash
# file
chown <owner>:<group> <file>
# directory and children
chown -R <owner>:<group> <directory>
```

#### chmod
change file/directory permissions w.r.t owner, group and other users

```bash
anupal@MSI:~/scratchpad$ ls -lath
total 28K
drwxr-xr-x  4 anupal anupal 4.0K May  2 00:04 .
drwxr-xr-x 25 anupal anupal 4.0K May  2 00:04 ..
-rw-r--r--  1 anupal anupal   30 May  2 00:04 anupal2.txt
-rw-r--r--  1 anupal anupal   14 May  2 00:03 anupal.txt
drwxr-xr-x  3 anupal anupal 4.0K May  1 22:39 abc
-rw-r--r--  1 anupal anupal  345 May  1 22:35 temp.tar.gz
drwxr-xr-x  2 anupal anupal 4.0K May  1 22:25 temp
lrwxrwxrwx  1 anupal anupal   23 May  1 22:15 Dockerfile -> ../alt-party/Dockerfile
```
`drwxr-xr-x` defines the permissions of the file or directory
- first letter indicates type - `d` directory, `-` file and `l` link
- then 3 sets of 3 chars representing permissions for owner, group and others
- `rwx` means read, write and execute permissions

#### using chmod to change permissions
- `chmod` followed by one or more char
  - `a` stands for all
  - `u` stands for user
  - `g` stands for group
  - `o` stands for others
- `+` to add and `-` to remove
- one or more permission symbols `r`, `w` and `x`

#### umask
change default permissions applied to files and directories
```
# display defaults
umask
# display defaults in human readable form
umask -S
# change
umask g+r
```

#### du
calculates size of files and directories in current directory and displays in bytes
```bash
du
du *
# display files in sub-directories
du -a
# display in human readable
du -h
# mb
du -m
# gb
du -g
# display and sort
du -h <directory> | sort -nr
du -h <directory> | sort -nr | head
```

#### df
display disk usage info

## References

- Flavio Copes Linux Handbook: https://www.freecodecamp.org/news/the-linux-commands-handbook/
- Freecodecamp Bash Scripting: https://www.youtube.com/watch?v=ZtqBQ68cfJc&t=120s
- Grep regex: https://linuxize.com/post/regular-expressions-in-grep/