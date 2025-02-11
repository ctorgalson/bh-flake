  vim.o.colorcolumn = '80';

  Config = function()

    -- @see https://github.com/akinsho/bufferline.nvim
    require('bufferline').setup({
      options = {
        mode = 'tabs'
      }
    })

    require("lspconfig").setup({
      event = { "BufReadPre", "BufNewFile" };
      config = function()
        require("nvchad.configs.lspconfig").defaults()
        require("configs.lspconfig")
      end,
    })

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
    })
  end

