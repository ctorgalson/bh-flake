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

        {
          plugin = catppuccin-nvim;
          config = "colorscheme catppuccin-mocha";
        }

        {
          # plugin = nvim-treesitter.withAllGrammars;
          plugin = nvim-treesitter;
          config = toLuaFromFile ./plugins/neo-tree-nvim.lua;
        }
        # https://nixos.wiki/wiki/Treesitter
        # (nvim-treesitter.withPlugins (p: [
        #   p.bash
        #   p.css
        #   p.html
        #   p.javascript
        #   p.json
        #   p.lua
        #   p.markdown
        #   p.nix
        #   p.php
        #   p.python
        #   p.toml
        #   p.twig
        #   p.typescript
        #   p.yaml
        #   p.vim
        # ]))

        # {
        #   plugin = nvim-treesitter-parsers.twig;
        # }

        { plugin = nvim-web-devicons; }

        { plugin = telescope-nvim; }

        { plugin = which-key-nvim; }
      ];

      viAlias = true;
      vimAlias = true;
      vimdiffAlias = true;
    };
  };
}
