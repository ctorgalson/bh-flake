{ config, lib, stylix, ... }:

{
  stylix.fonts.sizes = {
    applications = lib.mkForce 14;
    desktop = lib.mkForce 14;
    popups = 12;
    terminal = lib.mkForce 15;
  };
}
