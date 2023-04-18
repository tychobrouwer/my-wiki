# **zsh**

[Back](./README.md)

## **Set zsh as Default Shell**

Set zsh as default shell with

### **Fedora**

```(shell)
sudo lchsh $USER
```

### **Other**

```(shell)
chsh -s $(which zsh)
```

## **Install oh-my-zsh**

Install oh-my-zsh

```(shell)
wget -O ~/.install-scripts/oh-my-zsh.sh \
    https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh
chmod +x ~/.install-scripts/oh-my-zsh.sh

~/.install-scripts/oh-my-zsh.sh
```

## **Install Powerlevel10k**

Install [Nerd Font](https://github.com/romkatv/powerlevel10k#meslo-nerd-font-patched-for-powerlevel10k) for Powerlevel10k.

Clone Powerlevel10k repository to the oh-my-zsh themes folder

```(shell)
cd ~/.oh-my-zsh/custom/themes
git clone --depth 1 https://github.com/romkatv/powerlevel10k.git
```

To configure Powerlevel10k theme run

```(shell)
exec zsh
p10k configure
```

## **Set zsh Configuration**

Set ```~/.zshrc``` to something resembling the following

```(shell)
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Lines configured by oh-my-zsh
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"

plugins=(git)

source $ZSH/oh-my-zsh.sh
# End of lines configured by oh-my-zsh


# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000

setopt autocd extendedglob nomatch notify
unsetopt beep

bindkey -e
# End of lines configured by zsh-newuser-install


# The following lines were added by compinstall
zstyle :compinstall filename '/home/tychob/.zshrc'

autoload -Uz compinit
# End of lines added by compinstall


bindkey "^[[3~" delete-char
bindkey "^[[1;5D" emacs-backward-word
bindkey "^[[1;2D" emacs-backward-word
bindkey "^[[1;5C" emacs-forward-word
bindkey "^[[1;2C" emacs-forward-word


# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh


export PATH=/home/tychob/.devtools/flutter/bin:$PATH
export CHROME_EXECUTABLE='/var/lib/flatpak/exports/bin/com.google.Chrome'
```

</br>

[Top](#zsh)
