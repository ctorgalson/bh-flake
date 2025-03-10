{ config, lib, stylix, ... }:

{
  stylix.fonts.sizes = {
    applications = lib.mkForce 15;
    desktop = lib.mkForce 15;
    popups = 12;
    terminal = lib.mkForce 16;
  };
}
