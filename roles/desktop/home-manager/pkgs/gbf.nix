{ pkgs, ... }:

{
  home.packages = with pkgs; [
    (writeShellScriptBin "gcofzf" ''
      if command -v fzf &> /dev/null; then
        git branch | fzf | xargs git checkout
      else
        echo "Could not find 'fzf'. Please install it or use the git command directly."
      fi
    '')
  ];
}
