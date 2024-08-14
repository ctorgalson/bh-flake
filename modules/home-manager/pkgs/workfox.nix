{ config, pkgs, home, ... }:

{
  config = {
    home.packages = with pkgs; [
      (writeShellScriptBin "workfox" ''
        firefox -P work
      '')
    ];
  };
}
