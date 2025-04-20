#!/usr/bin/env bash

# Opens screen lock settings.
#
# Resize window:
#
# wmctrl -r "Settings" -e 0,100,100,800,600
#
# Get names of open windows:
#
# wmctrl -l

# isodate=$(date -I)
# delay=3
# 
# # 1. Screenshot proving you have up-to-date anti-virus software installed and running.
# gnome-text-editor -s /home/ctorgalson/last-clamscan.log & \
#   sleep "$delay" && \
#   gnome-screenshot -w -f "./lastclamscan-${isodate}.png" && \
#   pkill -f gnome-text-editor
# 
# # 2. Screenshot proving that disk encryption is enabled on your device.
# 
# # 3. Screenshot proving your OS and browser software is up to date
# 
# # 4. Screenshot showing that you have auto-screen-lock enabled with it set to come on after 5 minutes of inactivity.
# gnome-control-center privacy screenlock & \
#   sleep "$delay" && \
#   gnome-screenshot -w -f "./screenlock-${isodate}.png" && \
#   pkill -f gnome-control-center

function indent_multiline () {
  local indent="${2:-2}"
  local pattern="%${indent}s\n"

  echo $indent
  echo $pattern

  while IFS= read -r line; do
    printf "$pattern" "$line"
  done <<< "$1"
}

clear

echo
echo "  SYSTEM"
echo
indent_multiline "$(fastfetch --logo-type none)" "4"
echo

echo "  BROWSERS"
echo
printf "    Firefox: %s\n" "$(firefox --version)"
printf "    Chrome: %s\n" "$(google-chrome-stable --version)"
echo

echo "  ANTIVIRUS"
echo
printf "    clamscan: %s\n" "$(clamscan --version)"
printf "    freshclam: %s\n" "$(freshclam --version)"
indent_multiline "$(cat ~/last-clamscan.log)"
echo

disks="$(lsblk -o NAME,FSTYPE,TYPE,MOUNTPOINT --raw --noheadings | grep ext4 | sort --reverse)"

echo "  DISKS"
echo
while read -r line; do
  name="$(echo "$line" | cut -d' ' -f1)"
  mount="$(echo "$line" | cut -d' ' -f4)"
  type="$(echo "$line" | cut -d' ' -f3)"
  state="$([[ "$type" == "crypt" ]] && echo "encrypted" || echo "unencrypted")"
  
  printf "    %s: %s\n" "$mount" "$state"
done <<< "$disks"
echo

lock_enabled="$(gsettings get org.gnome.desktop.screensaver lock-enabled)"
idle_delay="$(gsettings get org.gnome.desktop.session idle-delay | cut -d' ' -f2)"

echo "  SCREEN LOCK"
echo
printf "    Screen lock enabled: %s\n" "$lock_enabled"
printf "    Screen lock delay: %s minutes\n" "$(( idle_delay / 60 ))"

# # Get a list of currently mounted LUKS encrypted partitions
# echo "Currently mounted non-swap LUKS encrypted partitions:"
# 
# # Use lsblk to find mounted partitions and filter for LUKS
# lsblk -o NAME,FSTYPE,MOUNTPOINT | grep -E 'luks|crypto_LUKS' | while read -r line; do
#     echo "$line"
#     if [[ ! "$line" =~ "luks" ]]; then
#         continue
#     fi
# 
#     echo "($line)"
#     device=$(cut -d ' ' -f 1)
# 
#     #echo "device: $device"
# 
# 
# 
#     # # Extract the device name and mount point
#     # device="${line%% *}"  # Get the first word (device name)
#     # mountpoint="${line##* }"  # Get the last word (mount point)
# 
#     # # Trim leading non-letter characters from the device name
#     # device="${device##*[!a-zA-Z0-9]}"  # Remove leading non-alphanumeric characters
# 
#     # # Check if the device is mounted and not a swap
#     # if [[ "$mountpoint" != "" ]]; then
#     #     # Check if the device is a LUKS device
#     #     if sudo cryptsetup isLuks "/dev/$device"; then
#     #         echo "Device: /dev/$device is mounted at $mountpoint"
#     #     fi
#     # fi
# done
