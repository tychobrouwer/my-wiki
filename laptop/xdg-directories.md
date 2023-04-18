# **XDG Directories**

[Back](./README.md)

## **Change XDG Directories**

Change the user dirs config file ```~/.config/user-dirs.dirs```

```(shell)
XDG_MUSIC_DIR="$HOME/School"
XDG_VIDEOS_DIR="$HOME/Projects"
```

Set permissions so it cannot be overwritten

```(shell)
chmod 0400 ~/.config/user-dirs.dirs
```

## **Change Icons for Special Directories**

Run a script to change the icons of the music and videos folders to the default folder icon

```(shell)
#!/bin/bash
#set_icons.sh

# $1: replacement icon
# $2: icon to replace

i=0
for d in `ls -d /usr/share/icons/Papirus-Dark/*/places/`
do
 if [[ ! -f $d$1 || ! -f $d$2 ]]; then
  continue
 fi

 if [ ! -f $d$2.old ]; then
  cp $d$2 $d$2.old

  i++
 else
  continue
 fi

 cp $d$1 $d$2
done

if [ ! $i == 0 ]; then
 echo "updated"
fi
```

Run with

```(shell)
./set_icons.sh folder-documents.svg folder-music.svg
./set_icons.sh folder-documents.svg folder-videos.svg
```

Then set the symbolic icons with the following script

```(shell)
#!/bin/bash
#set_symbolic_icons.sh

# $1: replacement icon
# $2: icon to replace

update=false
if [ ! -f $d$2.old ]; then
 cp /usr/share/icons/Papirus-Dark/symbolic/places/$2 /usr/share/icons/Papirus-Dark/symbolic/places/$2.old

 $update=true
fi

cp /usr/share/icons/Papirus-Dark/symbolic/places/$1 /usr/share/icons/Papirus-Dark/symbolic/places/$2

if [ $update == true ]; then
 echo "updated"
fi
```

Run with

```(shell)
./set_symbolic_icons.sh folder-documents-symbolic.svg folder-music-symbolic.svg
./set_symbolic_icons.sh folder-documents-symbolic.svg folder-videos-symbolic.svg
```

</br>

[Top](#xdg-directories)
