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
		#prismlauncher
		protonup-qt
		(python3.withPackages(ps: with ps; [
			(callPackage ../../packages/python-modules/flet {})
		]))
		quickemu
		quickgui
		gnome.zenity
  ];
}
