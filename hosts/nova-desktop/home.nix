{ pkgs, ... }:

{
  home.packages = with pkgs; [
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
