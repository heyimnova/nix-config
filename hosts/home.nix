{ config, lib, pkgs, ... }:

{
	imports = [
		../secrets/modules/git
	];

	home = {
		packages = (with pkgs; [
			bat
			bitwarden
			bottles
			(discord.override {
				withOpenASAR = true;
			})
			element-desktop
			exa
			ffmpeg
			file
			fluent-reader
			fragments
			freetube
			git-crypt
			mousai
			nitch
			nodejs
			nodePackages.npm
			onlyoffice-bin
			poetry
			protonmail-bridge
			ripgrep
			session-desktop
			signal-desktop
			spotify
			starship
			tealdeer
			teams-for-linux
			texworks
			thunderbird
			tor-browser-bundle-bin
			vscodium
			warp
			xdg-ninja
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
		nix-index = {
			enable = true;
			enableFishIntegration = true;
		};
	};
}
