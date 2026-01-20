{ config, lib, pkgs, programs, ... }:

let
  mkLocation = { name, airport, lat, lon }:
    lib.hm.gvariant.mkVariant (lib.hm.gvariant.mkTuple [
      (lib.hm.gvariant.mkUint32 2)
      (lib.hm.gvariant.mkVariant (lib.hm.gvariant.mkTuple [
        name
        airport
        true
        [(lib.hm.gvariant.mkTuple [lat lon])]
        [(lib.hm.gvariant.mkTuple [lat lon])]
      ]))
    ]);

  toronto = mkLocation {
    name = "Toronto";
    airport = "CYTZ";
    lat = 0.76154532446909495;
    lon = -1.3857914260834978;
  };

  victoria = mkLocation {
    name = "Victoria";
    airport = "CYYJ";
    lat = 0.84476620253905869;
    lon = -2.1532672843410971;
  };

  # lyon = mkLocation {
  #   name = "Lyon";
  #   airport = "LFLY";
  #   lat = 0.7979063621878385;
  #   lon = 0.086393797973719322;
  # };

  locations = [
    toronto
    victoria
    # lyon
  ];
in
{
  config = {
    dconf.settings = {
      "org/gnome/Weather" = {
        "locations" = locations;
      };
      "org/gnome/shell/weather" = {
        "locations" = locations;
      };
    };
  };
}
