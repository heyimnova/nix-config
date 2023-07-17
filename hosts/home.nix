# User level config for all systems
{ config, pkgs, ... }:

{
  # Import secret git and fish configurations
  imports = [
    ../secrets/programs/git/home.nix
    ../secrets/programs/fish/home.nix
  ];

  home.packages = with pkgs; [
    efibootmgr
    git-crypt
    shell-genie
    tealdeer
    xdg-ninja
  ];

  programs = {
    home-manager.enable = true;

    fish = {
      enable = true;

      # Enable starship prompt
      interactiveShellInit = ''
        ${pkgs.starship}/bin/starship init fish | source
      '';

      shellAliases = {
        cn = "clear;${pkgs.nitch}/bin/nitch";
        # Show nitch on fish start
        fish_greeting = "${pkgs.nitch}/bin/nitch";
        la = "${pkgs.exa}/bin/exa -la";
        # Recommendation from xdg-ninja
        wget = "${pkgs.wget}/bin/wget --hsts-file='$XDG_DATA_HOME/wget-hsts'";
      };
    };

    gpg = {
      enable = true;
      # Recommendation from xdg-ninja
      homedir = "${config.xdg.dataHome}/gnupg";
    };

    nix-index = {
      enable = true;
      enableFishIntegration = true;
    };
  };

  services.gpg-agent = {
    enable = true;
    enableFishIntegration = true;
  };
}
