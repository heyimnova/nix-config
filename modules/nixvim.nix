# Nixvim Neovim configuration
{ pkgs, ... }:

{
  programs.nixvim = {
    enable = true;
    enableMan = false; # Fixes a build error
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

      # Two keybinds I like from Helix
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

      {
        action = "<cmd>NvimTreeToggle<CR>";
        key = "<C-n>";
        mode = "n";
        options.desc = "Open file tree";
      }

      {
        action = " ";
        key = " ";
        mode = "t";

        options = {
          desc = "Clear space keymap in terminal mode";
          nowait = true;
          silent = true;
        };
      }
    ];

    opts = {
      # Sync Neovim clipboard with system clipboard
      clipboard = "unnamedplus";

      # Options for code suggestions
      completeopt = [
        "menuone" # Show popup when there is only one selection
        "noinsert" # Only insert text when selection is confirmed
        "noselect" # Force a selection from the suggestions
        "preview"
      ];

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
      # Tabs for open buffers
      bufferline.enable = true;

      # Notification window
      fidget.enable = true;

      # Show git changes
      gitsigns.enable = true;

      # Status bar
      lualine.enable = true;

      # Snippets
      luasnip.enable = true;
      friendly-snippets.enable = true;

      # Automatically close parentheses
      nvim-autopairs.enable = true;

      # Keybind hints
      which-key.enable = true;

      # Autocompletions
      cmp = {
        enable = true;

        settings = {
          mapping = {
            "<C-Space>" = "cmp.mapping.complete()";
            "<C-d>" = "cmp.mapping.scroll_docs(-4)";
            "<C-e>" = "cmp.mapping.close()";
            "<C-f>" = "cmp.mapping.scroll_docs(4)";
            "<CR>" = "cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Insert, select = true })";
            "<Tab>" = "cmp.mapping(cmp.mapping.select_next_item(), { 'i', 's' })";
            "<S-Tab>" = "cmp.mapping(cmp.mapping.select_prev_item(), { 'i', 's' })";
          };

          sources = [
            { name = "async_path"; }
            { name = "nvim_lsp_signature_help"; }

            {
              name = "buffer";
              keyword_length = 2;
            }

            {
              name = "luasnip";
              keyword_length = 2;
            }

            {
              name = "nvim_lsp";
              keyword_length = 3;
            }
          ];

          window = {
            completion.scrolloff = 1;

            # Give the suggestion windows borders
            __raw = ''{
              completion = cmp.config.window.bordered(),
              documentation = cmp.config.window.bordered()
            }'';
          };

          # Set a menu icon to show the suggestion source
          formatting.format = ''
            function(entry, item)
              local menu_icon = {
                nvim_lsp = 'λ',
                luasnip = '✂',
                buffer = 'b',
                path = 'p'
              }

              item.menu = menu_icon[entry.source.name]

              return item
            end
          '';

          # Define the snippet expansion function
          snippet.expand = ''
            function(args)
              require('luasnip').lsp_expand(args.body)
            end
          '';
        };
      };

      comment = {
        enable = true;
        # Toggle commenting line/selection with Ctrl c
        settings = {
          opleader.line = "<C-c>";
          toggler.line = "<C-c>";
        };
      };

      # Floating terminal buffer
      floaterm = {
        enable = true;

        keymaps = {
          new = "<leader>t";
          toggle = "<C-t>";
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
      nvim-tree = {
        enable = true;
        disableNetrw = true;
        hijackCursor = true;
        openOnSetup = true;
      };

      # Finder
      telescope = {
        enable = true;

        extensions = {
          fzf-native.enable = true;
          ui-select.enable = true;
        };

        keymaps = {
          "<leader>fg" = {
            action = "live_grep";
            options.desc = "Telescope Live Grep";
          };

          "<leader>ff" = {
            action = "find_files";
            options.desc = "Telescope Find Files";
          };
        };
      };

      # Highlighting
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

