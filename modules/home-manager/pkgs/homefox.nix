{ config, pkgs, home, ... }:

{
  config = {
    # This could be an alias, but retained as a script for consistency with
    # 'workfox'.
    home.packages = with pkgs; [
      (writeShellScriptBin "homefox" ''
        firefox
      '')
    ];
  };
}
