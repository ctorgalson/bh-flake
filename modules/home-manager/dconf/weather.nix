{ config, lib, pkgs, programs, ... }:

{
  config = {
    dconf.settings = {
      "org/gnome/Weather" = {
        "locations" = [
          # Toronto
          (lib.hm.gvariant.mkVariant (lib.hm.gvariant.mkTuple [
            (lib.hm.gvariant.mkUint32 2)
            (lib.hm.gvariant.mkVariant (lib.hm.gvariant.mkTuple [
              "Toronto"
              "CYTZ"
              true
              [(lib.hm.gvariant.mkTuple [(0.76154532446909495) (-1.3857914260834978)])]
              [(lib.hm.gvariant.mkTuple [(0.76212711252195475) (-1.3860823201099277)])]
            ]))
          ]))

          # Lyon
          # (lib.hm.gvariant.mkVariant (lib.hm.gvariant.mkTuple [
          #   (lib.hm.gvariant.mkUint32 2)
          #   (lib.hm.gvariant.mkVariant (lib.hm.gvariant.mkTuple [
          #     "Lyon"
          #     "LFLY"
          #     true
          #     [(lib.hm.gvariant.mkTuple [(0.7979063621878385) (0.086393797973719322)])]
          #     [(lib.hm.gvariant.mkTuple [(0.79848813278740571) (0.084648468721724976)])]
          #   ]))
          # ]))
        ];
      };
      "org/gnome/shell/weather" = {
        "locations" = [
          # Toronto
          (lib.hm.gvariant.mkVariant (lib.hm.gvariant.mkTuple [
            (lib.hm.gvariant.mkUint32 2)
            (lib.hm.gvariant.mkVariant (lib.hm.gvariant.mkTuple [
              "Toronto"
              "CYTZ"
              true
              [(lib.hm.gvariant.mkTuple [(0.76154532446909495) (-1.3857914260834978)])]
              [(lib.hm.gvariant.mkTuple [(0.76212711252195475) (-1.3860823201099277)])]
            ]))
          ]))

          # Lyon
          # (lib.hm.gvariant.mkVariant (lib.hm.gvariant.mkTuple [
          #   (lib.hm.gvariant.mkUint32 2)
          #   (lib.hm.gvariant.mkVariant (lib.hm.gvariant.mkTuple [
          #     "Lyon"
          #     "LFLY"
          #     true
          #     [(lib.hm.gvariant.mkTuple [(0.7979063621878385) (0.086393797973719322)])]
          #     [(lib.hm.gvariant.mkTuple [(0.79848813278740571) (0.084648468721724976)])]
          #   ]))
          # ]))
        ];
      };
    };
  };
}
