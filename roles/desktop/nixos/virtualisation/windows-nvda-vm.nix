{ config, lib, pkgs, ... }:

let
  cfg = config.bhFlake.windowsNvdaVm;

  # Autounattend.xml for automated Windows installation
  autounattendXml = pkgs.writeText "autounattend.xml" ''
    <?xml version="1.0" encoding="utf-8"?>
    <unattend xmlns="urn:schemas-microsoft-com:unattend">
      <settings pass="windowsPE">
        <component name="Microsoft-Windows-International-Core-WinPE" processorArchitecture="amd64" publicKeyToken="31bf3856ad364e35" language="neutral" versionScope="nonSxS" xmlns:wcm="http://schemas.microsoft.com/WMIConfig/2002/State" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
          <SetupUILanguage>
            <UILanguage>en-US</UILanguage>
          </SetupUILanguage>
          <InputLocale>en-US</InputLocale>
          <SystemLocale>en-US</SystemLocale>
          <UILanguage>en-US</UILanguage>
          <UserLocale>en-US</UserLocale>
        </component>
        <component name="Microsoft-Windows-Setup" processorArchitecture="amd64" publicKeyToken="31bf3856ad364e35" language="neutral" versionScope="nonSxS" xmlns:wcm="http://schemas.microsoft.com/WMIConfig/2002/State" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
          <DiskConfiguration>
            <Disk wcm:action="add">
              <CreatePartitions>
                <CreatePartition wcm:action="add">
                  <Order>1</Order>
                  <Type>EFI</Type>
                  <Size>100</Size>
                </CreatePartition>
                <CreatePartition wcm:action="add">
                  <Order>2</Order>
                  <Type>MSR</Type>
                  <Size>16</Size>
                </CreatePartition>
                <CreatePartition wcm:action="add">
                  <Order>3</Order>
                  <Extend>true</Extend>
                  <Type>Primary</Type>
                </CreatePartition>
              </CreatePartitions>
              <ModifyPartitions>
                <ModifyPartition wcm:action="add">
                  <Order>1</Order>
                  <PartitionID>1</PartitionID>
                  <Label>System</Label>
                  <Format>FAT32</Format>
                </ModifyPartition>
                <ModifyPartition wcm:action="add">
                  <Order>2</Order>
                  <PartitionID>2</PartitionID>
                </ModifyPartition>
                <ModifyPartition wcm:action="add">
                  <Order>3</Order>
                  <PartitionID>3</PartitionID>
                  <Label>Windows</Label>
                  <Format>NTFS</Format>
                </ModifyPartition>
              </ModifyPartitions>
              <DiskID>0</DiskID>
              <WillWipeDisk>true</WillWipeDisk>
            </Disk>
          </DiskConfiguration>
          <ImageInstall>
            <OSImage>
              <InstallTo>
                <DiskID>0</DiskID>
                <PartitionID>3</PartitionID>
              </InstallTo>
              <InstallToAvailablePartition>false</InstallToAvailablePartition>
            </OSImage>
          </ImageInstall>
          <UserData>
            <AcceptEula>true</AcceptEula>
            <FullName>NVDA Tester</FullName>
            <Organization>Accessibility Testing</Organization>
            <ProductKey>
              <WillShowUI>OnError</WillShowUI>
            </ProductKey>
          </UserData>
        </component>
      </settings>
      <settings pass="specialize">
        <component name="Microsoft-Windows-Shell-Setup" processorArchitecture="amd64" publicKeyToken="31bf3856ad364e35" language="neutral" versionScope="nonSxS" xmlns:wcm="http://schemas.microsoft.com/WMIConfig/2002/State" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
          <ComputerName>NVDA-TEST</ComputerName>
          <TimeZone>UTC</TimeZone>
        </component>
      </settings>
      <settings pass="oobeSystem">
        <component name="Microsoft-Windows-Shell-Setup" processorArchitecture="amd64" publicKeyToken="31bf3856ad364e35" language="neutral" versionScope="nonSxS" xmlns:wcm="http://schemas.microsoft.com/WMIConfig/2002/State" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
          <OOBE>
            <HideEULAPage>true</HideEULAPage>
            <HideOEMRegistrationScreen>true</HideOEMRegistrationScreen>
            <HideOnlineAccountScreens>true</HideOnlineAccountScreens>
            <HideWirelessSetupInOOBE>true</HideWirelessSetupInOOBE>
            <NetworkLocation>Work</NetworkLocation>
            <ProtectYourPC>3</ProtectYourPC>
            <SkipUserOOBE>true</SkipUserOOBE>
            <SkipMachineOOBE>true</SkipMachineOOBE>
          </OOBE>
          <UserAccounts>
            <LocalAccounts>
              <LocalAccount wcm:action="add">
                <Password>
                  <Value>nvda</Value>
                  <PlainText>true</PlainText>
                </Password>
                <Description>NVDA Testing Account</Description>
                <DisplayName>NVDA Tester</DisplayName>
                <Group>Administrators</Group>
                <Name>nvda</Name>
              </LocalAccount>
            </LocalAccounts>
          </UserAccounts>
          <AutoLogon>
            <Password>
              <Value>nvda</Value>
              <PlainText>true</PlainText>
            </Password>
            <Enabled>true</Enabled>
            <Username>nvda</Username>
          </AutoLogon>
          <FirstLogonCommands>
            <SynchronousCommand wcm:action="add">
              <Order>1</Order>
              <Description>Disable Windows Update automatic restarts</Description>
              <CommandLine>reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v NoAutoRebootWithLoggedOnUsers /t REG_DWORD /d 1 /f</CommandLine>
            </SynchronousCommand>
            <SynchronousCommand wcm:action="add">
              <Order>2</Order>
              <Description>Set PowerShell execution policy</Description>
              <CommandLine>powershell -Command "Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Force"</CommandLine>
            </SynchronousCommand>
          </FirstLogonCommands>
        </component>
      </settings>
    </unattend>
  '';

  # Script to create bootable ISO with autounattend.xml
  createAutoinstallIso = pkgs.writeShellScriptBin "prepare-windows-autoinstall" ''
    set -e

    echo "=== Prepare Windows Auto-Install ISO ==="
    echo ""
    echo "This will create a modified Windows ISO with automated installation."
    echo ""

    read -e -p "Path to original Windows ISO: " ORIGINAL_ISO

    if [ ! -f "$ORIGINAL_ISO" ]; then
      echo "❌ ISO file not found: $ORIGINAL_ISO"
      exit 1
    fi

    WORK_DIR="$HOME/.local/share/windows-autoinstall"
    MOUNT_DIR="$WORK_DIR/mnt"
    EXTRACT_DIR="$WORK_DIR/extracted"
    OUTPUT_ISO="$WORK_DIR/windows-autoinstall.iso"

    mkdir -p "$MOUNT_DIR" "$EXTRACT_DIR"

    echo "Extracting Windows ISO..."
    ${pkgs.p7zip}/bin/7z x "$ORIGINAL_ISO" -o"$EXTRACT_DIR" -y > /dev/null

    echo "Adding autounattend.xml..."
    cp ${autounattendXml} "$EXTRACT_DIR/autounattend.xml"

    echo "Creating modified ISO..."
    ${pkgs.xorriso}/bin/xorriso -as mkisofs \
      -iso-level 3 \
      -full-iso9660-filenames \
      -volid "WINDOWS_AUTO" \
      -eltorito-boot boot/etfsboot.com \
      -no-emul-boot \
      -boot-load-size 8 \
      -eltorito-alt-boot \
      -e efi/microsoft/boot/efisys.bin \
      -no-emul-boot \
      -o "$OUTPUT_ISO" \
      "$EXTRACT_DIR"

    echo ""
    echo "✅ Auto-install ISO created at:"
    echo "   $OUTPUT_ISO"
    echo ""
    echo "Next step: create-windows-nvda-vm"
    echo "(Use the ISO path above when prompted)"
  '';

  # Script to create and configure the Windows VM
  createWindowsVm = pkgs.writeShellScriptBin "create-windows-nvda-vm" ''
    set -e

    VM_NAME="windows-nvda-test"
    VM_DISK="/var/lib/libvirt/images/$VM_NAME.qcow2"
    VM_DISK_SIZE="60G"
    MEMORY="4096"
    CPUS="2"
    LIBVIRT_URI="qemu:///system"

    echo "=== Windows NVDA VM Creation Script ==="
    echo ""

    # Check if libvirtd is running
    if ! systemctl is-active --quiet libvirtd; then
      echo "Starting libvirtd service..."
      systemctl start libvirtd || {
        echo "❌ Failed to start libvirtd. Run: sudo systemctl start libvirtd"
        exit 1
      }
    fi

    # Check if default network exists, create if not
    if ! ${pkgs.libvirt}/bin/virsh --connect "$LIBVIRT_URI" net-info default >/dev/null 2>&1; then
      echo "Creating default network..."
      ${pkgs.libvirt}/bin/virsh --connect "$LIBVIRT_URI" net-define /dev/stdin <<EOF
