# NVF Neovim configuration module
{
  lib,
  config,
  ...
}: let
  cfg = config.modules.nvf;
in {
  options.modules.nvf.enable = lib.mkEnableOption "NVF Neovim config";

  config = lib.mkIf cfg.enable {
    programs.nvf = {
      enable = true;
      defaultEditor = true;

      settings = import ./packages/nvf.nix {
        # Ghostty supports Kitty Image Protocol
        imageSupport = true;
        languageSupport = true;
      };
    };
  };
}
