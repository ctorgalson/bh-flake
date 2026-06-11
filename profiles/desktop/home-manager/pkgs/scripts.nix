{ pkgs, ... }:

{
  home.packages = with pkgs; [
    (writeShellScriptBin "hello-terminal" (builtins.readFile ./scripts/gbf.sh))
  ];
}
