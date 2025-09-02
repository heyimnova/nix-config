# GNOME home-manager config
{
  lib,
  pkgs,
  variables,
  ...
}: let
  gtk-settings = {
    extraConfig.gtk-application-prefer-dark-theme = 1;
  };
in
  lib.mkIf (variables.desktop == "gnome") {
    services.gpg-agent.pinentry.package = pkgs.pinentry-gnome3;
    # Disable stylix qt management at the home-manager level
    stylix.targets.qt.enable = false;

    dconf.settings = {
      "io/github/seadve/Mousai" = {
        preferred-audio-source = "desktop-audio";
      };

      # Do not create a Utilities folder in the app grid
      "org/gnome/desktop/app-folders/folders/Utilities" = {
        apps = [];
        categories = [];
      };

      "org/gnome/desktop/interface" = {
        clock-format = "12h";
        clock-show-weekday = true;
        # Replace hot corners with hot edge extension
        enable-hot-corners = false;
        # Disable middle-click paste (it is very annoying)
        gtk-enable-primary-paste = false;
      };

      "org/gnome/desktop/media-handling" = {
        autorun-never = true;
      };

      "org/gnome/desktop/wm/preferences" = {
        button-layout = ":close";
      };

      "org/gnome/GWeather4" = {
        temperature-unit = "centigrade";
      };

      "org/gnome/mutter" = {
        center-new-windows = true;
        dynamic-workspaces = true;
        workspaces-only-on-primary = true;
      };

      "org/gnome/shell" = {
        disable-user-extensions = false;

        enabled-extensions = [
          "drive-menu@gnome-shell-extensions.gcampax.github.com"
          "appindicatorsupport@rgcjonas.gmail.com"
          "status-area-horizontal-spacing@mathematical.coffee.gmail.com"
          "caffeine@patapon.info"
          "grand-theft-focus@zalckos.github.com"
          "clipboard-indicator@tudmotu.com"
          "blur-my-shell@aunetx"
          "gsconnect@andyholmes.github.io"
          "AlphabeticalAppGrid@stuarthayhurst"
          "user-theme@gnome-shell-extensions.gcampax.github.com"
          "system-monitor@gnome-shell-extensions.gcampax.github.com"
          "hotedge@jonathan.jdoda.ca"
        ];

        favorite-apps = [
          "org.gnome.Nautilus.desktop"
          "com.mitchellh.ghostty.desktop"
          "spotify.desktop"
          "mullvad-browser.desktop"
          "firefox.desktop"
          "signal.desktop"
          "vesktop.desktop"
          "revolt-desktop.desktop"
          "freetube.desktop"
          "fluent-reader.desktop"
          "proton-mail.desktop"
          "onlyoffice-desktopeditors.desktop"
          "steam.desktop"
          "com.heroicgameslauncher.hgl.desktop"
          "net.lutris.Lutris.desktop"
          "com.usebottles.bottles.desktop"
          "org.prismlauncher.PrismLauncher.desktop"
          "logseq.desktop"
          "bitwarden.desktop"
        ];
      };

      "org/gtk/gtk4/settings/file-chooser" = {
        sort-directories-first = true;
      };

      "org/gtk/settings/file-chooser" = {
        clock-format = "12h";
        sort-directories-first = true;
      };
    };

    gtk = {
      enable = true;
      gtk3 = gtk-settings;
      gtk4 = gtk-settings;

      iconTheme = {
        name = "Colloid";
        package = pkgs.colloid-icon-theme;
      };
    };

    home = {
      sessionVariables.GTK_THEME = "adw-gtk3-dark";

      packages =
        (with pkgs; [
          dconf-editor
          helvum
          mousai
          warp
        ])
        ++ (with pkgs.gnomeExtensions; [
          alphabetical-app-grid
          appindicator
          blur-my-shell
          caffeine
          clipboard-indicator
          grand-theft-focus
          hot-edge
          status-area-horizontal-spacing
        ]);
    };

    # Do qt theming on GNOME manually until stylix can
    qt = {
      enable = true;
      platformTheme.name = lib.mkForce "adwaita";
      style.name = lib.mkForce "adwaita-dark";
    };
  }
