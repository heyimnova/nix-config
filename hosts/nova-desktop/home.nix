{ pkgs, ... }:

{
	home.packages = with pkgs; [
		#bavarder
		birdtray
		(callPackage ../../pkgs/clamtk {})
		cubiomes-viewer
		gimp
		grapejuice
		(lutris.override {
			extraLibraries = pkgs: [
				libgpg-error
				jansson
			];
		})
		heroic
		imaginer
		polychromatic
		prismlauncher
		protonup-qt
		(python3.withPackages(ps: with ps; [
			(callPackage ../../pkgs/python-modules/flet {})
		]))
		quickemu
		quickgui
		gnome.zenity
	];
}
