{ inputs, lib, pkgs, ... }:

{
  environment = {
    sessionVariables = {
      # @see roles/desktop/home-manager/programs/zsh.nix
    };

    systemPackages = with pkgs; [
      bws
      docker
      micro
      mkcert
      steam
      zoom-us
    ];
  };
}
