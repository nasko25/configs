Installation
------------

Requirements:

  - tmux **`>= 2.1`** (soon `>= 2.4`) running inside Linux, Mac, OpenBSD, Cygwin
    or WSL
  - awk, perl and sed
  - outside of tmux, `$TERM` must be set to `xterm-256color`

```
$ cd
$ #git clone https://github.com/gpakosz/.tmux.git
$ ln -s -f .tmux/.tmux.conf
$ cp .tmux/.tmux.conf.local .
```

If you're a Vim user, setting the `$EDITOR` environment variable to `vim` will enable and further customize the vi-style key bindings (see tmux manual).

Bindings
--------

tmux may be controlled from an attached client by using a key combination of a
prefix key, followed by a command key. This configuration uses `C-a` as a
secondary prefix while keeping `C-b` as the default prefix. In the following
list of key bindings:
  - `<prefix>` means you have to either hit <kbd>Ctrl</kbd> + <kbd>a</kbd> or <kbd>Ctrl</kbd> + <kbd>b</kbd>
  - `<prefix> c` means you have to hit <kbd>Ctrl</kbd> + <kbd>a</kbd> or <kbd>Ctrl</kbd> + <kbd>b</kbd> followed by <kbd>c</kbd>
  - `<prefix> C-c` means you have to hit <kbd>Ctrl</kbd> + <kbd>a</kbd> or <kbd>Ctrl</kbd> + <kbd>b</kbd> followed by <kbd>Ctrl</kbd> + <kbd>c</kbd>

This configuration uses the following bindings:

 - `<prefix> e` opens `~/.tmux.conf.local` with the editor defined by the
   `$EDITOR` environment variable (defaults to `vim` when empty)
 - `<prefix> r` reloads the configuration
 - `C-l` clears both the screen and the tmux history

 - `<prefix> C-c` creates a new session
 - `<prefix> C-f` lets you switch to another session by name

 - `<prefix> C-h` and `<prefix> C-l` let you navigate windows (default
   `<prefix> n` and `<prefix> p` are unbound)
 - `<prefix> Tab` brings you to the last active window

 - `<prefix> -` splits the current pane vertically
 - `<prefix> _` splits the current pane horizontally
 - `<prefix> h`, `<prefix> j`, `<prefix> k` and `<prefix> l` let you navigate
   panes ala Vim
 - `<prefix> H`, `<prefix> J`, `<prefix> K`, `<prefix> L` let you resize panes
 - `<prefix> <` and `<prefix> >` let you swap panes
 - `<prefix> +` maximizes the current pane to a new window

 - `<prefix> m` toggles mouse mode on or off

 - `<prefix> U` launches Urlview (if available)
 - `<prefix> F` launches Facebook PathPicker (if available)

 - `<prefix> Enter` enters copy-mode
 - `<prefix> b` lists the paste-buffers
 - `<prefix> p` pastes from the top paste-buffer
 - `<prefix> P` lets you choose the paste-buffer to paste from

Additionally, `copy-mode-vi` matches [my own Vim configuration][]

[my own Vim configuration]: https://github.com/gpakosz/.vim.git

Bindings for `copy-mode-vi`:

- `v` begins selection / visual mode
- `C-v` toggles between blockwise visual mode and visual mode
- `H` jumps to the start of line
- `L` jumps to the end of line
- `y` copies the selection to the top paste-buffer
- `Escape` cancels the current operation

Configuration
-------------

### Configuring the status line

Contrary to the first iterations of this configuration, by now you have total
control on the content and order of `status-left` and `status-right`.

Edit the `~/.tmux.conf.local` file (`<prefix> e`) and adjust the
`tmux_conf_theme_status_left` and `tmux_conf_theme_status_right` variables to
your own preferences.

This configuration supports the following builtin variables:

 - `#{battery_bar}`: horizontal battery charge bar
 - `#{battery_percentage}`: battery percentage
 - `#{battery_status}`: is battery charging or discharging?
 - `#{battery_vbar}`: vertical battery charge bar
 - `#{circled_session_name}`: circled session number, up to 20
 - `#{hostname}`: SSH/Mosh aware hostname information
 - `#{hostname_ssh}`: SSH/Mosh aware hostname information, blank when not
   connected to a remote server through SSH/Mosh
 - `#{loadavg}`: load average
 - `#{pairing}`: is session attached to more than one client?
 - `#{prefix}`: is prefix being depressed?
 - `#{root}`: is current user root?
 - `#{synchronized}`: are the panes synchronized?
 - `#{uptime_y}`: uptime years
 - `#{uptime_d}`: uptime days, modulo 365 when `#{uptime_y}` is used
 - `#{uptime_h}`: uptime hours
 - `#{uptime_m}`: uptime minutes
 - `#{uptime_s}`: uptime seconds
 - `#{username}`: SSH/Mosh aware username information
 - `#{username_ssh}`: SSH aware username information, blank when not connected
   to a remote server through SSH/Mosh

Beside custom variables mentioned above, the `tmux_conf_theme_status_left` and
`tmux_conf_theme_status_right` variables support usual tmux syntax, e.g. using
`#()` to call an external command that inserts weather information provided by
[wttr.in]:
```
tmux_conf_theme_status_right='#{prefix}#{pairing}#{synchronized} #(curl wttr.in?format=3) , %R , %d %b | #{username}#{root} | #{hostname} '
```

![Weather information from wttr.in](https://user-images.githubusercontent.com/553208/52175490-07797c00-27a5-11e9-9fb6-42eec4fe4188.png)

[wttr.in]: https://github.com/chubin/wttr.in#one-line-output

### Accessing the macOS clipboard from within tmux sessions

[Chris Johnsen created the `reattach-to-user-namespace`
utility][reattach-to-user-namespace] that makes `pbcopy` and `pbpaste` work
again within tmux.

To install `reattach-to-user-namespace`, use either [MacPorts][] or
[Homebrew][]:

    $ port install tmux-pasteboard

or

    $ brew install reattach-to-user-namespace

Once installed, `reattach-to-usernamespace` will be automatically detected.

[MacPorts]: http://www.macports.org/
[Homebrew]: http://brew.sh/

### Using the configuration under Cygwin within Mintty

**I don't recommend running this configuration with Cygwin anymore. Forking
under Cygwin is extremely slow and this configuration issues a lot of
`run-shell` commands under the hood. As such, you will experience high CPU
usage. As an alternative consider using [Mintty terminal for WSL][wsltty].**

![cygwin](https://cloud.githubusercontent.com/assets/553208/19741789/67a3f3d8-9bc2-11e6-9ecc-499fc0228ee6.png)

It is possible to use this configuration under Cygwin within Mintty, however
support for Unicode symbols and emojis lacks behind Mac and Linux.

Particularly, Mintty's text rendering is implemented with GDI which has
limitations:

- color emojis are only available through DirectWrite starting with Windows 8.1
- display of double width symbols, like the battery discharging symbol indicator
  (U+1F50B) is buggy

To get Unicode symbols displayed properly, you have to use [font linking].
Open `regedit.exe` then navigate to the registry key at
`HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\FontLink\SystemLink`
and add a new entry for you preferred font to link it with the Segoe UI Symbol
font.

![regedit](https://cloud.githubusercontent.com/assets/553208/19741304/71a2f3ae-9bc0-11e6-96aa-4c09a812c313.png)

[font linking]: https://msdn.microsoft.com/en-us/goglobal/bb688134.aspx
