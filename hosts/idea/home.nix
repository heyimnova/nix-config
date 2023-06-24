{ pkgs, ... }:

{
    home = {
        packages = with pkgs; [
            ripgrep
        ];

        stateVersion = "23.05";
    };
}
