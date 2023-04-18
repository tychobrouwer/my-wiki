# **dconf Settings**

[Back](./README.md)

## **Configure Settings Using dconf**

Set the following dconf settings for personalization of nautilus, ArcMenu, and system.

```(shell)
dconf write /org/gnome/nautilus/list-view/default-visible-columns \
    ['name', 'size', 'owner', 'group', 'permissions', 'date_modified']
dconf write /org/gnome/nautilus/list-view/default-zoom-level 'small'
dconf write /org/gnome/nautilus/preferences/default-folder-viewer 'list-view'
dconf write /org/gnome/nautilus/preferences/search-view 'list-view'

dconf write /org/gnome/desktop/interface/clock-format '24h'
dconf write /org/gnome/desktop/interface/clock-show-seconds true
dconf write /org/gnome/desktop/interface/clock-show-weekday true
dconf write /org/gnome/desktop/interface/enable-animations true
dconf write /org/gnome/desktop/interface/font-antialiasing 'rgba'
dconf write /org/gnome/desktop/interface/font-hinting 'none'
dconf write /org/gnome/desktop/privacy/remember-recent-files false

dconf write /org/gnome/shell/extensions/arcmenu/arc-menu-icon 71
dconf write /org/gnome/shell/extensions/arcmenu/button-padding -1
dconf write /org/gnome/shell/extensions/arcmenu/custom-menu-button-icon-size 38
dconf write /org/gnome/shell/extensions/arcmenu/disable-recently-installed-apps true
dconf write /org/gnome/shell/extensions/arcmenu/disable-tooltips true
dconf write /org/gnome/shell/extensions/arcmenu/distro-icon 16
dconf write /org/gnome/shell/extensions/arcmenu/left-panel-width 215
dconf write /org/gnome/shell/extensions/arcmenu/menu-button-icon 'Menu_Icon'
dconf write /org/gnome/shell/extensions/arcmenu/menu-button-position-default 0
dconf write /org/gnome/shell/extensions/arcmenu/menu-height 650
dconf write /org/gnome/shell/extensions/arcmenu/menu-item-grid-icon-size 'Small'
dconf write /org/gnome/shell/extensions/arcmenu/menu-item-icon-size 'Small'
dconf write /org/gnome/shell/extensions/arcmenu/menu-layout 'Windows'
dconf write /org/gnome/shell/extensions/arcmenu/multi-monitor true
dconf write /org/gnome/shell/extensions/arcmenu/windows-disable-frequent-apps true

dconf write /system/locale/region 'nl_NL.UTF-8'
```
