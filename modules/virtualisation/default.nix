# NixOS virtualisation config
{ pkgs, ... }:

{
  environment.systemPackages = [ pkgs.virt-manager ];
  # libvirtd is currently disabled as it causes problems with quickemu
  virtualisation.libvirtd.enable = false;
}
