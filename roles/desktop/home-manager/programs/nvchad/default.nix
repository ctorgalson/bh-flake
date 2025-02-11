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
    programs.nvchad = 
    let
      toLuaFromString = str: "lua << EOF\n${str}\nEOF\n";
      toLuaFromFile = file: "lua << EOF\n${builtins.readFile file}\nEOF\n";
    in 
    {
      enable = true;

      chadrcConfig= ''
      ${builtins.readFile ./chadrc.lua}
      '';

      extraConfig = ''
      ${builtins.readFile ./options.lua}
      '';

      extraPackages = with pkgs; [ ];

      backup = false;
    };
  };
}

