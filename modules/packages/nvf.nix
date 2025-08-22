# NVF Neovim configuration
{
  languageSupport,
  imageSupport,
  ...
}: {
  vim = {
    viAlias = true;
    vimAlias = true;
    autopairs.nvim-autopairs.enable = true;
    # Bug with nvim-cmp?
    # snippets.luasnip.enable = true;
    filetree.neo-tree.enable = true;
    tabline.nvimBufferline.enable = true;
    telescope.enable = true;
    minimap.codewindow.enable = true;
    dashboard.alpha.enable = true;
    notify.nvim-notify.enable = true;
    notes.todo-comments.enable = true;
    terminal.toggleterm.enable = true;
    comments.comment-nvim.enable = true;
    statusline.lualine.enable = true;
    autocomplete.nvim-cmp.enable = true;

    lsp = {
      formatOnSave = true;
    };

    languages = {
      enableLSP = true;
      enableFormat = true;
      enableTreesitter = true;

      clang.enable = languageSupport;
      markdown.enable = true;
      nix.enable = true;
      python.enable = languageSupport;

      rust = {
        enable = languageSupport;
        crates.enable = languageSupport;
      };
    };

    visuals = {
      nvim-scrollbar.enable = true;
      nvim-web-devicons.enable = true;
      cinnamon-nvim.enable = true;
      fidget-nvim.enable = true;
      indent-blankline.enable = true;
      cellular-automaton.enable = true;
    };

    binds = {
      whichKey.enable = true;
      cheatsheet.enable = true;
    };

    git = {
      enable = true;
      gitsigns.enable = true;
    };

    utility = {
      surround.enable = true;
      diffview-nvim.enable = true;
      motion.leap.enable = true;

      images.image-nvim = {
        enable = imageSupport;
        setupOpts.backend = "kitty";
      };
    };

    ui = {
      borders.enable = true;
      colorizer.enable = true;
      fastaction.enable = true;
    };

    theme = {
      enable = true;
      name = "rose-pine";
      style = "main";
      transparent = true;
    };
  };
}
