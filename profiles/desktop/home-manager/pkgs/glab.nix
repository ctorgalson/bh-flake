{ pkgs, ... }:

{
  config = {
    home.packages = with pkgs; [
      glab
      (writeShellScriptBin "glab-wrapper" ''
        # TODO: extend for non-AT uses of Gitlab.
        export GITLAB_HOST="$(cat /run/secrets/gitlab_host_at)"
        export GITLAB_TOKEN="$(cat /run/secrets/gitlab_token_at)"

        exec ${pkgs.glab}/bin/glab "$@"
      '')
    ];

    # If we ever need a config file, we'll have to do this in a way that allows
    # setting file perms to 0600.
    #
    # home.file = {
    #   ".config/glab-cli/config.yml".text = ''
    #     # No config currently needed beyond glab-wrapper's env vars.
    #   '';
    # };
  };
}
