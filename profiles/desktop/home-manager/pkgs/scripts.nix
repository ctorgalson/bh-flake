{ pkgs, ... }:

{
  home.packages = with pkgs; [
    (writeShellScriptBin "gbf" (builtins.readFile ./scripts/gbf.sh))
  ];
}
