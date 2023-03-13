{ pkgs, ... }:

{
  home.packages = with pkgs; [
		birdtray
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
		quickemu
		quickgui
		gnome.zenity
  ];
}
