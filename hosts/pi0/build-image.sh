#!/usr/bin/env bash
set -e

echo "Building NixOS SD card image for Raspberry Pi Zero 2 W..."
echo "This may take a while..."

# Build the SD card image
nix build .#nixosConfigurations.pi0.config.system.build.sdImage

# Show the result
echo ""
echo "Build complete!"
echo "Image location: $(readlink -f result)/sd-image/*.img"
ls -lh result/sd-image/*.img

echo ""
echo "To write to SD card:"
echo "  sudo dd if=result/sd-image/*.img of=/dev/sdX bs=4M status=progress conv=fsync"
echo ""
echo "To test in QEMU:"
echo "  ./test-qemu.sh"
