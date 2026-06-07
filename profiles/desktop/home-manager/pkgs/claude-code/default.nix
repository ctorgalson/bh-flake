{ pkgs, ... }:

{
  # @see https://adim.in/p/local-coding-agent/
  config = {
    home.packages = with pkgs; [
      claude-code
    ];

    home.file = {
      ".claude/skills/strict-code-review/SKILL.md".source = ./strict-code-review.md;
    };
  };
}

