# User level config for all systems
{ config, pkgs, ... }:

{
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
        nix-gc = "sudo nix-collect-garbage -d; nix-collect-garbage -d";
        vi = "${pkgs.neovim}/bin/nvim";
        # Recommendation from xdg-ninja
        wget = "${pkgs.wget}/bin/wget --hsts-file='$XDG_DATA_HOME/wget-hsts'";
      };
    };

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
