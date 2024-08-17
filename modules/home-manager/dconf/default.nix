{ config, pkgs, programs, ... }:

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
      "org/gnome/shell/world-clocks" = {
        locations = [
          ([
            (mkDictionaryEntry ["location" (mkVariant (mkTuple [
              (mkUint32 2)
              (mkVariant (mkTuple [
                "Vancouver"
                "CYVR"
                true
                [(mkTuple [(0.85841109795478021) (-2.1496638678574467)])]
                [(mkTuple [(0.85957465660720722) (-2.1490820798045869)])]
              ]))
            ]))])
          ])
        ];
        # <(uint32 2, <('Vancouver', 'CYVR', true, [(0.85841109795478021, -2.1496638678574467)], [(0.85957465660720722, -2.1490820798045869)])>)>
      };
    };
  };
}
