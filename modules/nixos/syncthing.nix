# Syncthing NixOS config
{ lib, config, pkgs, flake-settings, ... }:

let
  cfg = config.syncthing;
in
{
  options.syncthing = {
    enable = lib.mkEnableOption "Syncthing";

    devices = {
      coral = lib.mkEnableOption "Syncthing coral device";
    };

    folders = {
      logseq = lib.mkEnableOption "Syncthing logseq folder";
    };
  };

  config = lib.mkIf cfg.enable (lib.mkMerge [
    {
      environment.systemPackages = [ pkgs.syncthingtray ];

      services.syncthing = {
        configDir = "/home/${flake-settings.user}/.config/syncthing";
        dataDir = "/home/${flake-settings.user}/.local/state/syncthing";
        enable = true;
        openDefaultPorts = true;
        user = flake-settings.user;

        settings.options = {
          globalAnnounceEnabled = false; # Don't use global discovery
          natEnabled = false; # Don't use UPnP and NAT-PMP
          relaysEnabled = false; # Don't use syncthing's relays
          startBrowser = false; # Don't attempt to start browser on syncthing start
          urAccepted = -1; # Don't ask to send telemetry
        };
      };
    }

    # Devices

    (lib.mkIf cfg.devices.coral {
      services.syncthing.settings.devices."coral".id = "STTRZSA-DBQGY3Z-7GQE5IJ-EUZG7LI-7FGZUKF-7UX2NKR-UC5GE6F-GGAQPQJ";
    })

    # Folders

    (lib.mkIf cfg.folders.logseq (lib.mkMerge [
      {
        services.syncthing.settings.folders."logseq" = {
          enable = true;
          path = "~/Documents/logseq";
          versioning.type = "trashcan";
        };
      }

      (lib.mkIf cfg.devices.coral {
        services.syncthing.settings.folders."logseq".devices = [ "coral" ];
      })
    ]))
  ]);
}
