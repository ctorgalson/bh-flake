#!/usr/bin/env bash
set -e

WIFI_CONF="/tmp/pi0-wifi.conf"

# Cleanup function
cleanup() {
  if [ -f "$WIFI_CONF" ]; then
    rm -f "$WIFI_CONF"
    echo "Cleaned up temporary WiFi config"
  fi
}

# Set trap to ensure cleanup on exit
trap cleanup EXIT INT TERM

echo "Building NixOS SD card image for Raspberry Pi Zero 2 W..."
echo ""
echo "This image includes bootstrap features for easy first-boot setup:"
echo "  - Auto-login on console as ctorgalson"
echo "  - SSH enabled with key authentication"
echo "  - WiFi support (optional - ethernet preferred)"
echo ""
echo "After first boot, use 'colmena apply --on pi0' to deploy the"
echo "final configuration (disables auto-login and WiFi)."
echo ""

# Prompt for WiFi credentials (optional fallback)
read -p "WiFi SSID (press Enter to skip): " WIFI_SSID
if [ -n "$WIFI_SSID" ]; then
  read -sp "WiFi Password: " WIFI_PASSWORD
  echo ""
else
  WIFI_PASSWORD=""
fi

# Create wpa_supplicant config
if [ -n "$WIFI_SSID" ]; then
  cat > "$WIFI_CONF" <<EOF
network={
  ssid="$WIFI_SSID"
  psk="$WIFI_PASSWORD"
}
EOF
  echo ""
  echo "Building image with WiFi credentials..."
  echo "This may take a while..."
else
  # Create empty config if no WiFi credentials provided
  touch "$WIFI_CONF"
  echo ""
  echo "Building image without WiFi (ethernet only)..."
  echo "This may take a while..."
fi

# Build the SD card image with impure flag to access temp file
nix build .#nixosConfigurations.pi0.config.system.build.sdImage --impure

# Show the result
echo ""
echo "Build complete!"
IMAGE_PATH=$(ls result/sd-image/*.img.zst)
echo "Image location: $IMAGE_PATH"
ls -lh "$IMAGE_PATH"

echo ""
echo "To write to SD card (decompressing on-the-fly):"
echo "  zstdcat \"$IMAGE_PATH\" | sudo dd of=/dev/sdX bs=4M status=progress conv=fsync"
echo ""
echo "Or decompress first then write:"
echo "  zstd -d \"$IMAGE_PATH\" -o pi0.img"
echo "  sudo dd if=pi0.img of=/dev/sdX bs=4M status=progress conv=fsync"
echo ""
echo "To use with rpi-imager, decompress first:"
echo "  zstd -d \"$IMAGE_PATH\" -o pi0.img"
echo "  # Then select 'Use custom' in rpi-imager and choose pi0.img"
