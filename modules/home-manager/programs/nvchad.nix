{ inputs, config, pkgs, home, programs, ... }:

{
  imports = [
    inputs.nvchad4nix.homeManagerModule
  ];
  config = {
    home.packages = with pkgs; [
      vimPlugins.nvim-lspconfig
      vscode-langservers-extracted
    ];
    programs.nvchad = {
      enable = true;
      chadrcConfig= ''
      ---@type ChadrcConfig
      local M = {}

      M.base46 = {
        theme = "catppuccin",
      }

      return M
      '';

      extraConfig = ''
      config = function()
        vim.o.colorcolumn = '80';

        require("lspconfig").setup({
          event = { "BufReadPre", "BufNewFile" };
          config = function()
            require("nvchad.configs.lspconfig").defaults()
            require("configs.lspconfig")
          end,
        });

        require("nvim-treesitter.configs").setup({
          highlight = {
            enable = true,
            use_languagetree = true,
          },
          indent = {
            enable = true,
          };
          ensure_installed = {
            "bash",
            "css",
            "csv",
            "diff",
            "gitignore",
            "graphql",
            "html",
            "http",
            "javascript",
            "jq",
            "json",
            "lua",
            "luadoc",
            "markdown",
            "nginx",
            "nix",
            "php",
            "phpdoc",
            "python",
            "sql",
            "ssh_config",
            "toml",
            "tmux",
            "typescript",
            "twig",
            "vim",
            "vimdoc",
            "yaml",
          },
        });
      end
      '';
      extraPackages = with pkgs; [ ];
      backup = false;
    };
  };
}
