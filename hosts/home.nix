{ config, lib, pkgs, ... }:

{
	imports = [
		../secrets/modules/git
	];

	home = {
		packages = (with pkgs; [
			bat
			unstable.bitwarden
			unstable.bottles
			brave
			(unstable.discord.override {
				withOpenASAR = true;
			})
			unstable.element-desktop
			exa
			ffmpeg
			file
			unstable.fluent-reader
			fragments
			unstable.freetube
			git-crypt
			helvum
			mousai
			nitch
			nodejs
			nodePackages.npm
			onlyoffice-bin
			poetry
			protonmail-bridge
			(callPackage ../packages/revolt-desktop {})
			ripgrep
			unstable.session-desktop
			unstable.signal-desktop
			spotify
			starship
			tealdeer
			unstable.teams-for-linux
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
			clipboard-indicator
			gsconnect
			grand-theft-focus
		]) ++ (with pkgs.unstable.gnomeExtensions; [
			caffeine
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
