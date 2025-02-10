{ allowedUnfreePackages, inputs, lib, pkgs, ... }:

{
  imports = [
    ./nixos
    #./home-manager
    #./overrides.nix
  ];
}
