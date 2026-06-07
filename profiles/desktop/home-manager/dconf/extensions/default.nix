{ ... }:

{
  imports = [
    ./appindicator.nix
    ./solaar.nix
    ./tactile.nix
    ./tiling-shell.nix
  ];

  config = {
    dconf.settings = {
      "org/gnome/shell" = {
        disable-user-extensions = false;
        disabled-extensions = [ ];
      };
    };
  };
}
