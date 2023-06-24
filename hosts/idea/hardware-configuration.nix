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
      availableKernelModules = [ "ahci" "xhci_pci" "usb_storage" "sd_mod" "sr_mod" "rtsx_pci_sdmmc" ];
      kernelModules = [ ];
      luks.devices."cryptroot".device = "/dev/disk/by-label/CRYPTROOT";
    };
  };

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-label/ROOT";
      fsType = "xfs";
    };

    "/boot" = {
      device = "/dev/disk/by-label/BOOT";
      fsType = "vfat";
    };
  };
}
