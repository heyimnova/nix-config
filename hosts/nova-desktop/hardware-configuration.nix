# Hardware config for nova-desktop
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
    extraModulePackages = [ config.boot.kernelPackages.v4l2loopback.out ];
    kernelModules = [ "kvm-amd" ];

    initrd = {
      availableKernelModules = [
        "ahci"
        "nvme"
        "sd_mod"
        "usbhid"
        "usb_storage"
        "xhci_pci"
      ];

      kernelModules = [
        "nvidia"
        "nvidia_drm"
        "nvidia_modeset"
        "nvidia_uvm"
        # Needed for Droidcam
        "v4l2loopback"
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
      # So sops-nix can find my age key on boot
      neededForBoot = true;

      options = [
        "compress=zstd"
        "discard=async"
        "noatime"
        "space_cache=v2"
        "subvol=@home"
      ];
    };

    "/mnt/storage" = {
      device = "/dev/disk/by-label/Storage";
      fsType = "ext4";
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

    "/var/lib/libvirt" = {
      device = "/dev/disk/by-label/ROOT";
      fsType = "btrfs";

      options = [
        "compress=zstd"
        "discard=async"
        "noatime"
        "space_cache=v2"
        "subvol=@libvirt"
      ];
    };

    "/var/lib/quickemu" = {
      device = "/dev/disk/by-label/ROOT";
      fsType = "btrfs";

      options = [
        "compress=zstd"
        "discard=async"
        "noatime"
        "space_cache=v2"
        "subvol=@quickemu"
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
