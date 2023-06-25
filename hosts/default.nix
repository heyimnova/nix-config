{ pkgs, ... }:

{
  console.font = "Lat2-Terminus16";
  documentation.nixos.enable = false;
  time.timeZone = "Europe/London";

  boot = {
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
    shells = [ pkgs.fish ];

    variables = {
      EDITOR = "${pkgs.helix}/bin/hx";
      VISUAL = "${pkgs.helix}/bin/hx";
    };

    systemPackages = with pkgs; [
      bat
      curl
      exa
      helix
      unzip
      wget
    ];
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
      experimental-features = [ "flakes" "nix-command" ];
    };
  };

  programs = {
    fish.enable = true;
    gnupg.agent.enable = true;
  };

  services = {
    cron.enable = true;

    avahi = {
      enable = true;
      nssmdns = true;
      publish = {
        addresses = true;
        enable = true;
        userServices = true;
      };
    };
  };

  systemd.extraConfig = ''
    DefaultTimeoutStopSec=10s
  '';

  users = {
    defaultUserShell = pkgs.fish;
    mutableUsers = false;
    users.root.hashedPassword = "*";

    users.nova = {
      description = "Nova";
      isNormalUser = true;
      useDefaultShell = true;
    };
  };
}
