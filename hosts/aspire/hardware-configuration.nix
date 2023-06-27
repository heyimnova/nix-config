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
        "ehci_pci"
        "sdhci_pci"
        "sd_mod"
        "sr_mod"
        "usb_storage"
        "xhci_pci"
      ];

      luks.devices."cryptroot" = {
        device = "/dev/disk/by-label/CRYPTROOT";
        keyFile = "/dev/disk/by-id/usb-General_UDisk-0:0";
        keyFileSize = 4096;
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
      fsType = "ext4";
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
