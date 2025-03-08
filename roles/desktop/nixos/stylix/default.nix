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
      gnome = {
        enable = true;
      };

      grub = {
        enable = true;
        useWallpaper = true;
      };

      nixos-icons = {
        enable = true;
      };

      plymouth = {
        enable = true;
      };
    };

    # Tmux (?)

    # Zed

    # Zellij
  };
}
