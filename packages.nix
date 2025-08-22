{
  nixpkgs,
  nixpkgs-stable,
  inputs,
}: {
  nvf =
    (inputs.nvf.lib.neovimConfiguration {
      pkgs = nixpkgs.legacyPackages."x86_64-linux";
      modules = [
        (import ./modules/packages/nvf.nix {
          languageSupport = false;
          imageSupport = false;
        })
      ];
    })
    .neovim;

  fullNvf =
    (inputs.nvf.lib.neovimConfiguration {
      pkgs = nixpkgs.legacyPackages."x86_64-linux";
      modules = [
        (import ./modules/packages/nvf.nix {
          languageSupport = true;
          imageSupport = false;
        })
      ];
    })
    .neovim;
}
