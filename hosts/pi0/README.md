# Raspberry Pi Zero 2 W - Network Appliance

Minimal NixOS configuration for a Raspberry Pi Zero 2 W that acts as a network appliance for sending Wake-on-LAN packets.

## Features

- Tailscale for secure remote access
- Auto-updates from flake
- Custom `wake` script for sending WOL packets
- Minimal/headless system (no GUI)

## Setup Instructions

### 1. Add Tailscale auth key to SOPS

```bash
# Edit the secrets file and add tailscale_pi0 key
sops sops/secrets.yaml
```

### 2. Build the SD card image

```bash
cd hosts/pi0
./build-image.sh
```

This will create a bootable SD card image in `result/sd-image/`.

### 3. Test in QEMU (optional)

```bash
./test-qemu.sh
```

Note: This uses QEMU's `virt` machine (not real Pi hardware emulation) but will test the NixOS configuration, Tailscale setup, etc.

### 4. Flash to SD card when Pi arrives

```bash
sudo dd if=result/sd-image/*.img of=/dev/sdX bs=4M status=progress conv=fsync
```

Replace `/dev/sdX` with your SD card device (check with `lsblk`).

### 5. Boot the Pi and connect

After booting, SSH to the Pi via Tailscale:

```bash
ssh root@pi0  # or via Tailscale IP
```

## Usage

### Send Wake-on-LAN packet

```bash
wake ser6
```

This sends a WOL magic packet to ser6 (MAC: 70:70:fc:05:8c:8d).

### Add more hosts

Edit `hosts/pi0/configuration.nix` and add new case statements to the wake script.

## Configuration

- **Hostname**: pi0
- **Auto-update time**: 03:00 daily (with 45min random delay)
- **Timezone**: America/Toronto
- **Locale**: en_CA.UTF-8
- **State version**: 25.05

## TODO

- Fix auto-upgrade to use GitHub URL instead of local flake path
