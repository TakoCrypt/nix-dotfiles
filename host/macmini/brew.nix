{ ... }:

{
  environment.systemPath = [ "/opt/homebrew/bin" ];
  homebrew.enable = true;

  homebrew.casks = [
    "rectangle"
    "obsidian"
    "kitty"
    "zed"
    "1password"
    "raycast"
  ];
}
