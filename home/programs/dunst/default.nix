{ config, lib, pkgs, ... }:

{
services.dunst = {
    enable = true;
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
    settings = {
      global = {
        monitor = "0"; # Which monitor the notifications are displayed on.
        font = "Mononoki Nerd Font 12"; # I kinda want to use Discord Goto font instead.
        line_height = "0";
        follow = "mouse"; # Display notification on focused monitor. Possible modes are:
# mouse: follow mouse cursor,
        # keyboard: follow window with keyboard focus,
        # none: doesn't follow anything.
        width = "(0, 200)";
        height = "(0, 200)";
        origin = "top-left"; # top-center? # Hyprland, gaps out is set to 8 rn
        corner_radius = "8";
        corners = "bottom, top-right";
        offset = "(18, 18)";
        scale = "2"; # NO fucking idea what 'scale' does.
        notification_limit = "12"; # 0 for no limit
        progress_bar = "true"; # to use, for example: $ dunstify -h int:value:12
        progress_bar_height = "14"; # Progress bar height includes the frame. So make sure that it's at least twice as big as the frame width.
        progress_bar_frame_width = "0";
        progress_bar_min_width = "120";
        progress_bar_max_width = "300";
        progress_bar_corner_radius = "48";
        progress_bar_corners = "bottom-left, top-right"; # Defines which corners to round when drawing the progress bar. If progress_bar_corner_radius is set to 0, this option is ignored.
        icon_corner_radius = "0";
        icon_corner = "all";
        indicate_hidden = "yes"; # Only matters if there's a notification_limit.
        transparency = "0"; # X11 display server protocol only.
        gap_size = "6";
        separator_height = "6"; # Related to the gap between notifications. . . Idk how. Set to 0 to disable. If gap_size is greater than 0, this setting is also ignored.
        separator_color = "frame"; # Possible values are:
# auto: dunst tries to find a colour that complements the background,
        # foreground: use the same colour as the foreground,
        # frame: use the same colour as the frame,
        # anything else will be interpreted as a "X" colour.
        padding = "12"; # Padding between text and separator.
        horizontal_padding = "12";
        text_icon_padding = "12";
        frame_width = "1";
        frame_color = "#a0a0a0"; # Colour of the frame around the notification window.
        sort = "urgency_descending"; # Sort type. Possible values are: 
# yes: idk, but most people seem to just use "yes".
# id: sort by id,
        # urgency_ascending: sort by urgency (low, normal, critical),
        # urgency_descending: sort by urgency (critical, normal, low),
        # update: sort by update (most recent always at top)
        markup = "full";
        format = "<b>%s</b>\\n%b"; # The format of the message, Possible variables are:
# %a appname
        # %s summary
        # %b body
        # %i iconname (including path)
        # %I iconname (without path)
        # %p progress value if set ([ 0%] to [100%]) or nothing
        # %n progress value if set without any extra characters
        # %% Literal %
        # Markup is allowed
        alignment = "left"; # Alignment of message text
        vertical_alignment = "center"; # Vertical alignment
        show_age_threshold = "-1"; # Show age of message if message is older than show_age_threshold seconds.
        ellipsize = "end"; # If a long message doesn't fit the notification window, ellipsize sets where to cut off the text.
# Options are:
        # start: cuts of beginning of text (... text)
        # middle: cuts out middle of text (te ... xt)
        # end: cuts off the end (text ...)
        # none: doesn't cut off anything. But may cause layout issues.
        ignore_newline = "no"; # Ignores '\n' in notifications
        stack_duplicates = "true"; # Stack together notifications with the same content
        hide_duplicate_count = "false"; # Hide the count of stacked notifications with the same content
        show_indicators = "yes"; # Display indicators for URLs (U) and actions (A)

        enable_recursive_icon_lookup = "true";
        icon_theme = "Adwaita, Papirus-Dark"; # Set icon theme (only uesd for recursive icon lookup)
        icon_position = "right";
        min_icon_size = "32"; # Scales small icons up to this size. Set to 0 to disable.
        max_icon_size = "64";

        sticky_history = "yes";
        history_length = "32";

        ignore_dbusclose = "false"; # Enforce timeout set by dunst configuration. Without this parameter, applications may close the notification sent before the user defined timeout.

        mouse_left_click = "close_current";
        mouse_middle_click = "do_action, close_current";
        mouse_right_click = "close_all";

        shrink = "no";
        word_wrap = "yes";
      };

      fullscreen_delay_everything = {fullscreen = "delay";};

      urgency_low = {
        background = "#222222";
        foreground = "#ffffff";
        highlight = "#722ae6, #e4b5cb";
        timeout = "8";
      };
     urgency_normal = {
        background = "#222222";
        foreground = "#ffffff";
        highlight = "#722ae6, #e4b5cb";
        timeout = "8";
        override_pause_level = "32";
      };
     urgency_critical = {
        background = "#222222";
        foreground = "#ffffff";
        highlight = "#722ae6, #e4b5cb";
        timeout = "-1";
        override_pause_level = "64";
      };
      discord = {
        appname = "Discord";
        background = "#000000";
        foreground = "#E0E3FF"; # Official Discord "Light Blurple"
        frame_color = "#99AAB5";
        timeout = "8";
        icon = "~/Pictures/Logos + svg/Discord/Discord_Symbol_Color/Discord-Symbol-Blurple.png";

      };
    };
  };
}

