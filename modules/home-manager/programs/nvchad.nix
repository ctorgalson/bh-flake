{ inputs, config, pkgs, programs, ... }:

{
  imports = [
    inputs.nvchad4nix.homeManagerModule
  ];
  config = {
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
      vim.o.colorcolumn = '80';
      require("nvim-treesitter.configs").setup({
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
        };
      })
      '';
      extraPackages = with pkgs; [ ];
      backup = false;
    };
  };
}
