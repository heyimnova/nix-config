# home-manager nushell config
{ lib, config, pkgs, ... }:

let
  cfg = config.shells.nushell;
in
{
  options.shells.nushell.enable = lib.mkEnableOption "my nushell config";

  config = lib.mkIf cfg.enable {
    programs.nushell = {
      enable = true;

      configFile.text = ''
        $env.config = {
          show_banner: false,
        }

        # Aliases that have to be functions
        def cn [] { clear;${pkgs.nitch}/bin/nitch }
        def nix-gc [] { sudo nix-collect-garbage -d;nix-collect-garbage -d }
      '';

      extraConfig = ''
        # Enable starship prompt
        use ~/.cache/starship/init.nu

        # Show nitch on nushell start
        ${pkgs.nitch}/bin/nitch
      '';

      extraEnv = ''
        # Enable starship prompt
        mkdir ~/.cache/starship
        ${pkgs.starship}/bin/starship init nu | save -f ~/.cache/starship/init.nu
      '';

      shellAliases = {
        la = "${pkgs.eza}/bin/eza --icons --group-directories-first -la";
        ls = "${pkgs.eza}/bin/eza --icons --group-directories-first";
        # Recommendation from xdg-ninja
        wget = "${pkgs.wget}/bin/wget --hsts-file='$XDG_DATA_HOME/wget-hsts'";
      };
    };
  };
}
