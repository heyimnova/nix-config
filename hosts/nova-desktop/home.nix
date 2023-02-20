{ pkgs, ... }:

{
  home.packages = with pkgs; [
		birdtray
		brave
		cubiomes-viewer
		gimp
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
		master.quickgui
		gnome.zenity
  ];
}
