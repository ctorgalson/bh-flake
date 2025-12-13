#!/usr/bin/env bash
set -e

echo "Building NixOS SD card image for Raspberry Pi Zero 2 W..."
echo ""
echo "This image includes bootstrap features for easy first-boot setup:"
echo "  - Auto-login on console as ctorgalson"
echo "  - SSH enabled with key authentication"
echo "  - Ethernet-only (WiFi disabled)"
echo ""
echo "After first boot, use 'colmena apply --on pi0' to deploy the"
echo "final configuration (disables auto-login)."
echo ""
echo "Building image..."
echo "This may take a while..."
echo ""

# Build the SD card image
nix build .#nixosConfigurations.pi0.config.system.build.sdImage

# Show the result
echo ""
echo "Build complete!"
IMAGE_PATH=$(ls result/sd-image/*.img)
echo "Image location: $IMAGE_PATH"
ls -lh "$IMAGE_PATH"

echo ""
echo "To write to SD card:"
echo "  sudo dd if=\"$IMAGE_PATH\" of=/dev/sdX bs=4M status=progress conv=fsync"
echo ""
echo "Or use with rpi-imager:"
echo "  # Select 'Use custom' in rpi-imager and choose $IMAGE_PATH"
