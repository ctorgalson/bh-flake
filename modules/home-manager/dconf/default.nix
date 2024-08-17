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
      "org/gnome/shell/world-clocks" = {
        locations = "/org/gnome/shell/world-clocks/locations
  [<(uint32 2, <('Athens', 'LGAV', true, [(0.66206155710541803, 0.41771546182621205)], [(0.66293422173141536, 0.41422480332222328)])>)>, <(uint32 2, <('Paris', 'LFPB', true, [(0.85462956287765413, 0.042760566673861078)], [(0.8528842336256599, 0.040724343395436846)])>)>, <(uint32 2, <('Dublin', 'EIDW', true, [(0.93258759116453926, -0.1090830782496456)], [(0.93083742735051689, -0.10906368764165594)])>)>, <(uint32 2, <('Toronto', 'CYTZ', true, [(0.76154532446909495, -1.3857914260834978)], [(0.76212711252195475, -1.3860823201099277)])>)>, <(uint32 2, <('Winnipeg', 'CYWG', true, [(0.87091929674517032, -1.6970418035380554)], [(0.87062840271874053, -1.695878262338921)])>)>, <(uint32 2, <('Vancouver', 'CYVR', true, [(0.85841109795478021, -2.1496638678574467)], [(0.85957465660720722, -2.1490820798045869)])>)>]";
      };
    };
  };
}
