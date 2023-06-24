{ pkgs, ... }:

{
	imports = [
		../home.nix
		../../modules/apps/desktop/home.nix
		../../modules/apps/entertainment/home.nix
		../../modules/apps/gaming/home.nix
		../../modules/apps/social/home.nix
		../../modules/desktops/gnome/home.nix
	];

	home = {
		packages = with pkgs; [
			birdtray
			(callPackage ../../pkgs/clamtk {})
			cubiomes-viewer
			gimp
			librewolf
			polychromatic
			(python3.withPackages(ps: with ps; [
				flet
			]))
			quickemu
			quickgui
			sbctl
			sqlitebrowser
			woeusb
			gnome.zenity
		];

		stateVersion = "22.11";
	};
}
