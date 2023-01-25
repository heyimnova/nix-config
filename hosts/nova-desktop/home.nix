{ pkgs, ... }:

{
  home.packages = with pkgs; [
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
  ];
}

