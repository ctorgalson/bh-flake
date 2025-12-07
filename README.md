# BH Flake

NixOS configuration flake for managing a fleet of desktop machines and appliances.

## Hosts

### Desktop Hosts (x86_64-linux)
- **framework13** - Framework 13 laptop (user: ctorgalson)
- **ser6** - Beelink SER6 mini PC (user: ctorgalson)
- **executive14** - Slimbook Executive 14 laptop (user: ctorgalson)

### Appliances (aarch64-linux)
- **pi0** - Raspberry Pi Zero 2 W network appliance

All desktop hosts share the `desktop` role and have ARM emulation enabled for cross-compilation.

## Initial Deployment (New Desktop Host)

1. Install NixOS via installer
2. Enable flakes in existing nix config if new:
   ```nix
   nix.settings.experimental-features = [ "nix-command" "flakes" ];
   ```
3. Clone repository:
   ```bash
   git clone https://github.com/ctorgalson/bh-flake.git
   cd bh-flake
   ```
4. Initialize (if needed):
   ```bash
   nix-shell
   ./init.sh
   ```
5. Build and activate configuration:
   ```bash
   sudo nixos-rebuild switch --flake '.#hostname?submodules=1'
   ```

### Post-Deployment Setup for New Desktop Host

After initial deployment, complete these steps to enable the new host in the fleet:

1. **Generate Nix signing key** (for Colmena cross-host deployments):
   ```bash
   sudo nix-store --generate-binary-cache-key $(hostname) /etc/nix/signing-key.sec /etc/nix/signing-key.pub
   cat /etc/nix/signing-key.pub
   ```

2. **Add the public key to the flake**:
   - Edit `roles/desktop/nixos/nix/default.nix`
   - Add the new host's key to `trusted-public-keys` list
   - Format: `"hostname:PUBLIC_KEY_HERE"`

3. **Get SSH host key in age format** (for SOPS secrets):
   ```bash
   nix-shell -p ssh-to-age --run 'cat /etc/ssh/ssh_host_ed25519_key.pub | ssh-to-age'
   ```

4. **Update SOPS configuration**:
   - Add the host's age key to `.sops.yaml` in appropriate key groups
   - Re-encrypt affected secrets: `sops updatekeys sops/workstation/shared.yaml`
   - The host will automatically receive the shared editing key via SOPS

5. **Backup SSH host private key** (optional, for disaster recovery):
   ```bash
   sudo cat /etc/ssh/ssh_host_ed25519_key
   # Store securely in Bitwarden or similar
   ```

6. **Commit and deploy changes**:
   ```bash
   git add -A
   git commit -m "feat: add new host to fleet"
   colmena apply  # Deploy to all hosts including new one
   ```

## Host-Specific Setup

### Signal CLI (for ClamAV notifications)

Link signal-cli to your Signal account for antivirus scan notifications:

1. Generate and display QR code:
   ```bash
   signal-cli link -n "workstation-${HOST}" | xargs -L 1 qrencode -t ansiutf8 --level=H -v 10
   ```

2. Open the QR code image:
   ```bash
   xdg-open /tmp/qrcode.png
   ```

3. In Signal app on your phone:
   - Settings → Linked Devices → "+" (Link New Device)
   - Scan the QR code

4. Once linked, receive initial data:
   ```bash
   signal-cli receive
   ```

The ClamAV scan scripts will automatically send Signal notifications when infected files are detected.

## Deployment with Colmena

Colmena is the unified deployment tool for all hosts - whether deploying to the current machine, a single remote host, or the entire fleet.

### Deploy to Current Host

```bash
colmena apply --on $(hostname)
```

### Deploy to Specific Remote Host

```bash
colmena apply --on ser6
```

### Deploy to Multiple Hosts

```bash
# Multiple specific hosts
colmena apply --on ser6,framework13

# All hosts
colmena apply

# All hosts except current machine
colmena apply --on @all-other
```

### Update Flake and Deploy

```bash
# Update dependencies
nix flake update

# Commit if changed
git commit -am 'feat: updates flake.lock'

# Deploy
colmena apply --on $(hostname)  # Current host
# or
colmena apply                    # All hosts
```

### Deployment Goals

By default, `colmena apply` switches to the new configuration. You can specify other goals:

```bash
# Only build, don't deploy
colmena apply build --on hostname

# Build and copy to hosts, but don't activate
colmena apply push --on hostname

# Dry-run activation (shows what would change)
colmena apply dry-activate --on hostname

# Boot into new config on next reboot
colmena apply boot --on hostname

# Test new config (reverts on reboot)
colmena apply test --on hostname
```

### Inspect Configuration

```bash
# List all hosts
colmena eval -E '{ nodes, ... }: builtins.attrNames nodes'

# Get hostname of specific node
colmena eval -E '{ nodes, ... }: nodes.ser6.config.networking.hostName'
```

## Legacy: Local rebuild.sh

The `rebuild.sh` script is still available for quick local iteration but Colmena is the preferred deployment method:

```bash
./rebuild.sh
```

## Cross-Compilation

Desktop hosts can build packages for pi0 (aarch64-linux) via QEMU user-mode emulation:
- Enabled via `boot.binfmt.emulatedSystems = [ "aarch64-linux" ]`
- Colmena automatically builds pi0 configuration on the deployment machine
- Set per-host with `deployment.buildOnTarget = false` in Colmena config

## Architecture

```
bh-flake/
├── flake.nix                 # Main flake with nixosConfigurations and colmena outputs
├── hosts/                    # Per-host configuration
│   ├── framework13/
│   ├── ser6/
│   ├── executive14/
│   └── pi0/
├── roles/                    # Shared role configurations
│   └── desktop/              # Desktop role (shared by framework13, ser6, executive14)
│       ├── nixos/            # System-level configuration
│       └── home-manager/     # User-level configuration
└── rebuild.sh                # Legacy local rebuild helper script
```

## Notes

- **Submodules**: This flake uses git submodules (bh-nixvim). Commands include `?submodules=1` to ensure they're fetched.
- **Tailscale SSH**: All remote deployments use Tailscale SSH for secure connectivity.
- **Auto-upgrades**: Desktop hosts automatically update daily with randomized delay.
- **Secrets Management**: Uses sops-nix for encrypted secrets.
- **Styling**: Uses stylix for consistent theming across all applications.

## Troubleshooting

### Dirty Git Tree Warnings

If you see warnings about dirty git tree, either commit your changes or add the `--impure` flag:
```bash
colmena --impure apply --on $(hostname)
```

### SSH Connection Issues

Ensure target host is accessible via Tailscale:
```bash
tailscale status
ssh hostname
```

### Build Failures

Check build logs with verbose output:
```bash
colmena apply -v --on hostname
```

### Cross-Compilation Issues

If pi0 deployment fails, verify ARM emulation is working:
```bash
nix-build '<nixpkgs>' -A hello --arg crossSystem '{ config = "aarch64-unknown-linux-gnu"; }'
```
