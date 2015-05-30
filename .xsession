# .xsession sets the commands and window manager run when you log in.
# make changes as you see fit

setxkbmap -option "ctrl:nocaps"

# Window Managers
# uncomment the ONE that you'd like to use by default
#exec gnome-session --session=gnome-classic     # classic gnome
#exec gnome-session --session=ubuntu            # ubuntu
#exec gnome-session --session=ubuntu-2d         # ubuntu-2d
#exec gnome-session --session=gnome-fallback    # no effects
#exec gnome-session --session=gnome             # default gnome
#exec gnome-session-xmonad                      # gnome-xmonad
#exec /usr/bin/startkde                         # kde (recommended against)
#exec wmii                                      # wmii (highly recommended)
exec startxfce4                                # xfce
#exec xmonad                                    # xmonad

# Add other programs to run here
# exec urxvt
