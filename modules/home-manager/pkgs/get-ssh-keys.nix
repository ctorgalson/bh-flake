{ config, pkgs, home, ... }:

{
  config = {
    home.packages = with pkgs; [
      (writeShellScriptBin "get-ssh-keys" ''
        # Secret ids directly from bws.
        keyfiles=( "c123be40-2dfe-4010-9003-b1c2009f2b77" "d383792e-e323-409e-a13e-b1c2009f9bda" "eda34a25-9273-4f42-85e8-b1c500791a3e" "6d229a7d-c32a-47cf-a048-b1c50079401b" )

        # Check to see if it's possible to continue.
        if [[ -z "$BWS_ACCESS_TOKEN" ]]; then
	  read -p 'BWS_ACCESS_TOKEN: ' token
	  export BWS_ACCESS_TOKEN="token"
        fi

        # Retrieve and write secrets to files.
        #
        # Inspection of the code will show that we're treating .pub files the
        # same way as the private keys. This is just for the convenience of
        # storing them together in bws.
        #
        # Note escaped nix expression that may (?) break the script if copied
        # unmodified.
        for keyfile in "''${keyfiles[@]}"; do
          secret=$(bws secret get "$keyfile")
          filepath="$HOME"/.ssh/"$(jq --raw-output .key <<< "$secret")"
          jq --raw-output .value <<< "$secret" > "$filepath"
          [[ "$filepath" =~ pub$ ]] && fileperms="644" || fileperms="600"
          chmod "$fileperms" "$filepath"
        done

        # Get public keys from github and write to authorized_keys.
        authorized_filepath="$HOME"/.ssh/authorized_keys
        curl https://github.com/ctorgalson.keys --output "$authorized_filepath"
        chmod 600 "$authorized_filepath"
        ls -hal "$HOME/.ssh"      
      '')
    ];
  };
}