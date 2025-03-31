#!/usr/bin/env bash

# ensure this git repo is up to date
git pull

# ask for hostname
echo "Enter the hostname for this machine:"
read -r hostname

# ask for disk(s) to install to, and their disko names
# ex; main=/dev/nvme0n1, home=/dev/nvme1n1
echo "Enter the disk(s) to install to, and their disko names."
echo "Example: 'main=/dev/nvme0n1;home=/dev/nvme1n1'"
read -r diskstring # read into an array
IFS=';' read -r -a diskpairs <<< "$diskstring"
declare -A disks
for diskpair in "${diskpairs[@]}"; do
  diskname=$(echo "$diskpair" | cut -d'=' -f1)
  diskpath=$(echo "$diskpair" | cut -d'=' -f2)
  disks["$diskname"]="$diskpath"
done


# Debug, print all variables
echo "Printing config to be installed!!"
echo "Hostname: $hostname"
echo "Disks:"
for diskname in "${!disks[@]}"; do
    echo "    ${diskname}: ${disks[$diskname]}"
done

# Ask for confirmation
echo ""
echo "The above configuration will be installed. Continue? (y/n)"
read -r confirm
if [ "$confirm" != "y" ]; then
    echo "Exiting..."
    exit 1
fi

# Remove the existing tmp/config/etc/nixos directory
sudo rm -rf /tmp/config/etc/nixos
if ! sudo rm -rf /tmp/config/etc/nixos; then
    echo "Failed to remove the existing /tmp/config/etc/nixos directory"
    exit 1
fi

# clone this repository into /tmp/config/etc/nixos
# git clone https://github.com/CWRUnix/nixos /tmp/config/etc/

if ! git clone https://github.com/CWRUnix/nixos /tmp/config/etc/nixos; then
    echo "Failed to clone the repository"
    exit 1
fi 

# Calculate disks args
disks_args=""
for diskname in "${!disks[@]}"; do
    disks_args="$disks_args --disk $diskname ${disks[$diskname]}"
done

# Final confirmation
echo "The following command will be run:"
echo "sudo nix run 'github:nix-community/disko/latest#disko-install' -- --flake '/tmp/config/etc/nixos#$hostname' --write-efi-boot-entries $disks_args"
echo "Continue? (y/n)"
read -r confirmagain
if [ "$confirmagain" != "y" ]; then
    echo "Exiting..."
    exit 1
fi
# Run Disko install
sudo nix \
  --extra-experimental-features "nix-command flakes" \
  run 'github:nix-community/disko/latest#disko-install' \
  -- --flake "/tmp/config/etc/nixos#${hostname}"\
  --write-efi-boot-entries \ # write efi boot entries
  "$disks_args"
