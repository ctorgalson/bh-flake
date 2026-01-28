# Windows NVDA Screen Reader Testing on NixOS

Automated setup for testing websites with NVDA screen reader in a Windows VM.

## Quick Start

```bash
# 1. Rebuild NixOS to install the scripts
sudo nixos-rebuild switch

# 2. Log out and back in (to apply libvirtd group membership)

# 3. Download Windows 10 ISO
# Visit: https://www.microsoft.com/software-download/windows10

# 4. Create auto-install ISO (one-time)
prepare-windows-autoinstall
# When prompted, provide path to your downloaded Windows ISO

# 5. Create and install VM (one-time, ~20 minutes unattended)
create-windows-nvda-vm
# Uses the auto-install ISO, installation is fully automated

# 6. Wait for Windows to install (monitor with open-windows-nvda-vm)

# 7. Once Windows desktop loads, run inside Windows:
setup-windows-nvda
# Copy the PowerShell script output and run it in Windows
# This installs NVDA, Chrome, and Firefox via winget

# 8. Daily usage
open-windows-nvda-vm
```

## What Gets Automated

✅ **Fully Automated:**
- VM creation with proper UEFI/TPM/VirtIO config
- Windows installation (no clicking through wizards!)
- User account creation (username: `nvda`, password: `nvda`)
- Auto-login enabled
- NVDA, Chrome, Firefox installation via winget

✅ **Persists Between Sessions:**
- VM state is saved
- All installations and settings preserved
- Just run `open-windows-nvda-vm` to resume

## Available Commands

| Command | Description |
|---------|-------------|
| `prepare-windows-autoinstall` | Create unattended Windows ISO (one-time) |
| `create-windows-nvda-vm` | Create and install VM (one-time, ~20 min) |
| `open-windows-nvda-vm` | Open existing VM (daily usage) |
| `status-windows-nvda-vm` | Check if VM exists and its state |
| `setup-windows-nvda` | Show PowerShell script for NVDA/browser install |
| `remove-windows-nvda-vm` | Delete VM and disk (start over) |

## VM Specifications

- **OS**: Windows 10/11
- **RAM**: 4 GB
- **CPUs**: 2 cores
- **Disk**: 60 GB (dynamically allocated)
- **Firmware**: UEFI with Secure Boot
- **TPM**: 2.0 (for Windows 11 compatibility)
- **Credentials**: username `nvda` / password `nvda`

## NVDA Quick Reference

### Starting NVDA
- **Ctrl + Alt + N**: Start NVDA

### Basic Commands
- **Insert** or **CapsLock**: NVDA modifier key
- **Insert + N**: NVDA menu
- **Insert + Q**: Quit NVDA
- **Insert + S**: Toggle speech on/off
- **Insert + Down Arrow**: Read from current position

### Web Navigation (Browse Mode)
- **H** / **Shift+H**: Next/Previous heading
- **K** / **Shift+K**: Next/Previous link
- **B** / **Shift+B**: Next/Previous button
- **F** / **Shift+F**: Next/Previous form field
- **T** / **Shift+T**: Next/Previous table
- **D** / **Shift+D**: Next/Previous landmark
- **Insert + F7**: Elements list (all links, headings, etc.)

### Mode Switching
- **Insert + Space**: Toggle between Browse Mode and Focus Mode
  - Browse Mode: Use single keys (H, K, B) to navigate
  - Focus Mode: Type normally in form fields

## Workflow for Daily Testing

1. **Start VM**: `open-windows-nvda-vm`
2. **Start NVDA**: Press **Ctrl + Alt + N** in Windows
3. **Open Browser**: Chrome or Firefox
4. **Navigate to Website**: Your site to test
5. **Test Navigation**:
   - Press **H** to jump through headings
   - Press **Insert + F7** for elements list
   - Press **K** to jump through links
   - Press **F** to jump through form fields
6. **When Done**: Close virt-viewer (VM auto-saves state)

## Troubleshooting

### "Cannot connect to libvirt"
```bash
sudo systemctl status libvirtd
groups  # Should show libvirtd
# If libvirtd not in groups, log out and back in
```

### "Network 'default' is not active"
```bash
sudo virsh net-start default
sudo virsh net-autostart default
```

### "VM won't boot"
Make sure you used the auto-install ISO created by `prepare-windows-autoinstall`

### Windows installation seems stuck
- Installation takes ~15-20 minutes
- Monitor with `open-windows-nvda-vm`
- VM will reboot several times automatically

### Start fresh
```bash
remove-windows-nvda-vm
# Then run create-windows-nvda-vm again
```

## What Makes This Special

Unlike manual setup:
- **No clicking through Windows installer** - fully unattended
- **No searching for NVDA downloads** - winget handles it
- **No browser downloads** - winget handles it
- **Consistent configuration** - reproducible every time
- **Fast iteration** - delete and recreate VMs quickly
- **NixOS declarative** - configuration version controlled

## Resources

- [NVDA User Guide](https://www.nvaccess.org/files/nvda/documentation/userGuide.html)
- [NVDA Keyboard Shortcuts](https://dequeuniversity.com/screenreaders/nvda-keyboard-shortcuts)
- [WebAIM NVDA Guide](https://webaim.org/articles/nvda/)
- [WCAG 2.1 Guidelines](https://www.w3.org/WAI/WCAG21/quickref/)

## Configuration Location

NixOS configuration:
- roles/desktop/nixos/virtualisation/windows-nvda-vm.nix:1
- roles/desktop/nixos/virtualisation/default.nix:1
- modules/users.nix:24 (libvirtd group)
