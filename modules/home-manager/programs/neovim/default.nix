# TODO Steal nvim-ide plugin config where useful.
#
# @see https://github.com/ldelossa/nvim-ide

{ config, home, pkgs, programs, ... }:

{
  # Refer to https://nixos.wiki/wiki/Neovim
  config = {
    home.packages = with pkgs; [
      htmx-lsp
      nodePackages.prettier
      phpactor
      pylyzer
      typescript
      typescript-language-server
      vscode-langservers-extracted
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
        {
          plugin = bufferline-nvim;
	        config = toLuaFromFile ./plugins/bufferline-nvim.lua;
        }
        {
          # @see https://github.com/anachronic/catppuccin-nvim?tab=readme-ov-file
          plugin = catppuccin-nvim;
        }
        {
          plugin = comment-nvim;
	        config = toLuaFromFile ./plugins/comment-nvim.lua;
        }
        {
          # @see https://github.com/lewis6991/gitsigns.nvim
          plugin = gitsigns-nvim;
          config = toLuaFromFile ./plugins/gitsigns-nvim.lua;
        }
        {
          plugin = lualine-nvim;
	        config = toLuaFromFile ./plugins/lualine-nvim.lua;
        }
        {
          plugin = neo-tree-nvim;
	        config = toLuaFromFile ./plugins/neo-tree-nvim.lua;
        }
        {
          plugin = nvim-colorizer-lua;
          config = toLuaFromFile ./plugins/nvim-colorizer-lua.lua;
        }
        {
          plugin = nvim-treesitter.withAllGrammars;
	        config = toLuaFromFile ./plugins/nvim-treesitter.lua;
        }
        {
          # @see https://github.com/nvim-tree/nvim-web-devicons
          plugin = nvim-web-devicons;
        }
        {
          plugin = telescope-nvim;
	        config = toLuaFromFile ./plugins/nvim-telescope.lua;
        }
        {
            plugin = toggleterm-nvim;
            config = toLuaFromFile ./plugins/toggleterm-nvim.lua;
        }
        { plugin = vim-prettier; }
        {
          plugin = which-key-nvim;
	        config = toLuaFromFile ./plugins/which-key-nvim.lua;
        }
        # LSP noodling.
        #
        # @see https://nathan-long.com/blog/modern-javascript-tooling-in-neovim/
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
      ];

      viAlias = true;
      vimAlias = true;
      vimdiffAlias = true;
    };
  };
}
