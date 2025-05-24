{config, lib, pkgs, ... }:
let
  nvimConfig = ./nvim;
in {
  home.packages = [ pkgs.neovim ];
  home.file.".config/nvim".source = nvimConfig;
}
