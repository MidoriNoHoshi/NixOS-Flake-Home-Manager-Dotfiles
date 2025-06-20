# Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader = {
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot";
    };
    grub = {
      enable = true;
      efiSupport = true;
      device = "nodev";
    };
    timeout = 10;
  };

  # boot.loader.systemd-boot.enable = true;
  # boot.loader.efi.canTouchEfiVariables = true;

  # boot.loader.grub.theme = pkgs.runCommand "GrubPixelCatTheme" {
  #   src = ./GrubPixelCatTheme;
  # } ''
  #   mkdir -p $out
  #   cp -r $src/* $out
  # '';
    
  boot.loader.grub.theme = pkgs.stdenv.mkDerivation {
    pname = "grubTheme";
    version = "1.0";
    src = pkgs.fetchFromGitHub {
      owner = "MidoriNoHoshi";
      repo = "GrubPixelCatTheme";
      rev = "main"; # "25e53ef7f881306bf8a342d909257c1bb4662640"; # Just easier to use main?
      hash = "sha256-EN2e+zdCtpPLZ40SXNQefB3LrbvW9gOWBkhHShlhcs0=";
    };
    installPhase = ''
    mkdir -p $out
    cp -r $src/* $out
    '';
    # installPhase = "cp -r customize/nixos $out";
  };


  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Oslo";

  # Select internationalisation properties.
  i18n = {
    defaultLocale = "en_GB.UTF-8";
    inputMethod = {
      type = "fcitx5";
      enable = true;
      fcitx5 = {
        addons = with pkgs; [
          fcitx5-gtk
          fcitx5-mozc
          # fcitx5-rose-pine
        ];
        waylandFrontend = true;
      };
    };
  };

  services = {
    kmonad = {
      enable = true;
      keyboards = {
        myKMonadOutput = {
          # device = "/dev/input/by-id/usb-Logitech_USB_Receiver-event-kbd";
          device = "/dev/input/event0";
          config = builtins.readFile ./default.kbd;
        };
      };
    };
    udisks2 = {
      enable = true;
    };
    xserver = {
      enable = true; # Enable the X11 windowing system.
      xkb = {
        layout = "us, jp, no, gb";
      };
    };
  };


  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = false;
  services.xserver.desktopManager.gnome.enable = false; # false for disabling the entire gnome desktop environment
  services.displayManager.ly.enable = true;

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    # jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    # media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users = {
    mutableUsers = true;
    defaultUserShell = pkgs.zsh;
    users.nemi = {
      isNormalUser = true;
      description = "Dhruva Kurk Tatsuyama Mathisen";
      extraGroups = [ "networkmanager" "wheel" ];
    };
  };
  security.sudo.wheelNeedsPassword = false;

  nixpkgs.config.allowUnfree = true; # Allows unfree packages

  nix = {
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
    package = pkgs.nixVersions.stable;
    settings.experimental-features = [ "nix-command" "flakes" ];
  };

  system.autoUpgrade = {
    enable = true;
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
   vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
   wget
   neovim
   git
   ly # Super lightweight display manager
   home-manager
   hyprland
   hyprpaper
   nemo-with-extensions # Cinnamon default file manager
   # nemo-fileroller # Archive manager for nemo file manager
   gvfs # GNOME Virtual File System. Cinnamon and Nautilus needs. For Nautilus, use gnome.gvfs.
   zsh
   oh-my-zsh

   bibata-cursors
   tokyonight-gtk-theme

   # fcitx5
   # fcitx5-mozc
   # fcitx5-configtool
   # fcitx5-gtk
  ];
  fonts = {
    # enable = true;
    enableDefaultPackages = true;
    packages = with pkgs; [
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif

      nerd-fonts._0xproto
      nerd-fonts.hack
      nerd-fonts._3270
      nerd-fonts.mononoki
      nerd-fonts.jetbrains-mono
      nerd-fonts.fira-code
      nerd-fonts.fira-mono
      nerd-fonts.departure-mono
      nerd-fonts.proggy-clean-tt
    ];
    fontconfig = {
      enable = true;
    };
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };
  programs = {
    zsh.enable = true;
    hyprland = {
      enable = true;
      xwayland.enable = true;
    };
    steam = {
      enable = true;
      remotePlay.openFirewall = true; # Open ports in firewall for Steam Remote Play.
      dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server.
      localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers.
    };
  };

  # virtualisation.waydroid.enable = true; # Need for waydroid to work.

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?
}
