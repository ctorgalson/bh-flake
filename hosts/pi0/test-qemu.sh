#!/usr/bin/env bash
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Check if image exists (result symlink is in the same directory as this script)
if [ ! -d "$SCRIPT_DIR/result/sd-image" ]; then
    echo "Error: SD image not found. Run ./build-image.sh first."
    exit 1
fi

# Find the compressed image
IMAGE_ZST=$(ls "$SCRIPT_DIR"/result/sd-image/*.img.zst 2>/dev/null | head -1)

if [ ! -f "$IMAGE_ZST" ]; then
    echo "Error: No .img.zst file found in result/sd-image/"
    exit 1
fi

# Decompress to /tmp for testing (since Nix store is read-only)
IMAGE="/tmp/pi0-qemu.img"
if [ ! -f "$IMAGE" ] || [ "$IMAGE_ZST" -nt "$IMAGE" ]; then
    echo "Decompressing image for QEMU testing..."
    zstd -d "$IMAGE_ZST" -o "$IMAGE" --force
    chmod 644 "$IMAGE"
fi

echo "Testing NixOS Pi image in QEMU..."
echo "Image: $IMAGE"
echo ""
echo "Note: This uses QEMU 'virt' machine (not real Pi hardware emulation)"
echo "      but will test the NixOS configuration, Tailscale, etc."
echo ""
echo "Login as root (no password on first boot)"
echo "Press Ctrl+A then X to exit QEMU"
echo ""

# Resize test image to 8GB for more space (modifies /tmp copy)
if [ $(stat -c%s "$IMAGE") -lt 8589934592 ]; then
    echo "Resizing test image to 8GB..."
    qemu-img resize -f raw "$IMAGE" 8G
fi

# Launch QEMU with verbose output
echo "Starting QEMU (this may take a minute to boot)..."
qemu-system-aarch64 \
  -M virt \
  -cpu cortex-a72 \
  -m 1G \
  -drive file="$IMAGE",format=raw,if=virtio \
  -netdev user,id=net0 \
  -device virtio-net-pci,netdev=net0 \
  -serial stdio \
  -display none \
  -no-reboot \
  -d guest_errors
