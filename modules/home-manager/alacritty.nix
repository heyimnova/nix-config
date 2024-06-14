# home-manager alacritty config
{ lib, config, pkgs, ... }:

let
  cfg = config.modules.alacritty;
in
{
  options.modules.alacritty.enable = lib.mkEnableOption "my alacritty config";

  config = lib.mkIf cfg.enable {
    programs.alacritty = {
      enable = true;

      settings = {
        cursor = {
          blink_interval = 500;
          unfocused_hollow = false;

          style = {
            blinking = "Always";
            shape = "Underline";
          };
        };

        window.padding = {
          x = 3;
          y = 3;
        };
      };
    };
  };
}
