{ config, pkgs, programs, ... }:

{
  # Refer to https://nixos.wiki/wiki/Neovim
  config = {
    programs.neovim =
    let
      toLuaFromString = str: "lua << EOF\n${str}\nEOF\n";
      toLuaFromFile = file: "lua << EOF\n${builtins.readFile file}\nEOF\n";
    in
    {
      enable = true;
      defaultEditor = true;

      extraConfig = ''
      colorscheme catppuccin-mocha
      '';

      extraLuaConfig = ''
        ${builtins.readFile ./options.lua}
      '';

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
          # @see https://github.com/neovim/nvim-lspconfig
          plugin = nvim-lspconfig;
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
          plugin = which-key-nvim;
          config = toLuaFromFile ./plugins/which-key-nvim.lua;
        }
      ];

      viAlias = true;
      vimAlias = true;
      vimdiffAlias = true;
    };
  };
}
