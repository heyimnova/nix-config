{ pkgs, ... }:

{
    imports = [
        ../home.nix
    ];

    home = {
        packages = with pkgs; [
            ripgrep
        ];

        stateVersion = "23.05";
    };
}
