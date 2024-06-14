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

      # Some keybinds I like from Helix
      {
        action = "$";
        key = "gl";
        options.desc = "Go to end of line";

        mode = [
          "n"
          "v"
        ];
      }

      {
        action = "0";
        key = "gh";
        options.desc = "Go to beginning of line";

        mode = [
          "n"
          "v"
        ];
      }
    ];

    opts = {
      # Sync Neovim clipboard with system clipboard
      clipboard = "unnamedplus";

      # Don't fold code on buffer open
      foldenable = false;

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
      gitsigns.enable = true;

      # Autocompletions
      # cmp.enable = true;

      # Notification window
      fidget.enable = true;

      # Status bar
      lightline.enable = true;

      # Keybind hints
      which-key.enable = true;

      comment = {
        enable = true;
        # Toggle commenting line/selection with Ctrl c
        settings = {
          opleader.line = "<C-c>";
          toggler.line = "<C-c>";
        };
      };

      lsp = {
        enable = true;

        servers = {
          nixd.enable = true;
          pylsp.enable = true;
        };
      };

      # Filesystem tree buffer
      # nvim-tree = {
      #   enable = true;
      #   disableNetrw = true;
      #   folding = true;
      #   hijackCursor = true;
      #   indent = true;
      # };

      telescope = {
        enable = true;

        extensions = {
          fzf-native.enable = true;
          ui-select.enable = true;
        };

        keymaps = {
          "<C-p>" = {
            action = "git_files";
            options.desc = "Telescope Git Files";
          };

          "<leader>ff" = {
            action = "find_files";
            options.desc = "Telescope Find Files";
          };
        };
      };

      treesitter = {
        enable = true;
        folding = true;
        nixvimInjections = true;

        grammarPackages = with pkgs.tree-sitter-grammars; [
          tree-sitter-bash
          tree-sitter-comment
          tree-sitter-dockerfile
          tree-sitter-fish
          tree-sitter-javascript
          tree-sitter-json
          tree-sitter-lua
          tree-sitter-markdown
          tree-sitter-markdown-inline
          tree-sitter-nix
          tree-sitter-nu
          tree-sitter-python
          tree-sitter-regex
          tree-sitter-sql
          tree-sitter-toml
          tree-sitter-yaml
        ];
      };
    };
  };
}

