{ pkgs, ... }:

{
	home.packages = with pkgs; [
		#bavarder
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
			(callPackage ../../pkgs/python-modules/flet {})
		]))
		quickemu
		quickgui
		sbctl
		woeusb
		gnome.zenity
	];
}
