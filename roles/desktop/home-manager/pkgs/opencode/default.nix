{ pkgs, ... }:

{
  # @see https://adim.in/p/local-coding-agent/
  config = {
    home.packages = with pkgs; [
      opencode
    ];

    home.file = {
      ".config/opencode/opencode.json".source = ./opencode.json;
    };
  };
}
