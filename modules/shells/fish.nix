# home-manager fish config
{ pkgs
, ...
}:

{
  programs.fish = {
    enable = true;

    interactiveShellInit = ''
      # Enable starship prompt
      ${pkgs.starship}/bin/starship init fish | source

      # Set fish vi mode cursor settings
      set fish_cursor_default underscore
      set fish_cursor_insert line blink
      set fish_cursor_replace_one underscore blink
      set fish_cursor_visual block
    '';

    shellAliases = {
      cn = "clear;${pkgs.nitch}/bin/nitch";
      # Show nitch on fish start
      fish_greeting = "${pkgs.nitch}/bin/nitch";
      la = "${pkgs.eza}/bin/eza --icons --group-directories-first -la";
      ls = "${pkgs.eza}/bin/eza --icons --group-directories-first";
      nix-gc = "sudo nix-collect-garbage -d;nix-collect-garbage -d";
      # Recommendation from xdg-ninja
      wget = "${pkgs.wget}/bin/wget --hsts-file='$XDG_DATA_HOME/wget-hsts'";
    };
  };
}