<network>
  <name>default</name>
  <forward mode='nat'/>
  <bridge name='virbr0' stp='on' delay='0'/>
  <ip address='192.168.122.1' netmask='255.255.255.0'>
    <dhcp>
      <range start='192.168.122.2' end='192.168.122.254'/>
    </dhcp>
  </ip>
</network>
EOF
    fi

    # Start and autostart the network
    if ! ${pkgs.libvirt}/bin/virsh --connect "$LIBVIRT_URI" net-info default | grep -q "Active:.*yes"; then
      echo "Starting default network..."
      ${pkgs.libvirt}/bin/virsh --connect "$LIBVIRT_URI" net-start default
    fi
    ${pkgs.libvirt}/bin/virsh --connect "$LIBVIRT_URI" net-autostart default >/dev/null 2>&1 || true

    # Create images directory if needed
    if [ ! -d "$(dirname "$VM_DISK")" ]; then
      echo "Creating images directory..."
      sudo mkdir -p "$(dirname "$VM_DISK")"
      sudo chown root:libvirtd "$(dirname "$VM_DISK")"
      sudo chmod 775 "$(dirname "$VM_DISK")"
    fi

    # Check if VM already exists
    if ${pkgs.libvirt}/bin/virsh --connect "$LIBVIRT_URI" list --all | grep -q "$VM_NAME"; then
      echo "❌ VM '$VM_NAME' already exists!"
      echo "To recreate it, first run: remove-windows-nvda-vm"
      exit 1
    fi

    # Suggest auto-install ISO
    AUTO_ISO="$HOME/.local/share/windows-autoinstall/windows-autoinstall.iso"
    if [ -f "$AUTO_ISO" ]; then
      echo "✓ Found auto-install ISO: $AUTO_ISO"
      echo ""
      read -p "Use this auto-install ISO? (y/n): " USE_AUTO
      if [ "$USE_AUTO" = "y" ]; then
        ISO_PATH="$AUTO_ISO"
      else
        read -e -p "Enter ISO path: " ISO_PATH
      fi
    else
      echo "No auto-install ISO found."
      echo "You can create one with: prepare-windows-autoinstall"
      echo ""
      read -e -p "Enter Windows ISO path: " ISO_PATH
    fi

    if [ ! -f "$ISO_PATH" ]; then
      echo "❌ ISO file not found: $ISO_PATH"
      exit 1
    fi

    echo ""
    echo "Creating VM with the following configuration:"
    echo "  Name: $VM_NAME"
    echo "  Memory: $MEMORY MB"
    echo "  CPUs: $CPUS"
    echo "  Disk: $VM_DISK ($VM_DISK_SIZE)"
    echo "  ISO: $ISO_PATH"
    echo ""

    # Create disk image directory if it doesn't exist
    mkdir -p "$(dirname "$VM_DISK")"

    # Create the disk image
    echo "Creating disk image..."
    ${pkgs.qemu}/bin/qemu-img create -f qcow2 "$VM_DISK" "$VM_DISK_SIZE"

    echo "Creating VM definition..."
    # Try with TPM first (for Windows 11), fall back without TPM if it fails
    if ! ${pkgs.virt-manager}/bin/virt-install \
      --connect "$LIBVIRT_URI" \
      --name "$VM_NAME" \
      --memory "$MEMORY" \
      --vcpus "$CPUS" \
      --disk path="$VM_DISK",format=qcow2,bus=virtio \
      --cdrom "$ISO_PATH" \
      --os-variant win10 \
      --network network=default,model=virtio \
      --graphics spice,listen=127.0.0.1 \
      --video qxl \
      --channel spicevmc,target_type=virtio,name=com.redhat.spice.0 \
      --boot uefi \
      --tpm backend.type=emulator,backend.version=2.0,model=tpm-tis \
      --noautoconsole \
      --wait=-1 2>/dev/null; then

      echo "TPM not supported, creating without TPM (Windows 10 only)..."
      rm -f "$VM_DISK"
      ${pkgs.qemu}/bin/qemu-img create -f qcow2 "$VM_DISK" "$VM_DISK_SIZE"

      ${pkgs.virt-manager}/bin/virt-install \
        --connect "$LIBVIRT_URI" \
        --name "$VM_NAME" \
        --memory "$MEMORY" \
        --vcpus "$CPUS" \
        --disk path="$VM_DISK",format=qcow2,bus=virtio \
        --cdrom "$ISO_PATH" \
        --os-variant win10 \
        --network network=default,model=virtio \
        --graphics spice,listen=127.0.0.1 \
        --video qxl \
        --channel spicevmc,target_type=virtio,name=com.redhat.spice.0 \
        --boot uefi \
        --noautoconsole \
        --wait=-1
    fi

    echo ""
    echo "✅ VM created successfully!"
    echo ""

    if [[ "$ISO_PATH" == *"autoinstall"* ]]; then
      echo "🤖 Auto-installation in progress..."
      echo "   Windows will install automatically (takes ~15-20 minutes)"
      echo "   Credentials: username 'nvda' / password 'nvda'"
      echo ""
      echo "Monitor progress with:"
      echo "  open-windows-nvda-vm"
      echo ""
      echo "After Windows boots, run inside Windows:"
      echo "  setup-windows-nvda (shows PowerShell script to install NVDA/browsers)"
    else
      echo "To view and complete manual installation:"
      echo "  open-windows-nvda-vm"
      echo ""
      echo "After Windows installation, run: setup-windows-nvda"
    fi
  '';

  # Script to open the VM
  openWindowsVm = pkgs.writeShellScriptBin "open-windows-nvda-vm" ''
    VM_NAME="windows-nvda-test"
    LIBVIRT_URI="qemu:///system"

    # Check if VM exists
    if ! ${pkgs.libvirt}/bin/virsh --connect "$LIBVIRT_URI" list --all | grep -q "$VM_NAME"; then
      echo "❌ VM '$VM_NAME' not found!"
      echo "Create it first with: create-windows-nvda-vm"
      exit 1
    fi

    # Start VM if not running
    if ! ${pkgs.libvirt}/bin/virsh --connect "$LIBVIRT_URI" list --state-running | grep -q "$VM_NAME"; then
      echo "Starting VM..."
      ${pkgs.libvirt}/bin/virsh --connect "$LIBVIRT_URI" start "$VM_NAME"
      sleep 2
    fi

    # Open with virt-viewer
    ${pkgs.virt-viewer}/bin/virt-viewer --connect "$LIBVIRT_URI" "$VM_NAME" &
  '';

  # Script to remove the VM
  removeWindowsVm = pkgs.writeShellScriptBin "remove-windows-nvda-vm" ''
    VM_NAME="windows-nvda-test"
    VM_DISK="/var/lib/libvirt/images/$VM_NAME.qcow2"
    LIBVIRT_URI="qemu:///system"

    echo "⚠️  This will permanently delete the VM and its disk!"
    read -p "Are you sure? (yes/no): " CONFIRM

    if [ "$CONFIRM" != "yes" ]; then
      echo "Cancelled."
      exit 0
    fi

    # Stop VM if running
    if ${pkgs.libvirt}/bin/virsh --connect "$LIBVIRT_URI" list --state-running | grep -q "$VM_NAME"; then
      echo "Stopping VM..."
      ${pkgs.libvirt}/bin/virsh --connect "$LIBVIRT_URI" destroy "$VM_NAME"
    fi

    # Undefine VM
    if ${pkgs.libvirt}/bin/virsh --connect "$LIBVIRT_URI" list --all | grep -q "$VM_NAME"; then
      echo "Removing VM definition..."
      ${pkgs.libvirt}/bin/virsh --connect "$LIBVIRT_URI" undefine "$VM_NAME" --nvram
    fi

    # Remove disk (requires sudo)
    if [ -f "$VM_DISK" ]; then
      echo "Removing disk image (requires sudo)..."
      sudo rm -f "$VM_DISK"
    fi

    echo "✅ VM removed successfully!"
  '';

  # Script to setup NVDA inside Windows using winget
  setupWindowsNvda = pkgs.writeShellScriptBin "setup-windows-nvda" ''
    cat << 'POWERSHELL'
