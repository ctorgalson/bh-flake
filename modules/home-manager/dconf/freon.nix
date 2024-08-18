{ config, lib, pkgs, programs, ... }:

{
  config = {
    dconf.settings = {
      "org/gnome/shell/extensions/freon" = {
        show-icon-on-panel = false;
        use-drive-hddtemp = true;
        exec-method-freeipmi = "pkexec";
      };
    };
  };
}
