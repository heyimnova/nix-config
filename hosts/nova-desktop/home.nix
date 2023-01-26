{ pkgs, ... }:

{
  home.packages = with pkgs; [
		birdtray
		brave
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
		uwufetch
  ];
}

