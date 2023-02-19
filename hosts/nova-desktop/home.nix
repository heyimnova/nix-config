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
		master.protonup-qt
		quickemu
		(callPackage ../../packages/quickgui {})
		gnome.zenity
  ];
}
