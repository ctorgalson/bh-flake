# { inputs, lib, pkgs, ... }:

{
  imports = [
    ./clamav
  ];

  services.fwupd = {
    enable = true;
  };

  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
      PermitRootLogin = "no";
    };
  };

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  services.ollama = {
    enable = true;
    environmentVariables = {
      OLLAMA_KEEP_ALIVE = "10m"; # Unload models after 5 minutes of inactivity
    };
    acceleration = "cpu";
    loadModels = [
      # "qwen2.5-coder:latest"
      "qwen2.5-coder:3b"
    ];
  };

  services.printing.enable = true;

  services.pulseaudio.enable = false;

  services.tailscale = {
    enable = true;
  };

  services.xserver = {
    enable = true;
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
    xkb = {
      layout = "us";
      variant = "";
    };
  };
}
