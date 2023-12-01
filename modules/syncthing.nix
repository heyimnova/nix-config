# Syncthing NixOS config
{ pkgs, flake-settings, ... }:

{
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
