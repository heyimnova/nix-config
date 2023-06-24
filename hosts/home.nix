{ config, lib, pkgs, ... }:

{
	imports = [
		../secrets/modules/git
		../secrets/modules/fish
	];

	home = {
		packages = (with pkgs; [
			amberol
			bat
			bitwarden
			bleachbit
			bottles
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
			fluent-reader
			freetube
			git-crypt
			git-filter-repo
			gitnuro
			helvum
			mousai
			nodejs
			nodePackages.npm
			onlyoffice-bin
			poetry
			protonmail-bridge
			qbittorrent
			revolt-desktop
			ripgrep
			session-desktop
			shell-genie
			signal-desktop
			spotify
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
			grand-theft-focus
			status-area-horizontal-spacing
		]);
	};

	programs = {
		home-manager.enable = true;
		fish = {
			enable = true;
			interactiveShellInit = ''
				${pkgs.starship}/bin/starship init fish | source

				set -x XDG_DATA_HOME $HOME/.local/share
				set -x XDG_CONFIG_HOME $HOME/.config
				set -x XDG_STATE_HOME $HOME/.local/state
				set -x XDG_CACHE_HOME $HOME/.cache

				set -x PATH $PATH $HOME/.local/bin

				set -x ANDROID_HOME "$XDG_DATA_HOME"/android
				set -x CARGO_HOME "$XDG_DATA_HOME"/cargo
				set -x CUDA_CACHE_PATH "XDG_CACHE_HOME"/nv
				set -x INPUTRC "$XDG_DATA_HOME"/readline/inputrc
				set -x LESSHISTFILE "$XDG_DATA_HOME"/less/history
				set -x NPM_CONFIG_USERCONFIG "$XDG_CONFIG_HOME"/npm/npmrc
				set -x WINEPREFIX "$XDG_DATA_HOME"/wine
			'';
			shellAliases = {
				fish_greeting = "${pkgs.nitch}/bin/nitch";
				cn = "clear;${pkgs.nitch}/bin/nitch";
				la = "${pkgs.exa}/bin/exa -la";
			};
		};
		nix-index = {
			enable = true;
			enableFishIntegration = true;
		};
	};
}
