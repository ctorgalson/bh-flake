#!/usr/bin/env bash
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
FLAKE_ROOT="$SCRIPT_DIR/../.."

# Check if image exists
if [ ! -d "$FLAKE_ROOT/result/sd-image" ]; then
    echo "Error: SD image not found. Run ./build-image.sh first."
    exit 1
fi

IMAGE=$(ls "$FLAKE_ROOT"/result/sd-image/*.img | head -1)

if [ ! -f "$IMAGE" ]; then
    echo "Error: No .img file found in result/sd-image/"
    exit 1
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

# Create a copy of the image for testing (so we don't modify the original)
TEST_IMAGE="/tmp/pi0-test.img"
if [ ! -f "$TEST_IMAGE" ] || [ "$IMAGE" -nt "$TEST_IMAGE" ]; then
    echo "Creating test image copy..."
    cp "$IMAGE" "$TEST_IMAGE"
fi

# Resize test image to 8GB for more space
if [ $(stat -c%s "$TEST_IMAGE") -lt 8589934592 ]; then
    echo "Resizing test image to 8GB..."
    qemu-img resize -f raw "$TEST_IMAGE" 8G
fi

# Launch QEMU
qemu-system-aarch64 \
  -M virt \
  -cpu cortex-a72 \
  -m 1G \
  -drive file="$TEST_IMAGE",format=raw,if=virtio \
  -netdev user,id=net0 \
  -device virtio-net-pci,netdev=net0 \
  -serial stdio \
  -display none \
  -no-reboot
