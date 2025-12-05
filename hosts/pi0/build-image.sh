#!/usr/bin/env bash
set -e

echo "Building NixOS SD card image for Raspberry Pi Zero 2 W..."
echo "This may take a while..."

# Build the SD card image
nix build .#nixosConfigurations.pi0.config.system.build.sdImage

# Show the result
echo ""
echo "Build complete!"
echo "Image location: $(readlink -f result)/sd-image/*.img.zst"
ls -lh result/sd-image/*.img.zst

echo ""
echo "To write to SD card (decompressing on-the-fly):"
echo "  zstd -d result/sd-image/*.img.zst -o pi0.img"
echo "  sudo dd if=pi0.img of=/dev/sdX bs=4M status=progress conv=fsync"
echo ""
echo "Or write directly:"
echo "  zstdcat result/sd-image/*.img.zst | sudo dd of=/dev/sdX bs=4M status=progress"
echo ""
echo "To test in QEMU:"
echo "  ./test-qemu.sh"