# Windows NVDA Setup Script using winget
# Run this inside Windows PowerShell (regular user, no admin needed)

Write-Host "=== Windows NVDA Accessibility Testing Setup ===" -ForegroundColor Cyan
Write-Host ""
Write-Host "This script will install:" -ForegroundColor Yellow
Write-Host "  - NVDA Screen Reader"
Write-Host "  - Google Chrome"
Write-Host "  - Mozilla Firefox"
Write-Host ""

# Check if winget is available
if (-not (Get-Command winget -ErrorAction SilentlyContinue)) {
    Write-Host "✗ winget not found!" -ForegroundColor Red
    Write-Host "Please update Windows or install App Installer from the Microsoft Store" -ForegroundColor Yellow
    exit 1
}

Write-Host "Installing NVDA Screen Reader..." -ForegroundColor Yellow
winget install --id NVAccess.NVDA --silent --accept-package-agreements --accept-source-agreements
Write-Host "✓ NVDA installed" -ForegroundColor Green

Write-Host ""
Write-Host "Installing Google Chrome..." -ForegroundColor Yellow
winget install --id Google.Chrome --silent --accept-package-agreements --accept-source-agreements
Write-Host "✓ Chrome installed" -ForegroundColor Green

Write-Host ""
Write-Host "Installing Mozilla Firefox..." -ForegroundColor Yellow
winget install --id Mozilla.Firefox --silent --accept-package-agreements --accept-source-agreements
Write-Host "✓ Firefox installed" -ForegroundColor Green

