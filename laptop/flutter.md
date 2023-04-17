# **Flutter**

[Back](./README.md)

## **Install Flutter**

Get Flutter repository

```(shell)
cd ~/.devtools
git clone --depth 1 https://github.com/flutter/flutter.git
```

Add Flutter to PATH and ensure web development works, by adding to ```~/.zshrc```

```(shell)
export PATH=~/.devtools/flutter/bin:$PATH
export CHROME_EXECUTABLE='/var/lib/flatpak/exports/bin/com.google.Chrome'
```

Then update using

```(shell)
source ~/.zshrc
```

Enable and disable platforms

```(flutter)
flutter config --enable-web
flutter config --enable-linux-desktop
flutter config --enable-windows-desktop
flutter config --enable-macos-desktop
flutter config --no-enable-android
flutter config --no-enable-ios
```

Check Flutter configuration

```(shell)
flutter doctor
```
