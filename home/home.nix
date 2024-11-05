# Default home-manager configuration
{ config
, lib
, pkgs
, variables
, ...
}:

{
  shells.fish.enable = true;

  home = {
    # Needed for standalone home-manager
    username = lib.mkDefault variables.user;
    homeDirectory = lib.mkDefault variables.userHome;
    stateVersion = lib.mkDefault "24.11";

    packages = with pkgs; [
      tealdeer
      topgrade
    ];
  };

  programs = {
    home-manager.enable = true;
    nix-index.enable = true;

    git = {
      enable = true;
      userName = "heyimnova";
      userEmail = "git@heyimnova.dev";
      extraConfig.init.defaultBranch = "main";

      signing = {
        key = "DEB0E15C6D2A5A7C";
        signByDefault = true;
      };
    };

    gpg = {
      enable = true;
      # Recommendation from xdg-ninja
      homedir = "${config.xdg.dataHome}/gnupg";
    };

    zoxide = {
      enable = true;
      enableFishIntegration = config.shells.fish.enable;
      enableNushellIntegration = config.shells.nushell.enable;
    };
  };

  services.gpg-agent = {
    enable = true;
    enableFishIntegration = config.shells.fish.enable;
    enableNushellIntegration = config.shells.nushell.enable;
  };
}
