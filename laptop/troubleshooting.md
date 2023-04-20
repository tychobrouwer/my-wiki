# Troubleshooting

[Back](./README.md)

## Navigate

- [Wayland Session Not Working](#wayland-session-not-working)

## Wayland Session Not Working

If Wayland session is not working but x11 session is working, check the ownership of ```/``` with

```(shell)
stat /
```

If this is owned by Uid 1000 and Gid 1000, the permissions are wrong, run

```(shell)
sudo chown root:root /
```

And reboot

## ArcMenu Empty

If the ArcMenu is empty and only shows the triple dot menu, reinstall the ArcMenu extension by first removing the folder

```(shell)
sudo rm -r /usr/share/gnome-shell/extensions/arcmenu@arcmenu.com
```

or

```(shell)
sudo rm -r ~/.local/share/gnome-shell/extensions/arcmenu@arcmenu.com
```

Then log out, and install the extension again with the extension manager

```(shell)
extension-manager
```
