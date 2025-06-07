{
  imports = [
    ./kitty
    ./dunst
    ./hypr
    ./kmonad
    ./fuzzel
    # ./ranger # also seems like a pain in the ass to config?
    # ./neovim # It's a HUGE HUGE HUGE pain in the ass to use lazyvim with nix, because the design philosophies completely clash. As such, just copy neovim configs straight into ~/.config manually.
  ];
}
