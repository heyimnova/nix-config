{
  description = "My NixOS and home-manager configurations";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/release-24.11";

    # Used for pipewire low latency
    nix-gaming.url = "github:fufexan/nix-gaming";

    # Used for cursors and Firefox extensions
    nur.url = "github:nix-community/NUR";

    # Automatic for colorscheme management
    stylix.url = "github:danth/stylix";
    stylix-stable.url = "github:danth/stylix/release-24.11";

    arkenfox = { # Firefox enhancements
      url = "github:dwarfmaster/arkenfox-nixos";
      inputs.nixpkgs.follows = "nixpkgs-stable";
    };

    # User level Nix management
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager-stable = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs-stable";
    };

    lanzaboote = { # Secureboot
      url = "github:nix-community/lanzaboote";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-index-database = { # Quickly locate Nix packages
      url = "github:mic92/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = { # Neovim management with Nix
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix = { # Secrets management
      url = "github:mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs-stable";
    };

    spicetify-nix = { # Spotify theming
      url = "github:gerg-l/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    umu = { # Proton outside of Steam (used in Lutris)
      url = "git+https://github.com/Open-Wine-Components/umu-launcher/?dir=packaging\/nix&submodules=1";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # EasyEffects profiles
    easyeffects-presets = {
      url = "github:jackhack96/easyeffects-presets";
      flake = false;
    };

    easyeffects-presets-loudness-equalizer = {
      url = "github:digitalone1/easyeffects-presets";
      flake = false;
    };

    firefox-gnome-theme = { # GNOME theme for Firefox
      url = "github:rafaelmardojai/firefox-gnome-theme";
      flake = false;
    };
  };

  outputs = { nixpkgs, nixpkgs-stable, ... } @ inputs:
  let
    variables = { # Configurable variables
      user = "nova";
      userDescription = "Nova";
      userHome = "/home/nova";
      userShell = "fish";
      desktop = "gnome";
    };
  in
  {
    nixosConfigurations = (
      import ./hosts { inherit nixpkgs nixpkgs-stable inputs variables; }
    );
  };
}
