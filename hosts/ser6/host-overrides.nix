# ser6 host-specific overrides
{ config, host, lib, pkgs, ... }:

{
  # Enable vertical tabs in Firefox sidebar (ser6 only)
  # https://www.askvg.com/tips-tweak-and-customize-firefox-sidebar-and-vertical-tabs-like-a-pro/
  home-manager.users."${host.username}".config = {
    programs.firefox.profiles = {
      newhome.settings."sidebar.verticalTabs" = true;
      newwork.settings."sidebar.verticalTabs" = true;
    };
  };
}
