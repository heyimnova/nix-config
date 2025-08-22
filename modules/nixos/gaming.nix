# NixOS gaming config
{
  lib,
  config,
  ...
}: let
  cfg = config.modules.gaming;
in {
  options.modules.gaming.enable = lib.mkEnableOption "gaming nixos options";

  config = lib.mkIf cfg.enable {
    # Low latency pipewire from nix-gaming
    services.pipewire.lowLatency.enable = true;

    programs = {
      gamemode.enable = true;

      steam = {
        enable = true;
        localNetworkGameTransfers.openFirewall = true;
        # Enable SteamOS optimizations
        platformOptimizations.enable = true;
        # Enable Steam Input on Wayland
        extest.enable = true;
      };
    };
  };
}
