{ config, pkgs, programs, ... }:

{
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
        ${builtins.readFile ./neovim/options.lua}
      '';

      plugins = with pkgs.vimPlugins; [
        {
          plugin = bufferline-nvim;
          config = toLuaFromFile ./neovim/plugins/bufferline.lua;
        }
        {
          plugin = comment-nvim;
          config = toLuaFromString "require(\"Comment\").setup()";
        }
        gitsigns-nvim
        {
          plugin = lualine-nvim;
        }
        neo-tree-nvim
        {
          plugin = nvim-lspconfig;
        }
        {
          plugin = nvim-solarized-lua;
          config = "colorscheme solarized";
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
