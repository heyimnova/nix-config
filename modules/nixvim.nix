# Nixvim Neovim configuration
{ pkgs, ... }:

{
  programs.nixvim = {
    enable = true;
    viAlias = true;
    vimAlias = true;

    extraPackages = with pkgs; [
      # Used by telescope
      fd
      ripgrep
    ];

    clipboard.providers = {
      wl-copy.enable = true;
      xclip.enable = true;
    };

    colorschemes.catppuccin = {
      enable = true;
      flavour = "macchiato";
    };

    globals = {
      mapleader = " ";
      maplocalleader = " ";
    };

    keymaps = [
      {
        action = "<cmd>nohlsearch<CR>";
        key = "<Esc>";
        mode = "n";
        options.desc = "Clear search result highlighting";
      }
    ];

    options = {
      # Sync Neovim clipboard with system clipboard
      clipboard = "unnamedplus";

      # Highlight results on search
      hlsearch = true;

      # Case insensitive searching (unless there is a capital in search or \C)
      ignorecase = true;
      smartcase = true;

      # Preview substitutions in a split
      inccommand = "split";

      # Set how Neovim displays certain whitespace
      list = true;

      listchars = {
        tab = "» ";
        trail = "·";
        nbsp = "␣";
      };

      # Enable mouse in all modes
      mouse = "a";

      # Show line number column with relative line numbers
      number = true;
      relativenumber = true;

      # Minimum number of lines to keep on screen around the cursor
      scrolloff = 10;

      # Set tab width to 2 spaces
      shiftwidth = 2;

      # Don't show mode as it is shown in the status bar
      showmode = false;

      # Always keep the sign column on
      signcolumn = "yes";

      # Set how new splits will be opened
      splitbelow = true;
      splitright = true;

      # Decrease update time (values from kickstart.nvim)
      timeoutlen = 300;
      updatetime = 250;

      # Save undo history
      undofile = true;
    };

    plugins = {
      comment-nvim.enable = true;
      gitsigns.enable = true;
      nix.enable = true;
      treesitter.enable = true;

      # Notification window
      fidget.enable = true;

      # Status bar
      lightline.enable = true;

      # Discord status
      neocord.enable = true;

      # Autocompletions
      nvim-cmp.enable = true;

      # Keybind hints
      which-key.enable = true;

      lsp = {
        enable = true;

        servers = {
          nixd.enable = true;
          pylsp.enable = true;
        };
      };

      # Filesystem tree buffer
      nvim-tree = {
        enable = true;
        disableNetrw = true;
        hijackCursor = true;
      };

      telescope = {
        enable = true;

        extensions = {
          fzf-native.enable = true;
          ui-select.enable = true;
        };
      };
    };
  };
}

