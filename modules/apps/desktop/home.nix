# User level general desktop app config
{ pkgs, ... }:

{
  home.packages = with pkgs; [
    birdtray
    bitwarden
    bleachbit
    cpu-x
    gimp
    helvum
    inkscape
    onlyoffice-bin
    protonmail-bridge
    qbittorrent
    spotify
    texworks
    thunderbird
    tor-browser-bundle-bin
  ];

  programs = {
    firefox = {
      enable = true;

      arkenfox = {
        enable = true;
        version = "112.0";
      };

      profiles.default = {
        # Arkenfox config and overrides
        arkenfox = {
          enable = true;
          "0000".enable = true; # TOPLEVEL
          "0200".enable = true; # GEOLOCATION / LANGUAGE / LOCALE
          "0300".enable = true; # QUIETER FOX
          "0400".enable = true; # SAFE BROWSING
          "0600".enable = true; # BLOCK IMPLICIT OUTBOUND
          "0700".enable = true; # DNS / DoH / PROXY / SOCKS / IPv6
          "0900".enable = true; # PASSWORDS
          "1000".enable = true; # DISK AVOIDANCE
          "1200".enable = true; # HTTPS (SSL/TLS / OCSP / CERTS / HPKP)
          "1600".enable = true; # HEADERS / REFERERS
          "1700".enable = true; # CONTAINERS
          "2400".enable = true; # DOM (DOCUMENT OBJECT MODEL)
          "2600".enable = true; # MISCELLANEOUS
          "2700".enable = true; # ETP (ENHANCED TRACKING PROTECTION)
          "2800".enable = true; # SHUTDOWN & SANITIZING
          "5500".enable = true; # OPTIONAL HARDENING
          "6000".enable = true; # DON'T TOUCH
          "7000".enable = true; # DON'T BOTHER
          "9000".enable = true; # NON-PROJECT RELATED

          "0100" = { # STARTUP
            enable = true;
            "0102"."browser.startup.page".value = 1; # Set startup page to homepage
            "0103"."browser.startup.homepage".value = "about:home"; # Set homepage to about:home
            "0104"."browser.newtabpage.enabled".value = true; # Set new tab page to homepage
          };

          "0800" = { # LOCATION BAR / SEARCH BAR / SUGGESTIONS / HISTORY / FORMS
            enable = true;
            "0801"."keyword.enabled".value = true; # Allow searching from URL bar
          };

          "2000" = { # PLUGINS / MEDIA / WEBRTC
            enable = true;
            "2022"."media.eme.enabled".value = true; # Allow DRM media
          };
        };

        extensions = with pkgs.nur.repos.rycee.firefox-addons; [
          bitwarden
          mullvad
          ublock-origin
        ];

        search = {
          default = "DuckDuckGo";
          # Fixes a home-manager switching error
          force = true;

          engines = {
            # Hide the default engines I don't use
            "Amazon.de".metaData.hidden = true;
            "Bing".metaData.hidden = true;
            "eBay".metaData.hidden = true;
            "Google".metaData.hidden = true;
            # Set better aliases for the engines I do use
            "Mullvad Leta".metaData.alias = "@ml";
            "Wikipedia (en)".metaData.alias = "@wp";

            # Search engine config for the NixOS option search
            "NixOS Options" = {
              definedAliases = [ "@no" ];
              icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";

              urls = [{
                template = "https://search.nixos.org/options";

                params = [{
                  name = "query";
                  value = "{searchTerms}";
                }];
              }];
            };

            # Search engine config for the NixOS package search
            "Nix Packages" = {
              definedAliases = [ "@np" ];
              icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";

              urls = [{
                template = "https://search.nixos.org/packages";

                params = [{
                  name = "query";
                  value = "{searchTerms}";
                }];
              }];
            };
          };

          order = [
            "DuckDuckGo"
            "Nix Packages"
            "Nix Options"
            "Wikipedia (en)"
            "Mullvad Leta"
          ];
        };

        settings = {
          # Only show downloads button when there is a download
          "browser.download.autohideButton" = true;
          # Disable topsites on about:home
          "browser.newtabpage.activity-stream.feeds.system.topsites" = false;
          "browser.newtabpage.activity-stream.feeds.topsites" = false;
          # Disable default browser popup
          "browser.shell.checkDefaultBrowser" = false;
          # Disable Firefox View
          "browser.tabs.firefox-view" = false;
          # Disable saving form data
          "dom.payments.defaults.saveAddress" = false;
          # Disable Pocket
          "extensions.pocket.enabled" = false;
          # Enable middle click scroll
          "general.autoScroll" = true;
          # Disable Firefox accounts
          "identity.fxaccounts.enabled" = false;
        };
      };
    };
  };
}
