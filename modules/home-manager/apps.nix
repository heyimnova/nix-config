{ lib, config, pkgs, ... }:

let
  cfg = config.apps;
in
{
  options.apps = {
    productivity = lib.mkEnableOption "productivity apps";
    social = lib.mkEnableOption "social apps";
  };

  config = lib.mkMerge [
    (lib.mkIf cfg.productivity {
      home.packages = with pkgs; [
        gimp
        onlyoffice-bin
      ];
    })

    (lib.mkIf cfg.social {
      home.packages = with pkgs; [
        element-desktop
        fluent-reader
        freetube
        revolt-desktop
        session-desktop
        signal-desktop

        (discord.override {
          withVencord = true;
        })
      ];
    })
  ];
}
