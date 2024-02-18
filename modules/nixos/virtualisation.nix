# NixOS virtualisation config
{ lib, config, pkgs, ... }:

let
  cfg = config.virtualisation;
in
{
  options.virtualisation.enable = lib.mkEnableOption "virtualisation services";

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [ pkgs.virt-manager ];
    # libvirtd is currently disabled as it causes problems with quickemu
    virtualisation.libvirtd.enable = false;
  };
}
