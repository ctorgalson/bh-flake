{ config, lib, stylix, ... }:

{
  stylix.fonts.sizes = {
    applications = lib.mkForce 11;
    desktop = lib.mkForce 11;
    popups = lib.mkForce 9;
    terminal = lib.mkForce 12;
  };
}
