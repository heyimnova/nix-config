{ config, pkgs, ... }:

{
  imports = [
    ../secrets/programs/git/home.nix
    ../secrets/programs/fish/home.nix
  ];

  home = {
    packages = with pkgs; [
      efibootmgr
      git-crypt
      shell-genie
      tealdeer
      xdg-ninja
    ];
  };

  programs = {
    home-manager.enable = true;

    fish = {
      enable = true;

      interactiveShellInit = ''
        ${pkgs.starship}/bin/starship init fish | source
      '';

      shellAliases = {
        cn = "clear;${pkgs.nitch}/bin/nitch";
        fish_greeting = "${pkgs.nitch}/bin/nitch";
        la = "${pkgs.exa}/bin/exa -la";
        wget = "${pkgs.wget}/bin/wget --hsts-file='$XDG_DATA_HOME/wget-hsts'";
      };
    };

    gpg = {
      enable = true;
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
