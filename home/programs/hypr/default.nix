{ config, lib, pkgs, ... }:

{
  imports = [ 
    ./hyprland-environment.nix
  ];

  home.packages = with pkgs; [ 
    # waybar
    # swww
    brightnessctl
    hyprpaper
  ];
  
  #test later systemd.user.targets.hyprland-session.Unit.Wants = [ "xdg-desktop-autostart.target" ]; For things like waybar to start properly on login, should uncomment this line.
  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = true;
    settings = {
      # "$terminal" = "cool-retro-term"; # How to get it to run cool retro term first?
      "$terminal" = "kitty";
      "$fileManager" = "nemo";
      "$browser" = "firefox";
      "$menu" = "fuzzel";
      "$mainMod" = "SUPER";

      exec-once = [
      # "cool-retro-term" # Maybe, just maybe not needed?
      # "anki" # Just gets instantly closed anyway
      "hyprpaper"
      "fcitx5-remote -r"
      "fcitx5 -d --replace"
      # "hyprctl setcursor Bibata-Modern-Classic 24"
      "dunst"
      "~/Dotfiles/Scripts/batteryWarn.sh"
      ];
      env = [
      "XCURSOR_THEME, Bibata-Modern-Classic"
      "HYPRCURSOR_THEME, Bibata-Modern-Classic"
      "XCURSOR_SIZE,24"
      "HYPRCURSOR_SIZE,24"
      "GTK_IM_MODULE,fcitx5"
      "QT_IM_MODULE,fcitx5"
      "XMODIFIERS,@im=fcitx5"
      ];
      general = {
        gaps_in = 4;
        gaps_out = 8;
        resize_on_border = false;
        allow_tearing = false;
        layout = "dwindle";
        border_size = 1;
        sensitivity = 1.0;
      };
      decoration = {
          rounding = 8;
          active_opacity = 1.0;
          inactive_opacity = 1.0;
          shadow = {
            enabled = true;
            range = 4;
            render_power = 3;
            color = "rgba(1a1a1aee)";
            };
          blur = {
            enabled = true;
            size = 3;
            passes = 1;
            vibrancy = 0.1696;
          };
        };
      animations = {
        enabled = "yes, please :)";
        bezier = [
          "easeOutQuint,0.23,1,0.32,1"
          "easeInOutCubic,0.65,0.05,0.36,1"
          "linear,0,0,1,1"
          "almostLinear,0.5,0.5,0.75,1.0"
          "quick,0.15,0,0.1,1"
          ];

        animation = [
          "global,1,10,default"
          "border,1,5.39,easeOutQuint"
          "windows,1,4.79,easeOutQuint"
          "windowsIn,1,4.1,easeOutQuint,popin 87%"
          "windowsOut,1,1.49,linear,popin 87%"
          "fadeIn,1,1.73,almostLinear"
          "fadeOut,1,1.46,almostLinear"
          "fade,1,3.03,quick"
          "layers,1,3.81,easeOutQuint"
          "layersIn,1,4,easeOutQuint,fade"
          "layersOut,1,1.5,linear,fade"
          "fadeLayersIn,1,1.79,almostLinear"
          "fadeLayersOut,1,1.39,almostLinear"
          "workspaces,1,1.94,almostLinear,fade"
          "workspacesIn,1,1.21,almostLinear,fade"
          "workspacesOut,1,1.94,almostLinear,fade"
        ];
      };
      workspace = [
        "w[tv1],gapsout:0,gapsin:0"
        "f[1],gapsout:0,gapsin:0"
      ];

      windowrulev2 = [
        "pseudo, fcitx"
        "bordersize 0,floating:0,onworkspace:w[tv1]"
        "rounding 0,floating:0,onworkspace:w[tv1]"
        "bordersize 0,floating:0,onworkspace:f[1]"
        "rounding 0,floating:0,onworkspace:f[1]"
        "suppressevent maximize,class:.*"
        "nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0"
      ];

      dwindle = {
        pseudotile = true;
        preserve_split = true;
      };

      master = {
        new_status = "master";
      };
      input = {
        kb_layout = "us,jp,no,gb";
        kb_options = "grp:super_space_toggle";
        follow_mouse = true;
        sensitivity = 0;
        touchpad.natural_scroll = false;
        touchpad.disable_while_typing = true;
      };

      gestures.workspace_swipe = false;

      device."epic-mouse-v1".sensitivity = -0.5;

      bind = [
        "$mainMod, Q, exec, $terminal"
        "$mainMod, C, killactive,"
        "$mainMod, I, exec, $browser"
        "$mainMod, E, exec, $fileManager"
        "$mainMod, V, togglefloating, "
        "$mainMod, R, exec, $menu"
        # "$mainMod, J, togglesplit, " # dwindle
        ",Print, exec, grim -g \"$(slurp)\" - | wl-copy"
        "CONTROL, Print, exec, grim -g \"$(slurp)\" ~/Pictures/Screenshots/screenshot_$(date +%Y-%m-%d_%H_%S).png"
        ", F9, exec, ~/Dotfiles/Scripts/battery.sh"
        "$mainMod, h, movefocus, l"
        "$mainMod, l, movefocus, r"
        "$mainMod, k, movefocus, u"
        "$mainMod, j, movefocus, d"
        "$mainMod,1,workspace,1"
        "$mainMod,2,workspace,2"
        "$mainMod,3,workspace,3"
        "$mainMod,4,workspace,4"
        "$mainMod,5,workspace,5"
        "$mainMod,6,workspace,6"
        "$mainMod,7,workspace,7"
        "$mainMod,8,workspace,8"
        "$mainMod,9,workspace,9"
        "$mainMod,0,workspace,10"
        "$mainMod SHIFT,1,movetoworkspace,1"
        "$mainMod SHIFT,2,movetoworkspace,2"
        "$mainMod SHIFT,3,movetoworkspace,3"
        "$mainMod SHIFT,4,movetoworkspace,4"
        "$mainMod SHIFT,5,movetoworkspace,5"
        "$mainMod SHIFT,6,movetoworkspace,6"
        "$mainMod SHIFT,7,movetoworkspace,7"
        "$mainMod SHIFT,8,movetoworkspace,8"
        "$mainMod SHIFT,9,movetoworkspace,9"
        "$mainMod SHIFT,0,movetoworkspace,10"
        "$mainMod, S, togglespecialworkspace, magic"
        "$mainMod, SHIFT, S, movetoworkspace, special:magic"
        "$mainMod, mouse_down, workspace, e+1"
        "$mainMod, mouse_up, workspace, e-1"
      ];
      # ++ (
      #   # workspaces
      #   # binds $mod + [shift +] {1..9} to [move to] workspace {1..9}
      #   builtins.concatLists (builtins.genList (i:
      #       let ws = i + 1;
      #       in [
      #         "$mainMod, code:1${toString i}, workspace, ${toString ws}"
      #         "$mainMod SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}"
      #       ]
      #     )
      #     9)
      # );

      bindm = [
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];

      bindel = [
        ",XF86AudioRaiseVolume,exec,wpctl set-volume @DEFAULT_AUDIO_SINK@ 1%+ --limit 1.2 && ~/Dotfiles/Scripts/volume.sh" # More granualar control over volume.
        ",XF86AudioLowerVolume,exec,wpctl set-volume @DEFAULT_AUDIO_SINK@ 1%- && ~/Dotfiles/Scripts/volume.sh"
        ",XF86AudioMute,exec,wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle && ~/Dotfiles/Scripts/volume.sh"
        ",XF86AudioMicMute,exec,wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
        ",XF86MonBrightnessUp,exec,brightnessctl s 5%+ && ~/Dotfiles/Scripts/brightness.sh"
        ",XF86MonBrightnessDown,exec,brightnessctl s 5%- && ~/Dotfiles/Scripts/brightness.sh"
        ",XF86AudioNext,exec,playerctl next"
        ",XF86AudioPause,exec,playerctl play-pause"
        ",XF86AudioPlay,exec,playerctl play-pause"
        ",XF86AudioPrev,exec,playerctl previous"
      ];

      monitor = [
        "eDP-1,1920x1200@60hz, auto, 1"
        "HDMI-A-1, preferred, auto, auto"
      ];
    };
  };
  home.file.".config/hypr/hyprpaper.conf".text = ''
preload = ~/Desktop/Wallpapers/chill-chill-joirnal/Less_talk..._more_action.webp
wallpaper = eDP-1, ~/Desktop/Wallpapers/chill-chill-joirnal/Less_talk..._more_action.webp
ipc = off
    '';
}
