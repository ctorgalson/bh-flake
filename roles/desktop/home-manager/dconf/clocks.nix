{ config, lib, pkgs, programs, ... }:

let
  # @see https://discourse.nixos.org/t/time-zones-in-gnome-clocks-get-set-correctly-but-then-disappear-during-use/36797
  # @see https://discourse.nixos.org/t/write-key-value-using-lib-hm-gvariant-for-home-manager/31234/4
  # @see https://docs.gtk.org/glib/gvariant-format-strings.html
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

  mkClockEntry = location:
    ([
      (lib.hm.gvariant.mkDictionaryEntry ["location" location])
    ]);

  lyon = mkLocation {
    name = "Lyon";
    airport = "LFLY";
    lat = 0.7979063621878385;
    lon = 0.086393797973719322;
  };

  dublin = mkLocation {
    name = "Dublin";
    airport = "EIDW";
    lat = 0.93258759116453926;
    lon = -0.1090830782496456;
  };

  toronto = mkLocation {
    name = "Toronto";
    airport = "CYTZ";
    lat = 0.76154532446909495;
    lon = -1.3857914260834978;
  };

  winnipeg = mkLocation {
    name = "Winnipeg";
    airport = "CYWG";
    lat = 0.87091929674517032;
    lon = -1.6970418035380554;
  };

  vancouver = mkLocation {
    name = "Vancouver";
    airport = "CYVR";
    lat = 0.85841109795478021;
    lon = -2.1496638678574467;
  };

  victoria = mkLocation {
    name = "Victoria";
    airport = "CYYJ";
    lat = 0.84476620253905869;
    lon = -2.1532672843410971;
  };

  athens = mkLocation {
    name = "Athens";
    airport = "LGAV";
    lat = 0.66223166;
    lon = 0.41783446;
  };

  locations = [
    lyon
    dublin
    toronto
    winnipeg
    victoria
    athens
  ];
in
{
  config = {
    dconf.settings = {
      "org/gnome/clocks" = {
        world-clocks = map mkClockEntry locations;
      };
      "org/gnome/shell/world-clocks" = {
        locations = locations;
      };
    };
  };
}
