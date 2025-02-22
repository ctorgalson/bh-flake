{ inputs, lib, pkgs, ... }:

{
  services.fprintd = {
    enable = true;
    tod.enable = true;
  };
}
