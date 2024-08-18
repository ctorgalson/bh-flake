{ config, lib, pkgs, programs, ... }:

{
  config = {
    dconf.settings = {
      # @see https://discourse.nixos.org/t/time-zones-in-gnome-clocks-get-set-correctly-but-then-disappear-during-use/36797
      # @see https://discourse.nixos.org/t/write-key-value-using-lib-hm-gvariant-for-home-manager/31234/4
      # @see https://docs.gtk.org/glib/gvariant-format-strings.html
      "org/gnome/clocks" = {
        world-clocks = [
          # Lyon
          ([
            (lib.hm.gvariant.mkDictionaryEntry ["location" (lib.hm.gvariant.mkVariant (lib.hm.gvariant.mkTuple [
              (lib.hm.gvariant.mkUint32 2)
              (lib.hm.gvariant.mkVariant (lib.hm.gvariant.mkTuple [
                "Lyon"
                "LFLY"
                true
                [(lib.hm.gvariant.mkTuple [(0.7979063621878385) (0.086393797973719322)])]
                [(lib.hm.gvariant.mkTuple [(0.79848813278740571) (0.084648468721724976)])]
              ]))
            ]))])
          ])

          # Dublin
          ([
            (lib.hm.gvariant.mkDictionaryEntry ["location" (lib.hm.gvariant.mkVariant (lib.hm.gvariant.mkTuple [
              (lib.hm.gvariant.mkUint32 2)
              (lib.hm.gvariant.mkVariant (lib.hm.gvariant.mkTuple [
                "Dublin"
                "EIDW"
                true
                [(lib.hm.gvariant.mkTuple [(0.93258759116453926) (-0.1090830782496456)])]
                [(lib.hm.gvariant.mkTuple [(0.93083742735051689) (-0.10906368764165594)])]
              ]))
            ]))])
          ])

          # Toronto
          ([
            (lib.hm.gvariant.mkDictionaryEntry ["location" (lib.hm.gvariant.mkVariant (lib.hm.gvariant.mkTuple [
              (lib.hm.gvariant.mkUint32 2)
              (lib.hm.gvariant.mkVariant (lib.hm.gvariant.mkTuple [
                "Toronto"
                "CYTZ"
                true
                [(lib.hm.gvariant.mkTuple [(0.76154532446909495) (-1.3857914260834978)])]
                [(lib.hm.gvariant.mkTuple [(0.76212711252195475) (-1.3860823201099277)])]
              ]))
            ]))])
          ])

          # Winnipeg
          ([
            (lib.hm.gvariant.mkDictionaryEntry ["location" (lib.hm.gvariant.mkVariant (lib.hm.gvariant.mkTuple [
              (lib.hm.gvariant.mkUint32 2)
              (lib.hm.gvariant.mkVariant (lib.hm.gvariant.mkTuple [
                "Winnipeg"
                "CYWG"
                true
                [(lib.hm.gvariant.mkTuple [(0.87091929674517032) (-1.6970418035380554)])]
                [(lib.hm.gvariant.mkTuple [(0.87062840271874053) (-1.695878262338921)])]
              ]))
            ]))])
          ])

          # Vancouver
          ([
            (lib.hm.gvariant.mkDictionaryEntry ["location" (lib.hm.gvariant.mkVariant (lib.hm.gvariant.mkTuple [
              (lib.hm.gvariant.mkUint32 2)
              (lib.hm.gvariant.mkVariant (lib.hm.gvariant.mkTuple [
                "Vancouver"
                "CYVR"
                true
                [(lib.hm.gvariant.mkTuple [(0.85841109795478021) (-2.1496638678574467)])]
                [(lib.hm.gvariant.mkTuple [(0.85957465660720722) (-2.1490820798045869)])]
              ]))
            ]))])
          ])
        ];
      };
      "org/gnome/shell/world-clocks" = {
        locations = [
          # Lyon
          (lib.hm.gvariant.mkVariant (lib.hm.gvariant.mkTuple [
            (lib.hm.gvariant.mkUint32 2)
            (lib.hm.gvariant.mkVariant (lib.hm.gvariant.mkTuple [
              "Lyon"
              "LFLY"
              true
              [(lib.hm.gvariant.mkTuple [(0.7979063621878385) (0.086393797973719322)])]
              [(lib.hm.gvariant.mkTuple [(0.79848813278740571) (0.084648468721724976)])]
            ]))
          ]))

          # Dublin
          (lib.hm.gvariant.mkVariant (lib.hm.gvariant.mkTuple [
            (lib.hm.gvariant.mkUint32 2)
            (lib.hm.gvariant.mkVariant (lib.hm.gvariant.mkTuple [
              "Dublin"
              "EIDW"
              true
              [(lib.hm.gvariant.mkTuple [(0.93258759116453926) (-0.1090830782496456)])]
              [(lib.hm.gvariant.mkTuple [(0.93083742735051689) (-0.10906368764165594)])]
            ]))
          ]))

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

          # Winnipeg
          (lib.hm.gvariant.mkVariant (lib.hm.gvariant.mkTuple [
            (lib.hm.gvariant.mkUint32 2)
            (lib.hm.gvariant.mkVariant (lib.hm.gvariant.mkTuple [
              "Winnipeg"
              "CYWG"
              true
              [(lib.hm.gvariant.mkTuple [(0.87091929674517032) (-1.6970418035380554)])]
              [(lib.hm.gvariant.mkTuple [(0.87062840271874053) (-1.695878262338921)])]
            ]))
          ]))

          # Vancouver
          (lib.hm.gvariant.mkVariant (lib.hm.gvariant.mkTuple [
            (lib.hm.gvariant.mkUint32 2)
            (lib.hm.gvariant.mkVariant (lib.hm.gvariant.mkTuple [
              "Vancouver"
              "CYVR"
              true
              [(lib.hm.gvariant.mkTuple [(0.85841109795478021) (-2.1496638678574467)])]
              [(lib.hm.gvariant.mkTuple [(0.85957465660720722) (-2.1490820798045869)])]
            ]))
          ]))
        ];
      };
    };
  };
}
