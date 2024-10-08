# Default NixOS configuration
{ pkgs, nur, flake-settings, ... }:

{
  console.font = "Lat2-Terminus16";
  documentation.nixos.enable = false;
  time.timeZone = "Europe/London";

  boot = {
    # A better tcp congestion control algorithm
    kernelModules = [ "tcp_bbr" ];

    # Network hardening from https://mdleom.com/blog/2020/03/04/caddy-nixos-part-2/
    kernel.sysctl = {
      # Disable magic SysRq key
      "kernel.sysrq" = 0;
      # Ignore ICMP broadcasts to avoid participating in Smurf attacks
      "net.ipv4.icmp_echo_ignore_broadcasts" = 1;
      # Ignore bad ICMP errors
      "net.ipv4.icmp_ignore_bogus_error_responses" = 1;
      # Reverse-path filter for spoof protection
      "net.ipv4.conf.default.rp_filter" = 1;
      "net.ipv4.conf.all.rp_filter" = 1;
      # SYN flood protection
      "net.ipv4.tcp_syncookies" = 1;
      # Do not accept ICMP redirects (prevent MITM attacks)
      "net.ipv4.conf.all.accept_redirects" = 0;
      "net.ipv4.conf.default.accept_redirects" = 0;
      "net.ipv4.conf.all.secure_redirects" = 0;
      "net.ipv4.conf.default.secure_redirects" = 0;
      "net.ipv6.conf.all.accept_redirects" = 0;
      "net.ipv6.conf.default.accept_redirects" = 0;
      # Do not send ICMP redirects (we are not a router)
      "net.ipv4.conf.all.send_redirects" = 0;
      # Do not accept IP source route packets (we are not a router)
      "net.ipv4.conf.all.accept_source_route" = 0;
      "net.ipv6.conf.all.accept_source_route" = 0;
      # Protect against tcp time-wait assassination hazards
      "net.ipv4.tcp_rfc1337" = 1;
      # Latency reduction
      "net.ipv4.tcp_fastopen" = 3;
      ## Bufferfloat mitigations
      # Requires >= 4.9 & kernel module
      "net.ipv4.tcp_congestion_control" = "bbr";
      # Requires >= 4.19
      "net.core.default_qdisc" = "cake";
    };
  };

  environment = {
    # Needed to remove perl and nano which I do not need
    defaultPackages = [];

    # These environment variables are set on user login
    sessionVariables = rec {
      # Used by nh
      FLAKE = flake-settings.location;

      XDG_BIN_HOME = "$HOME/.local/bin";
      XDG_CACHE_HOME = "$HOME/.cache";
      XDG_CONFIG_HOME = "$HOME/.config";
      XDG_DATA_HOME = "$HOME/.local/share";
      XDG_STATE_HOME = "$HOME/.local/state";

      PATH = [ "${XDG_BIN_HOME}" ];

      # Recommendations from xdg-ninja
      ANDROID_HOME = "${XDG_DATA_HOME}/android";
      CARGO_HOME = "${XDG_DATA_HOME}/cargo";
      CUDA_CACHE_PATH = "${XDG_CACHE_HOME}/nv";
      GNUPGHOME = "${XDG_DATA_HOME}/gnupg";
      INPUTRC = "${XDG_DATA_HOME}/readline/inputrc";
      _JAVA_OPTIONS = "-Djava.util.prefs.userRoot=${XDG_CONFIG_HOME}/java";
      LESSHISTFILE = "${XDG_DATA_HOME}/less/history";
      NPM_CONFIG_USERCONFIG = "${XDG_CONFIG_HOME}/npm/npmrc";
      WINEPREFIX = "${XDG_DATA_HOME}/wine";
      XCOMPOSECACHE = "${XDG_CACHE_HOME}/X11/xcompose";
    };

    shells = with pkgs; [
      bashInteractive
      fish
      nushell
    ];

    systemPackages = with pkgs; [
      bat
      curl
      eza
      nh
      neovim
      nix-output-monitor
      pciutils
      rsync
      sops
      strace
      tmux
      unzip
    ];

    variables = {
      EDITOR = "${pkgs.neovim}/bin/nvim";
      VISUAL = "${pkgs.neovim}/bin/nvim";
    };
  };

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_GB.UTF-8";
    LC_IDENTIFICATION = "en_GB.UTF-8";
    LC_MEASUREMENT = "en_GB.UTF-8";
    LC_MONETARY = "en_GB.UTF-8";
    LC_NAME = "en_GB.UTF-8";
    LC_NUMERIC = "en_GB.UTF-8";
    LC_PAPER = "en_GB.UTF-8";
    LC_TELEPHONE = "en_GB.UTF-8";
    LC_TIME = "en_GB.UTF-8";
  };

  nix = {
    gc = {
      automatic = true;
      dates = "daily";
      options = "--delete-older-than 3d";
    };

    settings = {
      auto-optimise-store = true;
      substituters = [ "https://nix-gaming.cachix.org" ];
      trusted-public-keys = [ "nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4=" ];

      experimental-features = [
        "flakes"
        "nix-command"
      ];
    };
  };

  nixpkgs = {
    config.allowUnfree = true;
    config.permittedInsecurePackages = [ "electron-27.3.11" ];
    overlays = [ nur.overlay ];
  };

  sops = {
    age.keyFile = "/home/${flake-settings.user}/.config/sops/age/keys.txt";
    defaultSopsFile = ../secrets/secrets.yaml;
    defaultSopsFormat = "yaml";
  };

  programs = {
    fish.enable = true;
    # Needed to completely remove nano
    nano.syntaxHighlight = false;
  };

  services = {
    cron.enable = true;
    fwupd.enable = true;

    avahi = {
      enable = true;
      nssmdns4 = true;

      publish = {
        addresses = true;
        enable = true;
        userServices = true;
      };
    };
  };

  system.autoUpgrade = {
    dates = "05:00";
    enable = true;
    # Assuming this repo is symlinked to (or in) /etc/nixos
    flake = "/etc/nixos";
    # Allow the service to catch up on updates if the system was powered down
    persistent = true;

    # Update all flake inputs so new packages are installed
    flags = [
      "--update-input"
      "arkenfox"
      "--update-input"
      "home-manager"
      "--update-input"
      "home-manager-unstable"
      "--update-input"
      "lanzaboote"
      "--update-input"
      "nur"
      "--update-input"
      "stable"
      "--update-input"
      "unstable"
      "--update-input"
      "utils"
    ];
  };

  systemd.extraConfig = ''
    # Faster shutdowns
    DefaultTimeoutStopSec=10s
  '';

  users = {
    mutableUsers = false;
    # Disable root password
    users.root.hashedPassword = "!";

    defaultUserShell =
      if flake-settings.userShell == "fish" then pkgs.fish
      else if flake-settings.userShell == "nushell" then pkgs.nushell
      else pkgs.bashInteractive;

    users.${flake-settings.user} = {
      description = flake-settings.userDescription;
      isNormalUser = true;
      useDefaultShell = true;
    };
  };
}
