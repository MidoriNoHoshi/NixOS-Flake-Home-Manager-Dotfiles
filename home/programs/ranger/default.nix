{ config, lib, pkgs, ... }:
  {
    programs.ranger = {
      enable = true;
      settings = {
          preview_images = true;
          draw_borders = true;
        };
    };
    home.file.".config/ranger/rifle.conf".text = ''
#-------------------------------------------
# Websites
#-------------------------------------------
ext x?html?, has brave,          X, flag f = brave -- "$@"
ext x?html?, has firefox,          X, flag f = firefox -- "$@"

#-------------------------------------------
# Misc
#-------------------------------------------
# Define the "editor" for text files as first action
mime ^text,  label editor = ${VISUAL:-$EDITOR} -- "$@"
mime ^text,  label pager  = "$PAGER" -- "$@"
!mime ^text, label editor, ext xml|json|csv|tex|py|pl|rb|js|sh|php = ${VISUAL:-$EDITOR} -- "$@"
!mime ^text, label pager,  ext xml|json|csv|tex|py|pl|rb|js|sh|php = "$PAGER" -- "$@"

ext 1                         = man "$1"
ext s[wmf]c, has zsnes, X     = zsnes "$1"
ext s[wmf]c, has snes9x-gtk,X = snes9x-gtk "$1"
ext nes, has fceux, X         = fceux "$1"
ext exe                       = wine "$1"
name ^[mM]akefile$            = make

#--------------------------------------------
# Scripts
#-------------------------------------------
ext py  = python -- "$1"
ext pl  = perl -- "$1"
ext rb  = ruby -- "$1"
ext js  = node -- "$1"
ext sh  = sh -- "$1"
ext php = php -- "$1"

#--------------------------------------------
# Audio without X
#-------------------------------------------
mime ^audio|ogg$, terminal, has mpv      = mpv -- "$@"

#--------------------------------------------
# Video/Audio with a GUI
#-------------------------------------------
mime ^video,       has mpv,      X, flag f = mpv -- "$@"
mime ^video,       has mpv,      X, flag f = mpv --fs -- "$@"
#--------------------------------------------
# Video without X
#-------------------------------------------
mime ^video, terminal, !X, has mpv       = mpv -- "$@"
#-------------------------------------------
# Documents
#-------------------------------------------
ext pdf, has mupdf,    X, flag f = mupdf "$@"
ext pdf, has zathura,  X, flag f = zathura -- "$@"
ext pdf, has mupdf-x11,X, flag f = mupdf-x11 "$@"
ext pdf, has okular,   X, flag f = okular -- "$@"

ext docx?, has catdoc,       terminal = catdoc -- "$@" | "$PAGER"

ext                        sxc|xlsx?|xlt|xlw|gnm|gnumeric, has gnumeric,    X, flag f = gnumeric -- "$@"
ext                        sxc|xlsx?|xlt|xlw|gnm|gnumeric, has kspread,     X, flag f = kspread -- "$@"
ext pptx?|od[dfgpst]|docx?|sxc|xlsx?|xlt|xlw|gnm|gnumeric, has libreoffice, X, flag f = libreoffice "$@"
ext pptx?|od[dfgpst]|docx?|sxc|xlsx?|xlt|xlw|gnm|gnumeric, has soffice,     X, flag f = soffice "$@"
ext pptx?|od[dfgpst]|docx?|sxc|xlsx?|xlt|xlw|gnm|gnumeric, has ooffice,     X, flag f = ooffice "$@"

ext epub, has mupdf,        X, flag f = mupdf -- "$@"
ext djvu, has zathura,X, flag f = zathura -- "$@"
ext epub, has ebook-viewer, X, flag f = ebook-viewer -- "$@"
ext epub, has zathura,      X, flag f = zathura -- "$@"
ext mobi, has ebook-viewer, X, flag f = ebook-viewer -- "$@"

ext cbr,  has zathura,      X, flag f = zathura -- "$@"
ext cbz,  has zathura,      X, flag f = zathura -- "$@"

#-------------------------------------------
# Images
#-------------------------------------------
mime ^image, has qimgv,       X, flag f = qimgv -- "$@"
mime ^image, has gimp,      X, flag f = gimp -- "$@"
ext xcf,                    X, flag f = gimp -- "$@"

#-------------------------------------------
# Fonts
#-------------------------------------------
mime ^font, has fontforge, X, flag f = fontforge "$@"

#-------------------------------------------
# Flag t fallback terminals
#-------------------------------------------
# mime ^ranger/x-terminal-emulator, has alacritty = alacritty -e "$@"
mime ^ranger/x-terminal-emulator, has cool-retro-term = cool-retro-term -e "$@"
mime ^ranger/x-terminal-emulator, has kitty = kitty -- "$@"


#-------------------------------------------
# Misc
#-------------------------------------------
label wallpaper, number 11, mime ^image, has feh, X = feh --bg-scale "$1"
label wallpaper, number 12, mime ^image, has feh, X = feh --bg-tile "$1"
label wallpaper, number 13, mime ^image, has feh, X = feh --bg-center "$1"
label wallpaper, number 14, mime ^image, has feh, X = feh --bg-fill "$1"

#-------------------------------------------
# Generic file openers
#-------------------------------------------
label open, has xdg-open = xdg-open -- "$@"
label open, has open     = open -- "$@"

# Define the editor for non-text files + pager as last action
              !mime ^text, !ext xml|json|csv|tex|py|pl|rb|js|sh|php  = ask
label editor, !mime ^text, !ext xml|json|csv|tex|py|pl|rb|js|sh|php  = ${VISUAL:-$EDITOR} -- "$@"
label pager,  !mime ^text, !ext xml|json|csv|tex|py|pl|rb|js|sh|php  = "$PAGER" -- "$@"


######################################################################
# The actions below are left so low down in this file on purpose, so #
# they are never triggered accidentally.                             #
######################################################################

# Execute a file as program/script.
mime application/x-executable = "$1"

# Move the file to trash using trash-cli.
label trash, has trash-put = trash-put -- "$@"
label trash = mkdir -p -- "${XDG_DATA_DIR:-$HOME/.ranger}/ranger-trash";
'';
}
