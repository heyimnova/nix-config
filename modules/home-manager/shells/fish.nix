# home-manager fish config
{ lib, config, pkgs, ... }:

let
  cfg = config.shells.fish;
in
{
  options.shells.fish.enable = lib.mkEnableOption "my fish shell config";

  config = lib.mkIf cfg.enable {
    programs.fish = {
      enable = true;

      interactiveShellInit = ''
        # Enable starship prompt
        ${pkgs.starship}/bin/starship init fish | source

        # Set fish vi mode cursor settings
        set fish_cursor_default underscore
        set fish_cursor_insert line blink
        set fish_cursor_replace_one underscore blink
        set fish_cursor_visual block

        # Bind k to atuin search in vi command mode
        bind -M default k _atuin_search
      '';

      shellAliases = {
        cn = "clear;${pkgs.nitch}/bin/nitch";
        # Show nitch on fish start
        fish_greeting = "${pkgs.nitch}/bin/nitch";
        la = "${pkgs.eza}/bin/eza --icons --group-directories-first -la";
        ls = "${pkgs.eza}/bin/eza --icons --group-directories-first";
        # Use nom in place of nix
        nix = "${pkgs.nix-output-monitor}/bin/nom";
        # Recommendation from xdg-ninja
        wget = "${pkgs.wget}/bin/wget --hsts-file='$XDG_DATA_HOME/wget-hsts'";
      };
    };
  };
}