Write-Host ""
Write-Host "✅ Setup complete!" -ForegroundColor Green
Write-Host ""
Write-Host "=== NVDA Quick Reference ===" -ForegroundColor Cyan
Write-Host ""
Write-Host "Starting NVDA:" -ForegroundColor Yellow
Write-Host "  Ctrl + Alt + N          Start NVDA"
Write-Host ""
Write-Host "Basic Navigation:" -ForegroundColor Yellow
Write-Host "  Insert (or CapsLock)    NVDA modifier key"
Write-Host "  Insert + N              Open NVDA menu"
Write-Host "  Insert + Q              Quit NVDA"
Write-Host "  Insert + S              Toggle speech on/off"
Write-Host ""
Write-Host "Web Navigation:" -ForegroundColor Yellow
Write-Host "  H / Shift+H             Next/Previous heading"
Write-Host "  K / Shift+K             Next/Previous link"
Write-Host "  B / Shift+B             Next/Previous button"
Write-Host "  F / Shift+F             Next/Previous form field"
Write-Host "  Insert + F7             Elements list"
Write-Host ""
Write-Host "Credentials: username 'nvda' / password 'nvda'"
Write-Host ""
Write-Host "Happy testing! 🎉"
POWERSHELL

    echo ""
    echo "📋 Copy the PowerShell script above and run it in Windows!"
    echo ""
    echo "Steps:"
    echo "  1. In Windows, press Win+X → 'Terminal' or 'PowerShell'"
    echo "  2. Paste the script and press Enter"
    echo "  3. Wait for winget to install everything"
    echo ""
  '';

  # Helper script to show status
  statusWindowsVm = pkgs.writeShellScriptBin "status-windows-nvda-vm" ''
    VM_NAME="windows-nvda-test"
    LIBVIRT_URI="qemu:///system"

    echo "=== Windows NVDA VM Status ==="
    echo ""

    if ${pkgs.libvirt}/bin/virsh --connect "$LIBVIRT_URI" list --all 2>/dev/null | grep -q "$VM_NAME"; then
      STATE=$(${pkgs.libvirt}/bin/virsh --connect "$LIBVIRT_URI" domstate "$VM_NAME")
      echo "VM Status: $STATE"

      if [ "$STATE" = "running" ]; then
        echo ""
        echo "VM is running! Connect with:"
        echo "  open-windows-nvda-vm"
      else
        echo ""
        echo "Start the VM with:"
        echo "  open-windows-nvda-vm"
      fi
    else
      echo "VM not found."
      echo ""
      echo "Create it with:"
      echo "  1. prepare-windows-autoinstall  (create auto-install ISO)"
      echo "  2. create-windows-nvda-vm       (create and install VM)"
    fi
    echo ""
  '';

in
{
  options.bhFlake.windowsNvdaVm = {
    enable = lib.mkEnableOption "helper scripts for Windows NVDA testing VM";
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [
      createAutoinstallIso
      createWindowsVm
      openWindowsVm
      removeWindowsVm
      setupWindowsNvda
      statusWindowsVm
      pkgs.p7zip  # Needed for ISO extraction
      pkgs.xorriso  # Needed for ISO creation
    ];
  };
}
