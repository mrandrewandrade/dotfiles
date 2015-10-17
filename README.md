# Dotfiles

This project is my gnarly system manager and dotfile auto-configuration tool since
[dotfiles are meant to be forked!](http://zachholman.com/2010/08/dotfiles-are-meant-to-be-forked/)

[Dotfiles](https://dotfiles.github.io/) are funky hidden configuration files which
people use to customize their nerdery (and greatly enhance productivity): change how their prompt looks,
set up their $PATH, completely change everything about Vim,  adjust settings their settings
and do about a billion and a half other things. They're tons of fun, and I use them to get things
done [at the speed of thought](http://mrandrewandrade.com/speed-of-thought/).

This repo contains the files to get you started!   

**Note**: This setup was orignally taken from [here](github.com/michaeljsmalley/dotfiles)
and built on Linux Mint based on my own preferences.  The system should work for most
*nix-based (Unix-like) systems (such at Mac and Ubuntu).  If you are
using Mac, I highly suggest upgrading your terminal and using [iTerm2](https://www.iterm2.com/).    

To get started you either follow the command line installation instructions below
(by opening terminal and typing the commands) or you can
[download the files](https://github.com/mrandrewandrade/dotfiles/zipball/master)
and unzip them in your home directory so that the path is `~/dotfiles/`.

You can then run makesymlinks.sh (by running `sudo bash makesymlinks.sh`) to install
everything.  Note, if you read the script, it creates
[symlinks](https://en.wikipedia.org/wiki/Symbolic_link) from your home directory
to the files which are located in `~/dotfiles/`.  The setup script is smart enough to
back up your existing dotfiles into a `~/dotfiles_old/` directory if you already have
any dotfiles of the same name as the dotfile symlinks being created in your home directory.     

I also prefer `zsh` as my shell of choice.  As such, the setup script will also
clone the `oh-my-zsh` repository from my GitHub. It then checks to see if `zsh`
is installed.  If `zsh` is installed, and it is not already configured as the
default shell, the setup script will execute a `chsh -s $(which zsh)`.  This
changes the default shell to zsh, and takes effect as soon as a new zsh is
spawned or on next login.

So, to recap, the install script will:

1. Back up any existing dotfiles in your home directory to `~/dotfiles_old/`
2. Create symlinks to the dotfiles in `~/dotfiles/` in your home directory
3. Clone the `oh-my-zsh` repository from my GitHub (for use with `zsh`)
4. Check to see if `zsh` is installed, if it isn't, try to install it.
5. If zsh is installed, run a `chsh -s` to set it as the default shell.

You can then configure any of your dotfiles by editing the files in 
`~/dotfiles`.

## Installation


``` bash
cd ~/
# Note: if you fork the repo, change mrandrewandrade
# to your github username
git clone https://github.com/mrandrewandrade/dotfiles.git ~/dotfiles
cd ~/dotfiles
./makesymlinks.sh
```

Current todo list:
- Add install tmux + other of my favourite tools to [makesymlinks.sh](makesymlinks.sh)
