{ config, lib, pkgs, programs, ... }:

{
  config = {
    dconf.settings = {
      "org/gnome/Console" = {
        use-system-font = false;
        custom-font = "Inconsolata Nerd Font Mono 14";
      };
      "org/gnome/shell" = {
        disable-user-extensions = false;
        disabled-extensions = [ ]; 
        enabled-extensions = [
          "freon@UshakovVasilii_Github.yahoo.com"
          "tactile@lundal.io"
        ];
      };
      "org/gnome/shell/extensions/freon" = {
        show-icon-on-panel = false;
        use-drive-hddtemp = true;
        exec-method-freeipmi = "pkexec";
      };
      "org/gnome/shell/extensions/tactile" = {
        row-2 = 0;
        grid-cols = 5;
        col-4 = 1;
        layout-2-row-2 = 0;
        layout-2-col-3 = 0;
        layout-2-col-2 = 0;
        monitor-0-layout = 1;
      };
      # @see https://discourse.nixos.org/t/time-zones-in-gnome-clocks-get-set-correctly-but-then-disappear-during-use/36797
      # @see https://discourse.nixos.org/t/write-key-value-using-lib-hm-gvariant-for-home-manager/31234/4
      # @see https://docs.gtk.org/glib/gvariant-format-strings.html
      # "org/gnome/clocks" = {
      #   world-clocks = [
      #     # Lyon
      #     ([
      #       (lib.hm.gvariant.mkDictionaryEntry ["location" (lib.hm.gvariant.mkVariant (lib.hm.gvariant.mkTuple [
      #         (lib.hm.gvariant.mkUint32 2)
      #         (lib.hm.gvariant.mkVariant (lib.hm.gvariant.mkTuple [
      #           "Lyon"
      #           "LFLY"
      #           true
      #           [(lib.hm.gvariant.mkTuple [(0.7979063621878385) (0.086393797973719322)])]
      #           [(lib.hm.gvariant.mkTuple [(0.79848813278740571) (0.084648468721724976)])]
      #         ]))
      #       ]))])
      #     ])
      #     # Vancouver
      #     ([
      #       (lib.hm.gvariant.mkDictionaryEntry ["location" (lib.hm.gvariant.mkVariant (lib.hm.gvariant.mkTuple [
      #         (lib.hm.gvariant.mkUint32 2)
      #         (lib.hm.gvariant.mkVariant (lib.hm.gvariant.mkTuple [
      #           "Vancouver"
      #           "CYVR"
      #           true
      #           [(lib.hm.gvariant.mkTuple [(0.85841109795478021) (-2.1496638678574467)])]
      #           [(lib.hm.gvariant.mkTuple [(0.85957465660720722) (-2.1490820798045869)])]
      #         ]))
      #       ]))])
      #     ])
      #   ];
      # };
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

# /org/gnome/clocks/world-clocks
#   [{'location': <(uint32 2, <('Lyon', 'LFLY', true, [(0.7979063621878385, 0.086393797973719322)], [(0.79848813278740571, 0.084648468721724976)])>)>}]
# 
# /org/gnome/shell/world-clocks/locations
#   [<(uint32 2, <('Lyon', 'LFLY', true, [(0.7979063621878385, 0.086393797973719322)], [(0.79848813278740571, 0.084648468721724976)])>)>]

# /org/gnome/clocks/world-clocks
#   [{'location': <(uint32 2, <('Dublin', 'EIDW', true, [(0.93258759116453926, -0.1090830782496456)], [(0.93083742735051689, -0.10906368764165594)])>)>}]
# 
# /org/gnome/shell/world-clocks/locations
#   [<(uint32 2, <('Dublin', 'EIDW', true, [(0.93258759116453926, -0.1090830782496456)], [(0.93083742735051689, -0.10906368764165594)])>)>]

# /org/gnome/clocks/world-clocks
#  [{'location': <(uint32 2, <('Toronto', 'CYTZ', true, [(0.76154532446909495, -1.3857914260834978)], [(0.76212711252195475, -1.3860823201099277)])>)>}]
# 
# /org/gnome/shell/world-clocks/locations
#  [<(uint32 2, <('Toronto', 'CYTZ', true, [(0.76154532446909495, -1.3857914260834978)], [(0.76212711252195475, -1.3860823201099277)])>)>]

# /org/gnome/clocks/world-clocks
#   [{'location': <(uint32 2, <('Winnipeg', 'CYWG', true, [(0.87091929674517032, -1.6970418035380554)], [(0.87062840271874053, -1.695878262338921)])>)>}]
# 
# /org/gnome/shell/world-clocks/locations
#   [<(uint32 2, <('Winnipeg', 'CYWG', true, [(0.87091929674517032, -1.6970418035380554)], [(0.87062840271874053, -1.695878262338921)])>)>]
