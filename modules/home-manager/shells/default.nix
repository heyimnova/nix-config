# Import all home-manager shell configurations
{ lib, config, ... }:

{
  imports = [
    ./fish.nix
    ./nushell.nix
  ];

  # Enable atuin
  programs.atuin = {
    enable = true;
    enableFishIntegration = config.shells.fish.enable;
    enableNushellIntegration = config.shells.nushell.enable;

    settings = {
      # Show dates correctly
      dialect = "uk";
      # Run command on enter instead of pressing enter twice
      enter_accept = true;
      # Use vim keys by default
      keymap_mode = "vim-insert";
    };
  };
}

