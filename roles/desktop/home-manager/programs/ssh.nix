{ host, config, ... }:

{
  config = {
    programs.ssh = {
      enable = true;
      # Note: enableDefaultConfig option not available in Home Manager 25.05
      # Previously used to disable auto-generated defaults like:
      #   ForwardAgent no, ServerAliveInterval 0, etc.
      extraConfig = ''
        LogLevel ERROR

        Host *.upsun.com
          Include /home/${host.username}/.upsun-cli/ssh/*.config
      '';
      matchBlocks = {
        # "*" = {
        #   identityAgent = "/home/${host.username}/.bitwarden-ssh-agent.sock";
        # };
        "*.anner.ie" = {
          user = "at";
        };
        "nx" = {
          hostname = "ct.anner.ie";
          user = host.username;
          forwardAgent = true;
          identityFile = "/home/${host.username}/.ssh/id_ed25519_sk_annertech";
          identitiesOnly = true;
          identityAgent = "${config.home.sessionVariables.XDG_RUNTIME_DIR}/ssh-agent";
        };
      };
    };
  };
}
