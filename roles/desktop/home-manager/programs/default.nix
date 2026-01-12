{ config, pkgs, home, unstable-pkgs, ... }:

{
  imports = [
    ./atuin.nix 
    ./eza.nix
    ./fastfetch.nix
    ./firefox.nix
    ./floorp.nix
    ./fzf.nix
    ./git.nix
    ./kitty.nix
    #./neovim
    ./ripgrep.nix
    ./ssh.nix
    ./starship.nix
    ./zed-editor.nix
    ./zoxide.nix
    ./zsh
  ];

  config.backupFileExtension = ".bak";
}
