{ config, pkgs, programs, ... }:

{
  config = {
    dconf.settings = {
      "org/gnome/Console" = {
        use-system-font = false;
        custom-font = "Inconsolata Nerd Font Mono 13";
      };
      "org/gnome/shell" = {
        disable-user-extensions = false;
        disabled-extensions = [ ]; 
        enabled-extensions = [
          "freon@UshakovVasilii_Github.yahoo.com"
        ];
      };
      "org/gnome/shell/extensions/freon" = {
        show-icon-on-panel = false;
        use-drive-hddtemp = true;
        exec-method-freeipmi = "pkexec";
      };
    };
  };
}
