{ config, pkgs, ... }:
  {
    home.file.".config/kitty/kitty.conf".text = ''    
      font_family 0xProtoNerdFontMono-Regular

      padding_left 4

      cursor #c7c7c7
      cursor_text_color #feffff
      selection_foreground #3e3e3e
      selection_background #c1ddff
      foreground #c8c8c8
      background #323232
      color0     #252525
      color8     #555555
      color1     #be7472
      color9     #ff9900
      color2     #709772
      color10    #97bb98
      color3     #989772
      color11    #fefdbc
      color4     #7199bc
      color12    #9fbdde
      color5     #727399
      color13    #989abc
      color6     #719899
      color14    #6fbbbc
      color7     #7f7f7f
      color15    #feffff

      # foreground #dddddd
      # background #000000
      background_opacity 0.75
      background_blur -1
      # background_image none
      # Path to a background image. Must be in PNG/JPEG/WEBP/TIFF/GIF/BMP format.
      # background_image_layout tiled
      # background_image_linear no

      shell zsh
      editor nvim

      kitty_mod ctrl+shift
      map kitty_mod+c copy_to_clipboard
      map kitty_mod+v paste_from_clipboard
      map kitty_mod+t new_window
      map kitty_mod+x close_window
    '';
  }
