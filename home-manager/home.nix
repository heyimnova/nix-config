# Default home-manager configuration
{ config, lib, pkgs, flake-settings, ... }:

{
  manual = { manpages.enable = false; }; # Disable manpages (nmd dependency is broken)

  home = {
    # Needed for standalone home-manager
    homeDirectory = lib.mkDefault flake-settings.userHome;
    stateVersion = lib.mkDefault flake-settings.stableVersion;
    username = lib.mkDefault flake-settings.user;

    packages = with pkgs; [
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

      # Enable starship prompt
      interactiveShellInit = ''
        ${pkgs.starship}/bin/starship init fish | source

        # Set fish vi mode cursor settings
        set fish_cursor_default underscore
        set fish_cursor_insert line blink
        set fish_cursor_replace_one underscore blink
        set fish_cursor_visual block
      '';

      shellAliases = {
        cn = "clear;${pkgs.nitch}/bin/nitch";
        # Show nitch on fish start
        fish_greeting = "${pkgs.nitch}/bin/nitch";
        la = "${pkgs.eza}/bin/eza --icons --group-directories-first -la";
        ls = "${pkgs.eza}/bin/eza --icons --group-directories-first";
        nix-gc = "sudo nix-collect-garbage -d;nix-collect-garbage -d";
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
