![](https://i.imgur.com/SOY1YI9.png)

![](https://i.imgur.com/jYtlKxJ.png)

This little WSL 2 distro is just created out of my boredom.

# Installation

Since `genie` is shipped with this distro, make sure you set the default version of WSL to 2

```
wsl --set-default-version 2
```

On unpacking the release tarball, run `ArchExperience.exe` once for registering this distro to WSL

![](https://i.imgur.com/VlWzzdq.png)

Run `ArchExperience.exe` twice for post-installation procedure

![](https://i.imgur.com/UZuHOon.png)

![](https://i.imgur.com/rKn3fno.png)

After this, start your ArchExperience instance through Windows Terminal

# Post-Installation

`genie` is shipped with this distro, therefore, if you want to utilise `systemd`, just issue `genie -s`

```
genie -s
```

If you use Windows Terminal, you might want to add the following line to ArchExperience's configuration object

```
"commandline": "wsl -d ArchExperience genie -s",
```

To set the regular user you've created as the default user (by default, the default user is `root`), issue this at the location where you installed this distro

```
./ArchExperience config --default-uid 1000
```

Do not attempt to execute any power management command, or try to terminate your `systemd` bottle with `genie -u`, since it may cause kernel issues. Always use `wsl -t` or `wsl --shutdown` if you have to.

```
# Don't do
genie -u || systemctl poweroff

# Do
wsl -t ArchExperience || wsl --shutdown
```

# Special thanks

This method would not be made possible without the elegant work of `yuk7` and `arkane-system`. Your works are really appreciated.
