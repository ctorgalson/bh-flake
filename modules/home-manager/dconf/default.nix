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
      "org/gnome/shell/clocks" = {
        world-clocks = [
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
        # <(uint32 2, <('Vancouver', 'CYVR', true, [(0.85841109795478021, -2.1496638678574467)], [(0.85957465660720722, -2.1490820798045869)])>)>
      };
    };
  };
}

# Manually added
#
# /org/gnome/clocks/world-clocks
#   [{'location': <(uint32 2, <('Portland', 'KPDX', true, [(0.79571014457688405, -2.1397785149603687)], [(0.7945341242735976, -2.1411037260081156)])>)>}]
# 
# /org/gnome/shell/world-clocks/locations
#  [<(uint32 2, <('Portland', 'KPDX', true, [(0.79571014457688405, -2.1397785149603687)], [(0.7945341242735976, -2.1411037260081156)])>)>]
#
# From dconf in nix
#
# /org/gnome/shell/world-clocks/locations
#   [{'location': <(uint32 2, <('Vancouver', 'CYVR', true, [(0.85841100000000004, -2.149664)], [(0.85957499999999998, -2.1490819999999999)])>)>}]
