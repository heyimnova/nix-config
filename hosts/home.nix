{ config, lib, pkgs, ... }:

{
	home = {
		packages = (with pkgs; [
			bat
			birdtray
			bitwarden
			element-desktop
			exa
			fluent-reader
			fragments
			freetube
			git-crypt
			mousai
			neofetch
			onlyoffice-bin
			ripgrep
			session-desktop
			signal-desktop
			starship
			texworks
			thunderbird
			vscodium
			warp
		]) ++ (with pkgs.gnomeExtensions; [
			alphabetical-app-grid
			appindicator
			blur-my-shell
			caffeine
			clipboard-indicator
			gsconnect
			grand-theft-focus
			status-area-horizontal-spacing
		]);

		stateVersion = "22.11";
	};

	programs = {
		home-manager.enable = true;
	};
}

