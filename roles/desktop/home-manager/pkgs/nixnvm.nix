{ config, pkgs, home, ... }:

{
  config = {
    home.packages = with pkgs; [
      (writeShellScriptBin "nixnvm" ''
        p="$PWD"/.nvmrc

        if [[ ! -f "$p" ]]; then
          echo "Could not find an .nvmrc file in this directory."
          exit 1
        fi

        # Get relevant contents of .nvmrc, if any.
        v=$(head -n1 "$p")
        r="v([0-9]+)"

        # If the contents look like a version, create a shell.nix file using
        # that version.
        if [[ "$v" =~ $r ]]; then
          cat << EOF > "$PWD"/shell.nix
        { pkgs ? import <nixpkgs> {} }:
      
        pkgs.mkShell {
          nativeBuildInputs = with pkgs.buildPackages; [ nodejs_''${BASH_REMATCH[1]} ];
        }
        EOF
        else
          echo "Could not retrieve a node version from .nvmrc"
          exit 1
        fi
      '')
    ];
  };
}
