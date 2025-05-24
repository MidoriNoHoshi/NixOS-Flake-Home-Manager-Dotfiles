{ hyprland, pkgs, lib, ...}: {

  imports = [
    hyprland.homeManagerModules.default
    ./programs
    # ./scripts
    # ./themes
  ];

  home = {
    username = "nemi";
    homeDirectory = lib.mkForce "/home/nemi/";
    stateVersion = "24.11";
    sessionVariables = {
      INPUT_METHOD = "fcitx5";
      GTK_IM_MODULE = "fcitx5";
      QT_IM_MODULE = "fcitx5";
      XMODIFIERS = "@im=fcitx5";
    };
  };

  nixpkgs.config.allowUnfree = true;

  home.packages = (with pkgs; [
    
    #User Apps
    celluloid # Basically just Mpv
    mpv
    brave # Don't really like brave tbh
    ladybird # trying out ladybird browser
    firefox
    discord
    kitty
    cool-retro-term #Literally what it says. Holy shit, I kinda really like this.
    bibata-cursors
    yt-dlp
    ffmpeg
    lollypop # GNOME music player
    vlc

    #Utilities
    oh-my-zsh # Fucking love oh-my-zsh. How to get it to fucking work?
    git
    gcc # GNU Compiler Collection. Need for a C compiler
    nautilus
    fzf # Fuzzy finder
    ripgrep
    fd # find command
    brightnessctl # Brightness controls
    lua # Lua
    luarocks
    dunst
    rofi
    fuzzel # wofi / rofi alternative for wayland. Seems much nicer
    curl
    slurp
    grim
    wl-clipboard
    spotify
    steam
    obsidian
    qimgv

    #---
    # All of this I put into configuration.nix instead.
    # Japanese writing support
    # fcitx5
    # fcitx5-mozc # Japanese writing support
    # fcitx5-configtool
    # fcitx5-gtk
    # # ibus-engines.mozc # Google? Japanese writing engine
    # # ibus
    # noto-fonts
    # noto-fonts-cjk-sans
    # noto-fonts-cjk-serif
    #
    # nerd-fonts._0xproto
    # nerd-fonts.hack
    # nerd-fonts._3270
    # nerd-fonts.mononoki
    # nerd-fonts.jetbrains-mono
    # nerd-fonts.fira-code
    # nerd-fonts.fira-mono
    

    #Miscellaneous
    kmonad
    notepadqq
    gnumake # For the 'make' command. Useful for those makeFile files.
    wireshark
    tokyo-night-gtk
    neofetch
    qbittorrent
    ags
    lazygit
    krita
    gimp
    godot3
    love
    clamav
    clamtk
    wireguard-tools
    wireguard-ui
    evtest
    retroarch
    neofetch
    bc # Basic calculator
    tree #Command for quickly displaying contents of directory, including sub directories.
    # manix # Fast CLI documentation searcher for nix.
  ]);

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };

    "org/gnome/shell/extensions/user-theme" = {
      name = "Tokyonight-Dark-B-LB";
    };
  };

  programs = {
    home-manager = {
      enable = true;
    };
    zsh = {
      enable = true;
      oh-my-zsh = {
        enable = true;
        theme = "wedisagree";
        plugins = [ "git" "sudo" ];
      };
      shellAliases = {
        ll = "ls -lah";
        gs = "git status";
        battery = "cat /sys/class/power_supply/BAT0/capacity"; # Checking battery
      };
    };
  };
}
