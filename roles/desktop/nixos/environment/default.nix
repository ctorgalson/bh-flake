{ inputs, lib, pkgs, ... }:

{
  environment = {
    sessionVariables = {
      # BW's ssh-agent doesn't seem to work properly on Nixos (?)
      # SSH_AUTH_SOCK = "$HOME.bitwarden-ssh-agent.sock";
      XDG_CACHE_HOME = "$HOME/.cache";
      XDG_CONFIG_HOME = "$HOME/.config";
      XDG_DATA_HOME = "$HOME/.local/share";
      XDG_STATE_HOME = "$HOME/.local/state";

      # Not officially in the specification
      XDG_BIN_HOME = "$HOME/.local/bin";
      PATH = [ 
        "$''{XDG_BIN_HOME}"
      ];
    };

    systemPackages = with pkgs; [
      bws
      catppuccin-plymouth
      docker
      micro
      mkcert
      plymouth
      steam
      zoom-us
    ];
  };
}
