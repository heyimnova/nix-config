# GNOME home-manager config
{ lib, config, pkgs, ... }:

let
  gtk-settings = {
    extraConfig.gtk-application-prefer-dark-theme = 1;
  };
in
lib.mkIf config.desktops.gnome.enable {
  modules.alacritty.enable = true;
  services.gpg-agent.pinentryPackage = pkgs.pinentry-gnome3;

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
        "Vitals@CoreCoding.com"
        "AlphabeticalAppGrid@stuarthayhurst"
      ];

      favorite-apps = [
        "org.gnome.Nautilus.desktop"
        "com.raggesilver.BlackBox.desktop"
        "spotify.desktop"
        "mullvad-browser.desktop"
        "firefox.desktop"
        "signal-desktop.desktop"
        "element-desktop.desktop"
        "revolt-desktop.desktop"
        "discord.desktop"
        "freetube.desktop"
        "fluent-reader.desktop"
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

    # Create nix-colors colorscheme for blackbox
    file.".local/share/blackbox/schemes/nix-colors.json".text = with config.colorScheme.colors; ''
      {
        "name": "nix-colors",
        "comment": "Use nix-colors theme for blackbox",
        "use-theme-colors": false,
        "foreground-color": "#${base06}",
        "background-color": "#${base00}",
        "palette": [
          "#${base01}",
          "#${base08}",
          "#${base0B}",
          "#${base0A}",
          "#${base0D}",
          "#${base0E}",
          "#${base0C}",
          "#${base04}",
          "#${base03}",
          "#${base08}",
          "#${base0B}",
          "#${base0A}",
          "#${base0D}",
          "#${base0E}",
          "#${base0C}",
          "#${base06}"
        ]
      }
    '';

    packages = (with pkgs; [
      gnome.dconf-editor
      helvum
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

    pointerCursor = {
      name = "Vimix-white-cursors";
      package = pkgs.vimix-cursors;
      x11.enable = true;
    };
  };

  qt = {
    enable = true;
    platformTheme = "gnome";

    style = {
      name = "adwaita-dark";
      package = pkgs.adwaita-qt6;
    };
  };
}
