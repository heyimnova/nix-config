{ pkgs, ... }:

{
  home.packages = with pkgs; [
		birdtray
		(callPackage ../../packages/clamtk {})
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
		#(callPackage ../../packages/mysterium-vpn-desktop {})
		polychromatic
		prismlauncher
		protonup-qt
		quickemu
		quickgui
		gnome.zenity
  ];
}
