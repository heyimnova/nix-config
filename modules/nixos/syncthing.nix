# Syncthing NixOS config
{ lib
, config
, pkgs
, variables
, ...
}:

let
  cfg = config.modules.syncthing;
in
{
  options.modules.syncthing = {
    enable = lib.mkEnableOption "Syncthing";

    devices = {
      coral = lib.mkEnableOption "Syncthing coral device";
      the-thinker = lib.mkEnableOption "Syncthing the-thinker device";
    };

    folders = {
      logseq = lib.mkEnableOption "Syncthing logseq folder";
      work = lib.mkEnableOption "Syncthing work folder";
    };
  };

  config = lib.mkIf cfg.enable (lib.mkMerge [
    {
      services.syncthing = {
        configDir = "${variables.userHome}/.config/syncthing";
        dataDir = "${variables.userHome}/.local/state/syncthing";
        enable = true;
        openDefaultPorts = true;
        user = variables.user;

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

    (lib.mkIf cfg.devices.the-thinker {
      services.syncthing.settings.devices."the-thinker".id = "Z4KSWJF-OOFMCZV-OPA3UYL-WW4DXUL-L6XTMLY-N3R2SRY-ETXDPXU-QMOPSQZ";
    })

    # Folders
    (lib.mkIf cfg.folders.logseq (lib.mkMerge [
      {
        services.syncthing.settings.folders."logseq" = {
          enable = true;
          path = "${variables.userHome}/Documents/logseq";
          versioning.type = "trashcan";
        };
      }

      (lib.mkIf cfg.devices.coral {
        services.syncthing.settings.folders."logseq".devices = [ "coral" ];
      })

      (lib.mkIf cfg.devices.the-thinker {
        services.syncthing.settings.folders."logseq".devices = [ "the-thinker" ];
      })
    ]))

    (lib.mkIf cfg.folders.work (lib.mkMerge [
      {
        services.syncthing.settings.folders."work" = {
          enable = true;
          path = "${variables.userHome}/Documents/work";
          versioning.type = "trashcan";
        };
      }

      (lib.mkIf cfg.devices.the-thinker {
        services.syncthing.settings.folders."work".devices = [ "the-thinker" ];
      })
    ]))

    # Desktop specific
    (lib.mkIf (variables.desktop == "kde") {
      environment.systemPackages = [ pkgs.syncthingtray-minimal ];
    })
  ]);
}
