{
  imports = [
    ./kitty
    ./dunst
    ./hypr
    ./kmonad
    ./fuzzel
    # ./neovim # It's a HUGE HUGE HUGE pain in the ass to use lazyvim with nix, because the design philosophies completely clash. As such, just copy neovim configs straight into ~/.config manually.
  ];
}
