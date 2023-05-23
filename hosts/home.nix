{ config, lib, pkgs, ... }:

{
	imports = [
		../secrets/modules/git
	];

	home = {
		packages = (with pkgs; [
			bat
			(callPackage ../pkgs/bitwarden {})
			bleachbit
			brave
			clamav
			cpu-x
			(discord.override {
				withOpenASAR = true;
			})
			efibootmgr
			element-desktop
			exa
			fd
			ffmpeg
			file
			unstable.fluent-reader
			fragments
			freetube
			git-crypt
			git-filter-repo
			gitnuro
			helvum
			mousai
			nitch
			nodejs
			nodePackages.npm
			unstable.onlyoffice-bin
			poetry
			protonmail-bridge
			unstable.revolt-desktop
			ripgrep
			unstable.session-desktop
			unstable.shell-genie
			signal-desktop
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
