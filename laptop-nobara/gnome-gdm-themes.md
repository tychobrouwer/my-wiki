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

## Set GNOME Font

Download the Roboto font family from [Google Fonts](https://fonts.google.com/specimen/Roboto).

In ```GNOME Tweaks > Fonts``` set the font

| Category | Font |
|-|-|
| Interface Text | Roboto 11 |
| Document Text | Roboto 11 |
| Monospace Text | Source Code Pro Regulatr 10 |
| Legacy Window Titles | Roboto Bold 11 |

## Set GNOME Bar

In ```GNOME Tweaks > Top Bar``` turn all settings on

## Set Cursor for GDM

Create the configuration file ```/etc/dconf/db/gdm.d/10-cursor-settings```

```(shell)
[org/gnome/desktop/interface]
cursor-theme='capitaine-cursors'
```