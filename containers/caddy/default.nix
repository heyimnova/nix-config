{ ... }:

{
  networking.nat.internalInterfaces = [ "ve-caddy" ];

  containers.caddy = {
    autoStart = true;
    bindMounts."/var/lib/secrets/cloudflare".hostPath = "/var/lib/secrets/cloudflare";
    hostAddress = "10.4.0.1";
    hostAddress6 = "fc00::1";
    localAddress = "10.4.0.5";
    localAddress6 = "fc00::5";
    privateNetwork = true;

    config = { ... }: {
      imports = [
        ../../secrets/programs/acme/caddy
        ../../secrets/services/acme
      ];

      environment.etc."resolv.conf".text = "nameserver 10.0.0.3";
      security.acme.acceptTerms = true;
      services.caddy.enable = true;
      system.stateVersion = "23.05";
    };
  };
}
