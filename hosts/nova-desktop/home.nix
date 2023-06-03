{ pkgs, ... }:

{
	home.packages = with pkgs; [
		birdtray
		(callPackage ../../pkgs/clamtk {})
		cubiomes-viewer
		gimp
		grapejuice
		heroic
		imaginer
		(lutris.override {
			extraLibraries = pkgs: [
				libgpg-error
				jansson
			];
		})
		polychromatic
		prismlauncher
		protonup-qt
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
}
