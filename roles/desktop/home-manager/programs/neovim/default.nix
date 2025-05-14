# TODO Steal nvim-ide plugin config where useful.
#
# @see https://github.com/ldelossa/nvim-ide
# 
# TODO Maybe do this: https://primamateria.github.io/blog/neovim-nix/

{ config, home, pkgs, programs, ... }:

{
  # Refer to https://nixos.wiki/wiki/Neovim
  config = {
    home.packages = with pkgs; [
      # LSP dependencies.
      htmx-lsp
      phpactor
      pylyzer
      typescript
      typescript-language-server
      vscode-langservers-extracted
      # Utilities dependencies.
      nodePackages.prettier
    ];

    programs.neovim = 
    let
      toLuaFromString = str: "lua << EOF\n${str}\nEOF\n";
      toLuaFromFile = file: "lua << EOF\n${builtins.readFile file}\nEOF\n";
    in
    {
      enable = true;
      defaultEditor = true;

      # Expects Vim config, file uses that, so use builtins.readFile.
      extraConfig = ''
      ${builtins.readFile ./config.vim}
      '';

      # Expects lua, file is lua, so use builtins.readFile.
      extraLuaConfig = ''
      ${builtins.readFile ./options.lua}
      '';

      # Plugin configs expect Vim config, so lua config needs to be marked-up
      # using our toLuaFromFile and toLuaFromString functions.
      plugins = with pkgs.vimPlugins; [
        # UI
        #
        # File browser.
        {
          plugin = neo-tree-nvim;
          config = toLuaFromFile ./plugins/neo-tree-nvim.lua;
        }
        # File type icons.
        {
          # @see https://github.com/nvim-tree/nvim-web-devicons
          plugin = nvim-web-devicons;
        }
        # Git status indicators.
        {
          # @see https://github.com/lewis6991/gitsigns.nvim
          plugin = gitsigns-nvim;
          config = toLuaFromFile ./plugins/gitsigns-nvim.lua;
        }
        # Better folds.
        {
          plugin = nvim-ufo;
          config = toLuaFromFile ./plugins/nvim-ufo.lua;
        }
        {
          # (nvim-ufo dependency).
          plugin = promise-async;
        }
        # Tabs.
        {
          plugin = bufferline-nvim;
          config = toLuaFromFile ./plugins/bufferline-nvim.lua;
        }
        # Status line.
        {
          plugin = lualine-nvim;
          config = toLuaFromFile ./plugins/lualine-nvim.lua;
        }
        # Colourize hex, other text colours.
        {
          plugin = nvim-colorizer-lua;
          config = toLuaFromFile ./plugins/nvim-colorizer-lua.lua;
        }
        # Colorscheme.
        {
          # @see https://github.com/anachronic/catppuccin-nvim?tab=readme-ov-file
          plugin = catppuccin-nvim;
        }
        # In-editor terminal.
        {
          plugin = toggleterm-nvim;
          config = toLuaFromFile ./plugins/toggleterm-nvim.lua;
        }

        # UX
        #
        # Comments.
        {
          plugin = comment-nvim;
          config = toLuaFromFile ./plugins/comment-nvim.lua;
        }
        # In-file navigation.
        {
          plugin = leap-nvim;
          config = toLuaFromFile ./plugins/leap-nvim.lua;
        }
        # Help with keyboard nav.
        {
          plugin = which-key-nvim;
          config = toLuaFromFile ./plugins/which-key-nvim.lua;
        }
        {
          # (which key dependency).
          plugin = telescope-nvim;
          config = toLuaFromFile ./plugins/nvim-telescope.lua;
        }

        # LSP noodling and syntax.
        #
        # @see https://nathan-long.com/blog/modern-javascript-tooling-in-neovim/
        {
          plugin = nvim-treesitter.withAllGrammars;
          config = toLuaFromFile ./plugins/nvim-treesitter.lua;
        }
        {
          plugin = nvim-lspconfig;
          config = toLuaFromFile ./plugins/nvim-lspconfig.lua;
        }
        {
          plugin = blink-cmp;
          config = toLuaFromFile ./plugins/blink-cmp.lua;
        }
        {
          plugin = friendly-snippets;
        }

        # Utilities.
        {
          plugin = vim-prettier;
        }
      ];

      # Alias everything.
      viAlias = true;
      vimAlias = true;
      vimdiffAlias = true;
    };
  };
}
