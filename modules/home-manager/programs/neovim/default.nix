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
          plugin = comment-nvim;
          config = toLuaFromFile ./plugins/comment-nvim.lua;
        }
        { plugin = gitsigns-nvim; }
        { plugin = lualine-nvim; }
        {
          plugin = neo-tree-nvim;
          config = toLuaFromFile ./plugins/neo-tree-nvim.lua;
        }
        # {
        #   plugin = nvim-lspconfig;
        # }
        { plugin = catppuccin-nvim; }
        {
          plugin = nvim-treesitter.withAllGrammars;
          config = toLuaFromFile ./plugins/nvim-treesitter.lua;
        }
        { plugin = nvim-web-devicons; }
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
