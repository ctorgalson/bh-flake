{ pkgs, stylix, ... }:

{
  stylix = {
    enable = true;

    autoEnable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";

    fonts = {
      # emoji = {};

      monospace = {
        name = "UbuntuMono Nerd Font";
        package = pkgs.nerd-fonts.ubuntu-mono;
      };

      sansSerif = {
        name = "Cantarell Regular";
        package = pkgs.cantarell-fonts;
      };

      serif = {
        name = "Cantarell Regular";
        package = pkgs.cantarell-fonts;
      };

      sizes = {
        applications = 10;
        desktop = 10;
        popups = 8;
        terminal = 11;
      };
    };

    image = ../../../../images/IMG_0952.jpg;

    targets = {
      # home manager only
      # fzf.enable = true;

      gnome.enable = true;

      grub = {
        enable = true;
        useWallpaper = true;
      };

      gtk.enable = true;

      # home manager only
      # kitty.enable = true;

      # home manager only
      # micro.enable = true;

      # home manager only
      # neovim.enable = true;

      nixos-icons.enable = true;

      qt.enable = true;

      plymouth.enable = true;

      # home manager only
      # starship.enable = true;

      # home manager only
      # tmux.enable = true;

      # home manager only
      # vscode.enable = true;

      # home manager only
      # zed.enable = true;

      # home manager only
      # zellij.enable = true;
    };
  };
}
