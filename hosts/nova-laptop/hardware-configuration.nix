# Hardware config for nova-laptop
{ config, lib, modulesPath, ... }:

{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  networking.useDHCP = lib.mkDefault true;
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  swapDevices = [{ device = "/var/swap/swapfile"; }];

  boot = {
    extraModulePackages = [ ];
    kernelModules = [ "kvm-amd" ];

    initrd = {
      kernelModules = [ ];
      luks.devices."cryptroot".device = "/dev/disk/by-label/CRYPTROOT";

      availableKernelModules = [
        "ahci"
        "ehci_pci"
        "rtsx_usb_sdmmc"
        "sd_mod"
        "sr_mod"
        "usb_storage"
        "xhci_pci"
      ];
    };
  };

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-label/ROOT";
      fsType = "btrfs";

      options = [
        "compress=zstd"
        "discard=async"
        "noatime"
        "space_cache=v2"
        "subvol=@"
      ];
    };

    "/boot" = {
      device = "/dev/disk/by-label/BOOT";
      fsType = "vfat";
    };

    "/home" = {
      device = "/dev/disk/by-label/ROOT";
      fsType = "btrfs";

      options = [
        "compress=zstd"
        "discard=async"
        "noatime"
        "space_cache=v2"
        "subvol=@home"
      ];
    };

    "/nix" = {
      device = "/dev/disk/by-label/ROOT";
      fsType = "btrfs";

      options = [
        "compress=zstd"
        "discard=async"
        "noatime"
        "space_cache=v2"
        "subvol=@nix"
      ];
    };

    "/var/log" = {
      device = "/dev/disk/by-label/ROOT";
      fsType = "btrfs";

      options = [
        "compress=zstd"
        "discard=async"
        "noatime"
        "space_cache=v2"
        "subvol=@var_log"
      ];
    };
  };
}
