# TMUX notes

[References](#references)

## Config
#### Prefix-key is `Ctrl`+`b`
Type command key after typing prefix-key, eg: to detach terminal - `Ctrl` + `b` then relase keys and type `d`
#### User config
Create config file and edit it
```
tmux show -g > ~/.tmux.conf
```
#### Enable mouse
Edit config file
and change `mouse off` to `mouse on`

## Commands
### Outside tmux
Create session
```sh
# create session with name
tmux new-session -s <name>
# create session with name and window name
tmux new-session -s <session-name> -n <window-name>
```
List sessions
```sh
tmux ls
```
Attach to session
```
tmux attach -t <name>
```
Kill a session
```
tmux kill-session -t <name>
```
Remame session
```
tmux rename-session it <old> <new>
```

### Inside tmux
Detach session
```
<prefix> + d
```
#### Windows
New windows
```
<prefix> + c
```
List windows and switch
```
<prefix> + w
```
Rename window
```
<prefix> + ,
```
#### Panes
Split into panes
```
# horizontally
<prefix> + "
# vertifally
<prefix> + %
```
Switch panes
```
<prefix> + <arrow-key>
```
#### Scrolling
1. Type `<prefix>` followed by `[]`
2. Use arrow keys to move cursor
3. Press `esc` to exit this mode

#### Copying stuff
1. Enter copy mode - `<prefix> + [`
2. Move cursor to point from where you wanna copy
3. Start selection - `<prefix> + <space>`
4. Done - `<prefix> + ]`

## References
- https://www.baeldung.com/linux/tmux
- https://waylonwalker.com/tmux-prefix/
