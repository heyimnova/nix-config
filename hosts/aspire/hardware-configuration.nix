{ config, lib, modulesPath, ... }:

{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  networking.useDHCP = lib.mkDefault true;
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  swapDevices = [{ device = "/var/swap/swapfile"; }];

  boot = {
    extraModulePackages = [ ];
    kernelModules = [ "kvm-intel" ];

    initrd = {
      kernelModules = [ "usb_storage" ];

      availableKernelModules = [
        "ahci"
        "xhci_pci"
        "usb_storage"
        "sd_mod"
        "sr_mod"
        "rtsx_pci_sdmmc"
      ];

      luks.devices."cryptroot" = {
        device = "/dev/disk/by-label/CRYPTROOT";
        keyFileSize = 4096;
        keyFile = "/dev/disk/by-id/usb-General_UDisk-0:0";
      };
    };
  };

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-label/ROOT";
      fsType = "btrfs";

      options = [
        "compress=zstd"
        "noatime"
        "space_cache=v2"
        "subvol=@"
      ];
    };

    "/boot" = {
      device = "/dev/disk/by-label/BOOT";
      fsType = "f2fs";
    };

    "/home" = {
      device = "/dev/disk/by-label/ROOT";
      fsType = "btrfs";

      options = [
        "compress=zstd"
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
        "noatime"
        "space_cache=v2"
        "subvol=@var_log"
      ];
    };
  };
}
