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
          config = toLuaFromString "require(\"Comment\").setup()";
        }
        gitsigns-nvim
        {
          plugin = lualine-nvim;
        }
        {
          plugin = neo-tree-nvim;
          config = toLuaFromFile ./plugins/neo-tree-nvim.lua;
        }
        {
          plugin = nvim-lspconfig;
        }
        {
          plugin = catppuccin-nvim;
          config = "colorscheme catppuccin-mocha";
        }
        nvim-treesitter.withAllGrammars
        nvim-web-devicons
        telescope-nvim
        {
          plugin = which-key-nvim;
        }
      ];

      viAlias = true;
      vimAlias = true;
      vimdiffAlias = true;
    };
  };
}
