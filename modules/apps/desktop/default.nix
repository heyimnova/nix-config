{ config, pkgs, ... }:

{
  environment.systemPackages = [ pkgs.mullvad-vpn ];
  services.mullvad-vpn.enable = true;
  system.fsPackages = [ pkgs.bindfs ];

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
}
