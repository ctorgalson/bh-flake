#!/usr/bin/env bash
set -e

echo "Building NixOS SD card image for Raspberry Pi Zero 2 W..."
echo "This may take a while..."

# Build the SD card image
nix build .#nixosConfigurations.pi0.config.system.build.sdImage

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
