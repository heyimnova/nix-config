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
        def cn [] { clear;${lib.getExe pkgs.nitch} }
        def nix-gc [] { sudo nix-collect-garbage -d;nix-collect-garbage -d }
      '';

      extraConfig = ''
        # Enable starship prompt
        use ~/.cache/starship/init.nu

        # Show nitch on nushell start
        ${lib.getExe pkgs.nitch}
      '';

      extraEnv = ''
        # Enable starship prompt
        mkdir ~/.cache/starship
        ${lib.getExe pkgs.starship} init nu | save -f ~/.cache/starship/init.nu
      '';

      shellAliases = {
        la = "${lib.getExe pkgs.eza} --icons --group-directories-first -la";
        ls = "${lib.getExe pkgs.eza} --icons --group-directories-first";
        # Recommendation from xdg-ninja
        wget = "${lib.getExe pkgs.wget} --hsts-file='$XDG_DATA_HOME/wget-hsts'";
      };
    };
  };
}
