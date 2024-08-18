{ config, lib, pkgs, programs, ... }:

{
  config = {
    dconf.settings = {
      "com/raggesilver/BlackBox" = {
        font = "Inconsolata Nerd Font Mono 14";
        theme-bold-is-bright = true;
        theme-dark = "Solarized Dark";
      };
    };
  };
}
