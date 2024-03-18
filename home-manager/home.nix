# Default home-manager configuration
{ config
, lib
, pkgs
, flake-settings
, ...
}:

{
  shells.fish.enable = true;

  home = {
    # Needed for standalone home-manager
    homeDirectory = lib.mkDefault flake-settings.userHome;
    packages = [ pkgs.tealdeer ];
    stateVersion = lib.mkDefault flake-settings.stableVersion;
    username = lib.mkDefault flake-settings.user;
  };

  programs = {
    home-manager.enable = true;
    nix-index.enable = true;

    git = {
      enable = true;
      extraConfig.init.defaultBranch = "main";
      userEmail = "git@heyimnova.dev";
      userName = "heyimnova";

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
  };

  services.gpg-agent = {
    enable = true;
    enableFishIntegration = true;
  };
}
