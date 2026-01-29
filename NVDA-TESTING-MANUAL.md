# Manual Windows VM Setup for NVDA Testing

## Prerequisites

Your NixOS system is already configured with libvirtd and virt-manager.

## Step 1: Download Windows 10 ISO

Download from: https://www.microsoft.com/software-download/windows10

You don't need a license - Windows will run unactivated with just a watermark.

## Step 2: Create VM with virt-manager

```bash
virt-manager
```

1. Click **"Create a new virtual machine"**
2. Select **"Local install media"** → Browse to your Windows ISO
3. **Memory**: 4096 MB (4 GB)
4. **CPUs**: 2
5. **Disk**: 60 GB
6. **Name**: whatever you want
7. Click **"Finish"**

## Step 3: Install Windows

1. VM will boot automatically
2. Click through the installer:
   - Language: English
   - Click "Install now"
   - **"I don't have a product key"**
   - Select "Windows 10 Home" or "Pro"
   - Accept license
   - **"Custom: Install Windows only"**
   - Select the disk, click Next
3. Wait ~15 minutes for installation
4. Windows will reboot automatically
5. Complete setup:
   - Region: your region
   - Keyboard: your layout
   - **To skip Microsoft account**:
     - In virt-manager, click the info button (ⓘ) or View → Details
     - Click "NIC" in the left sidebar
     - Uncheck "Connect at boot" or change "Network source" to "Disconnected"
     - Click Apply
     - This forces Windows to allow local account creation
   - Create local account with any username/password
   - Skip all privacy/Cortana/services prompts
   - After setup: Re-enable network in NIC settings

## Step 4: Install NVDA, Chrome, Firefox

Inside Windows, open PowerShell and run:

```powershell
# Check if winget is available
winget --version

# Install NVDA
winget install --id NVAccess.NVDA --silent --accept-package-agreements --accept-source-agreements

# Install Chrome
winget install --id Google.Chrome --silent --accept-package-agreements --accept-source-agreements

# Install Firefox
winget install --id Mozilla.Firefox --silent --accept-package-agreements --accept-source-agreements
```

**If winget is not available** (older Windows 10):
- Download NVDA manually: https://www.nvaccess.org/download/
- Chrome and Firefox download automatically from their websites

## Step 5: Start Testing

1. **Start NVDA**: Press `Ctrl + Alt + N`
2. **Open a browser**: Chrome or Firefox
3. **Navigate to your website**
4. **Test with NVDA**:
   - Press `H` to jump between headings
   - Press `K` to jump between links
   - Press `B` to jump between buttons
   - Press `F` to jump between form fields
   - Press `Insert + F7` for elements list

## NVDA Quick Reference

**Starting/Stopping:**
- `Ctrl + Alt + N` - Start NVDA
- `Insert + Q` - Quit NVDA

**Basic Navigation:**
- `Insert` or `CapsLock` - NVDA modifier key
- `Insert + N` - NVDA menu
- `Insert + S` - Toggle speech on/off
- `Insert + Down Arrow` - Read from current position

**Web Navigation (Browse Mode):**
- `H` / `Shift+H` - Next/Previous heading
- `K` / `Shift+K` - Next/Previous link
- `B` / `Shift+B` - Next/Previous button
- `F` / `Shift+F` - Next/Previous form field
- `T` / `Shift+T` - Next/Previous table
- `D` / `Shift+D` - Next/Previous landmark
- `Insert + F7` - Elements list (all links, headings, etc.)

**Mode Switching:**
- `Insert + Space` - Toggle between Browse Mode and Focus Mode

## Daily Usage

**Start VM:**
```bash
# Find your VM name
virsh --connect qemu:///system list --all

# Start it
virsh --connect qemu:///system start YOUR-VM-NAME

# Or just use virt-manager GUI
virt-manager
```

**Stop VM:**
- In Windows: Start → Power → Shut down
- Or in virt-manager: Right-click VM → Shut Down

## Snapshots (Recommended)

After installing Windows + NVDA, create a snapshot so you can quickly restore:

1. In virt-manager, select your VM
2. Click the snapshot icon (or VM → Snapshots)
3. Click "+" to create snapshot
4. Name it "Fresh install with NVDA"

Now you can revert to this clean state anytime.

## Troubleshooting

**VM won't start:**
```bash
systemctl status libvirtd
# If inactive:
sudo systemctl start libvirtd
```

**Can't connect to VM:**
```bash
# Make sure you're in the libvirtd group
groups | grep libvirtd
# If not, log out and back in
```

**Network not working in VM:**
```bash
virsh --connect qemu:///system net-list
# If default network is inactive:
virsh --connect qemu:///system net-start default
```

## Resources

- [NVDA User Guide](https://www.nvaccess.org/files/nvda/documentation/userGuide.html)
- [NVDA Keyboard Shortcuts](https://dequeuniversity.com/screenreaders/nvda-keyboard-shortcuts)
- [WebAIM NVDA Guide](https://webaim.org/articles/nvda/)

## Total Time

- Download Windows ISO: 10-30 minutes (one-time)
- Create VM: 2 minutes
- Install Windows: 15 minutes
- Install NVDA/browsers: 5 minutes
- **Total: ~25 minutes** (plus ISO download)
