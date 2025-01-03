require('nvim-treesitter.configs').setup({
  highlight = {
    enable = true,
    use_languagetree = true,
  };

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
