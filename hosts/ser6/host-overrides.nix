# ser6 host-specific overrides
{ host, ... }:

{
  # Enable vertical tabs in Firefox sidebar (ser6 only)
  # https://www.askvg.com/tips-tweak-and-customize-firefox-sidebar-and-vertical-tabs-like-a-pro/
  home-manager.users."${host.username}".config = {
    programs.firefox.profiles = {
      newhome.settings."sidebar.verticalTabs" = true;
      newwork.settings."sidebar.verticalTabs" = true;
    };

    programs.ssh = {
      matchBlocks = {
        "storageshare" = {
          # ssh://u362807@u362807.your-storagebox.de:23/./ser6
          hostname = "u362807.your-storagebox.de";
          user = "u362807";
          identityFile = "/home/${host.username}/.ssh/id_ed25519_storagebox";
          port = 23;
          identitiesOnly = true;
          identityAgent = "/run/user/1000/ssh-agent";
        };
      };
    };

    dconf.settings = {
      "org/gnome/shell/extensions/tilingshell" = {
        layouts-json = (builtins.readFile ./tilingshell-layouts.json);
      };
    };
  };
}
