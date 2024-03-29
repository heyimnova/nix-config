# GNOME home-manager config
{ lib, config, pkgs, ... }:

lib.mkIf config.desktops.gnome.enable {
  services.gpg-agent.pinentryFlavor = "gnome3";

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
      color-scheme = "prefer-dark";
      document-font-name = "Liberation Sans 11";
      # Disable middle-click paste (it is very annoying)
      gtk-enable-primary-paste = false;
      monospace-font-name = "Monofur Nerd Font Mono 16";
    };

    "org/gnome/desktop/media-handling" = {
      autorun-never = true;
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
        "Vitals@CoreCoding.com"
        "AlphabeticalAppGrid@stuarthayhurst"
      ];

      favorite-apps = [
        "org.gnome.Nautilus.desktop"
        "com.raggesilver.BlackBox.desktop"
        "spotify.desktop"
        "firefox.desktop"
        "signal-desktop.desktop"
        "element-desktop.desktop"
        "revolt-desktop.desktop"
        "discord.desktop"
        "freetube.desktop"
        "fluent-reader.desktop"
        "onlyoffice-desktopeditors.desktop"
        "codium.desktop"
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
    gtk3.extraConfig.gtk-application-prefer-dark-theme = 1;
    gtk4.extraConfig.gtk-application-prefer-dark-theme = 1;

    cursorTheme = {
      name = "Vimix-white-cursors";
      package = pkgs.vimix-cursors;
    };

    iconTheme = {
      name = "Colloid";
      package = pkgs.colloid-icon-theme;
    };

    theme = {
      name = "adw-gtk3-dark";
      package = pkgs.adw-gtk3;
    };
  };

  home = {
    sessionVariables.GTK_THEME = "adw-gtk3-dark";

    packages = (with pkgs; [
      gnome.dconf-editor
      mousai
      warp
    ]) ++ (with pkgs.gnomeExtensions; [
      alphabetical-app-grid
      appindicator
      blur-my-shell
      caffeine
      clipboard-indicator
      grand-theft-focus
      status-area-horizontal-spacing
      vitals
    ]);
  };

  # Needed for firefox-gnome-theme
  programs.firefox.profiles = {
    default = {
      settings = {
        # Disable private window dark theme
        "browser.theme.dark-private-windows" = false;
        # Set UI density to normal
        "browser.uidensity" = 0;
        # Hide single tab
        "gnomeTheme.hideSingleTab" = true;
        # Hide extensions button
        "gnomeTheme.hideUnifiedExtensions" = true;
        # Allow recoloring of icons
        "svg.context-properties.content.enabled" = true;
        # Enable customChrome.css
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
      };

      userChrome = ''
        @import "firefox-gnome-theme/userChrome.css";
      '';

      userContent = ''
        @import "firefox-gnome-theme/userContent.css";
      '';
    };

    home = {
      settings = {
        # Disable private window dark theme
        "browser.theme.dark-private-windows" = false;
        # Set UI density to normal
        "browser.uidensity" = 0;
        # Hide single tab
        "gnomeTheme.hideSingleTab" = true;
        # Hide extensions button
        "gnomeTheme.hideUnifiedExtensions" = true;
        # Allow recoloring of icons
        "svg.context-properties.content.enabled" = true;
        # Enable customChrome.css
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
      };

      userChrome = ''
        @import "firefox-gnome-theme/userChrome.css";
      '';

      userContent = ''
        @import "firefox-gnome-theme/userContent.css";
      '';
    };
  };
}
