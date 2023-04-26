# GNOME and GDM Themes

[Back](./README.md)

## Install and Setup GNOME Themes

Download the themes from [gnome-look website](https://www.gnome-look.org/browse/).

| Category | Theme |
|-|-|
| Cursor | [Capitaine Cursors](https://www.gnome-look.org/p/1148692) |
| Icons | Papirus Dark |
| Shell | [Orchis Purple Dark Compact](https://www.gnome-look.org/p/1357889) |
| Legacy Applications | [Orchis Purple Dark Compact](https://www.gnome-look.org/p/1357889) |

The themes have to be put into ```/usr/share/themes``` or ```~/.themes```.

The cursor theme has to be put inot ```/usr/share/icons```, global location to be able to use it in GDM.

## Set Cursor for GDM

Create the configuration file ```/etc/dconf/db/gdm.d/10-cursor-settings```

```(shell)
[org/gnome/desktop/interface]
cursor-theme='capitaine-cursors'
```