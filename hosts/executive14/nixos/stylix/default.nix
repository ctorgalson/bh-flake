{ config, lib, stylix, ... }:

{
  stylix.fonts.sizes = {
    applications = lib.mkForce 13;
    desktop = lib.mkForce 13;
    popups = lib.mkForce 11;
    terminal = lib.mkForce 14;
  };
}
