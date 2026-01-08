{ pkgs, ... }:

{
  config = {
    home.packages = with pkgs; [
      glab
      (writeShellScriptBin "glab-wrapper" ''
        # TODO: extend for non-AT uses of Gitlab.
        export GITLAB_HOST="$(cat /run/secrets/gitlab_host_at)"
        export GITLAB_TOKEN="$(cat /run/secrets/gitlab_token_at)"
      '')
    ];

    home.file = {
      ".config/glab-cli/config.yml".text = ''
        # No config currently needed beyond glab-wrapper's env vars.
      '';
    };
  };
}
