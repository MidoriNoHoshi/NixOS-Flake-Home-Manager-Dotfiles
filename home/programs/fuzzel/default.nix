{ config, lib, pkgs, ... }:

{
  programs.fuzzel = {
    enable = true;
    settings = {
      main = {
        "dpi-aware" = "no";
        "icon-theme" = "Papirus-Dark";
        "width" = "25";
        "font" = "Hack:weight=bold:size=36";
        "line-height" = "50";
        "fields" = "name,generic,comment,categories,filename,keywords";
        "terminal" = "kitty";
        "show-actions" = "yes";
      };
      colors = {
        background = "282a36fa";
        selection = "3d4474fa";
        border = "fffffffa";
      };
      border = {
        radius = "20";
      };
    };
  };
}
