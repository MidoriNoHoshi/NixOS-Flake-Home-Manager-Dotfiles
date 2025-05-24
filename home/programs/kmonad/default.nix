{ config, lib, pkgs, ... }:

let
  kmonadConfig = ''
    (defcfg
      input (device-file "/dev/input/event0")
      output (uinput-sink "Kmonad output")
      fallthrough true
      allow-cmd false
    )

    (defsrc
      esc
      grv
      tab
      caps
      lsft
      wkup lctl lmet lalt
    )

    (deflayer main
      _
      _
      lctrl
      lmet
      _
      _    tab    esc    _
    )
  '';
in {
  home.packages = [ pkgs.kmonad ];

  home.file.".config/kmonad/default.kbd".text = kmonadConfig;

  systemd.user.services.kmonad = {
    # enable = true;
    Unit = {
      Description = "KMonad keyboard remapping";
      After = [ "graphical-session.target" ];
    };

    Service = {
      ExecStart = "${pkgs.kmonad}/bin/kmonad ${config.home.homeDirectory}/.config/kmonad/default.kbd";
      Restart = "on-failure";
    };

    Install = {
      WantedBy = [ "default.target" ];
    };
  };
}
