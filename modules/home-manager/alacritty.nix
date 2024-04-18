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
        colors = with config.colorScheme.colors; {
          bright = {
            black = "0x${base00}";
            blue = "0x${base0D}";
            cyan = "0x${base0C}";
            green = "0x${base0B}";
            magenta = "0x${base0E}";
            red = "0x${base08}";
            white = "0x${base06}";
            yellow = "0x${base09}";
          };

          cursor = {
            cursor = "0x${base06}";
            text = "0x${base06}";
          };

          normal = {
            black = "0x${base00}";
            blue = "0x${base0D}";
            cyan = "0x${base0C}";
            green = "0x${base0B}";
            magenta = "0x${base0E}";
            red = "0x${base08}";
            white = "0x${base06}";
            yellow = "0x${base0A}";
          };

          primary = {
            background = "0x${base00}";
            foreground = "0x${base06}";
          };
        };

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
