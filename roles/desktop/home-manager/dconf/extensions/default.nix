{ ... }:

{
  imports = [
    ./appindicator.nix
    ./solaar.nix
    ./tactile.nix
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
