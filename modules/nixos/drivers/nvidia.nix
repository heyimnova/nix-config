{ lib, config, ... }:

let
  cfg = config.drivers.nvidia;
in 
{
  options.drivers.nvidia = {
    enable = lib.mkEnableOption "Enable Nvidia drivers";
    extras = lib.mkEnableOption "Enable extra Nvidia features";
  };

  config = lib.mkIf cfg.enable (lib.mkMerge [
    {
      services.xserver.videoDrivers = [ "nvidia" ];

      hardware.nvidia = {
	modesetting.enable = true;
	# Open kernel module is now recommended
	open = true;
	package = config.boot.kernelPackages.nvidiaPackages.latest;
      };
    }

    (lib.mkIf cfg.extras {
      # Enable Nvidia GPU use within Podman containers
      hardware.nvidia-container-toolkit.enable = true;
      nixpkgs.config.cudaSupport = true;
    })
  ]);
}
