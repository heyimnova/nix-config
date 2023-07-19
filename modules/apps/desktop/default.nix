# System-wide general desktop app config
{ config, pkgs, ... }:

{
  system.fsPackages = [ pkgs.bindfs ];

  # Fixes missing themes and icons in Flatpaks
  fileSystems = let
    mkRoSymBind = path: {
      device = path;
      fsType = "fuse.bindfs";
      options = [ "resolve-symlinks" "ro" "x-gvfs-hide" ];
    };
    aggregatedFonts = pkgs.buildEnv {
      name = "system-fonts";
      paths = config.fonts.fonts;
      pathsToLink = [ "/share/fonts" ];
    };
  in {
    "/usr/share/fonts" = mkRoSymBind (aggregatedFonts + "/share/fonts");
    "/usr/share/icons" = mkRoSymBind "/run/current-system/sw/share/icons";
  };

  services.mullvad-vpn = {
    enable = true;
    package = pkgs.mullvad-vpn;
  };
}
