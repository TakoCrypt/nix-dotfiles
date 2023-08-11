{
  pkgs,
  inputs,
  ...
}: {
  time.timeZone = "Australia/Sydney";

  system.configurationRevision = inputs.self.rev or inputs.self.dirtyRev or null;

  # Enables flakes and the nix command
  # nix.package = pkgs.nixFlakes;
  nix.settings.experimental-features = ["nix-command" "flakes"];

  # Disabling automatic GC will increase cache hits at the cost of disk storage, but
  # I've got enough storage that it's a worthwhile tradeoff for me.
  nix.gc.automatic = false;

  nix.nixPath = [
    "nixpkgs=${inputs.nixpkgs.outPath}"
    "nixos-config=${../.}"
  ];

  nix.registry.nixpkgs.flake = inputs.nixpkgs;

  # I always want the latest version of Helix. They do their best to
  # keep it building, and I've only ever had trouble with it twice.
  # Even then, that's exactly the problem that Nix solves, so I'm not
  # concerned at all about stability.
  nixpkgs.overlays = [
    inputs.helix.overlays.default
    inputs.nixd.overlays.default
  ];

  nixpkgs.config = {
    allowUnfree = true;
  };

  # Most user config has to be for each system specifically, check in the subdirectories
  users.users.robert = {
    shell = pkgs.fish;
  };
  # This needs to be set to get the default system-level fish configuration, such
  # as completions for Nix and related tools. This is also required because on macOS
  # the $PATH doesn't include all the entries it should by default.
  programs.fish.enable = true;

  services.tailscale.enable = true;
}
