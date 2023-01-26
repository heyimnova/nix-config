{ config, lib, pkgs, ... }:

{
	home = {
		packages = (with pkgs; [
			bat
			bitwarden
			(discord.override {
				withOpenASAR = true;
			})
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
			spotify
			starship
			teams-for-linux
			texworks
			thunderbird
			tor-browser-bundle-bin
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

