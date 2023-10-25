{ pkgs, ... }:

{
  programs.firefox = {
    enable = true;

    arkenfox = {
      enable = true;
      version = "118.0";
    };

    profiles = {
      default = {
        id = 0;

        # Arkenfox config and overrides
        arkenfox = {
          enable = true;
          "0000".enable = true; # TOPLEVEL
          "0200".enable = true; # GEOLOCATION / LANGUAGE / LOCALE
          "0300".enable = true; # QUIETER FOX
          "0400".enable = true; # SAFE BROWSING
          "0600".enable = true; # BLOCK IMPLICIT OUTBOUND
          "0700".enable = true; # DNS / DoH / PROXY / SOCKS / IPv6
          "0800".enable = true; # LOCATION BAR / SEARCH BAR / SUGGESTIONS / HISTORY / FORMS
          "0900".enable = true; # PASSWORDS
          "1000".enable = true; # DISK AVOIDANCE
          "1200".enable = true; # HTTPS (SSL/TLS / OCSP / CERTS / HPKP)
          "1600".enable = true; # HEADERS / REFERERS
          "2000".enable = true; # PLUGINS / MEDIA / WEBRTC
          "2400".enable = true; # DOM (DOCUMENT OBJECT MODEL)
          "2600".enable = true; # MISCELLANEOUS
          "2700".enable = true; # ETP (ENHANCED TRACKING PROTECTION)
          "2800".enable = true; # SHUTDOWN & SANITIZING
          "4500".enable = true; # RFP (RESIST FINGERPRINTING)
          "6000".enable = true; # DON'T TOUCH
          "9000".enable = true; # NON-PROJECT RELATED

          "0100" = { # STARTUP
            enable = true;
            "0102"."browser.startup.page".value = 1; # Set startup page to homepage
            "0103"."browser.startup.homepage".value = "about:profiles"; # Set homepage to about:profiles
            "0104"."browser.newtabpage.enabled".value = true; # Set new tab page to homepage
          };

          "5000" = { # OPTIONAL OPSEC
            enable = true;
            "5003"."signon.rememberSignons".value = false; # Disable saving passwords
            "5004"."permissions.memory_only".value = true; # Disable permissions manager from writing to disk
            "5005"."security.nocertdb".value = true; # Disable intermediate certificate caching
            "5018"."dom.popup_allowed_events".value = "click dblclick mousedown pointerdown"; # Limit events that can cause a pop-up
            "5019"."browser.pagethumbnails.capturing_disabled".value = true; # Disable page thumbnail collection

            "5017" = { # Disable Form Autofill
              "extensions.formautofill.addresses.enabled".value = false;
              "extensions.formautofill.creditCards.enabled".value = false;
            };
          };

          "5500" = { # OPTIONAL HARDENING
            enable = true;
            "5510"."network.http.referer.XOriginPolicy".value = 2; # Only send cross-origin referers when hosts match

            "5508" = { # Disable DRM media
              "browser.eme.ui.enabled".value = false;
              "media.eme.enabled".value = false;
            };
          };
        };

        extensions = with pkgs.nur.repos.rycee.firefox-addons; [
          mullvad
          skip-redirect
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

            # Search engine config for the home-manager option search
            "Home Manager" = {
              definedAliases = [ "@hm" ];

              urls = [{
                template = "https://mipmip.github.io/home-manager-option-search";

                params = [{
                  name = "query";
                  value = "{searchTerms}";
                }];
              }];
            };

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

            # Search engine config for ProtonDB search
            "ProtonDB" = {
              definedAliases = [ "@pr" ];

              urls = [{
                template = "https://www.protondb.com/search";

                params = [{
                  name = "q";
                  value = "{searchTerms}";
                }];
              }];
            };
          };

          order = [
            "DuckDuckGo"
            "ProtonDB"
            "Nix Packages"
            "Nix Options"
            "Home Manager"
            "Wikipedia (en)"
            "Mullvad Leta"
          ];
        };

        settings = {
          # Only show downloads button when there is a download
          "browser.download.autohideButton" = true;
          # Disable topsites on about:home
          "browser.newtabpage.activity-stream.feeds.system.topsites" = false;
          "browser.newtabpage.activity-stream.feeds.system.topstories" = false;
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

      home = {
        id = 1;

        # Arkenfox config and overrides
        arkenfox = {
          enable = true;
          "0000".enable = true; # TOPLEVEL
          "0200".enable = true; # GEOLOCATION / LANGUAGE / LOCALE
          "0300".enable = true; # QUIETER FOX
          "0400".enable = true; # SAFE BROWSING
          "0600".enable = true; # BLOCK IMPLICIT OUTBOUND
          "0700".enable = true; # DNS / DoH / PROXY / SOCKS / IPv6
          "0800".enable = true; # LOCATION BAR / SEARCH BAR / SUGGESTIONS / HISTORY / FORMS
          "0900".enable = true; # PASSWORDS
          "1000".enable = true; # DISK AVOIDANCE
          "1200".enable = true; # HTTPS (SSL/TLS / OCSP / CERTS / HPKP)
          "1600".enable = true; # HEADERS / REFERERS
          "1700".enable = true; # CONTAINERS
          "2000".enable = true; # PLUGINS / MEDIA / WEBRTC
          "2400".enable = true; # DOM (DOCUMENT OBJECT MODEL)
          "2600".enable = true; # MISCELLANEOUS
          "2700".enable = true; # ETP (ENHANCED TRACKING PROTECTION)
          "2800".enable = true; # SHUTDOWN & SANITIZING
          "6000".enable = true; # DON'T TOUCH
          "9000".enable = true; # NON-PROJECT RELATED

          "0100" = { # STARTUP
            enable = true;
            "0102"."browser.startup.page".value = 1; # Set startup page to homepage
            "0103"."browser.startup.homepage".value = "about:home"; # Set homepage to Firefox homepage
            "0104"."browser.newtabpage.enabled".value = true; # Set new tab page to homepage
          };

          "5000" = { # OPTIONAL OPSEC
            enable = true;
            "5003"."signon.rememberSignons".value = false; # Disable saving passwords
            "5005"."security.nocertdb".value = true; # Disable intermediate certificate caching
            "5008"."browser.sessionstore.resume_from_crash".value = false; # Disable resuming session from crash
            "5018"."dom.popup_allowed_events".value = "click dblclick mousedown pointerdown"; # Limit events that can cause a pop-up
            "5019"."browser.pagethumbnails.capturing_disabled".value = true; # Disable page thumbnail collection

            "5017" = { # Disable Form Autofill
              "extensions.formautofill.addresses.enabled".value = false;
              "extensions.formautofill.creditCards.enabled".value = false;
            };
          };
        };

        extensions = with pkgs.nur.repos.rycee.firefox-addons; [
          bitwarden
          mullvad
          multi-account-containers
          simplelogin
          skip-redirect
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
            "Wikipedia (en)".metaData.hidden = true;
            "Mullvad Leta".metaData.hidden = true;
          };
        };

        settings = {
          # Only show downloads button when there is a download
          "browser.download.autohideButton" = true;
          # Disable topsites on about:home
          "browser.newtabpage.activity-stream.feeds.system.topsites" = false;
          "browser.newtabpage.activity-stream.feeds.system.topstories" = false;
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
