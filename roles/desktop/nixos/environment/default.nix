{ inputs, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    bws
    docker
    micro
    mkcert
    steam
    zoom-us
  ];
}
