#!/bin/sh
#
# Written by: Robin Gierse - info@thorian93.de - on 20200501
#
# Purpose:
# This script copies an existing VM to a new one.
#
# Version: 1.0 on 20200501
#
# Usage:
# ./CloneVM.sh -s SOURCE_VM -d DESTINATION_VM

set -e

while getopts ":s:d:" opt; do
  case $opt in
    s)
      vm_source="$OPTARG"
      echo "Source VM name: $OPTARG" >&2
      ;;
    d)
      vm_dest="$OPTARG"
      echo "Destination VM name: $OPTARG" >&2
      ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      exit 1
      ;;
    :)
      echo "Option -$OPTARG requires an argument." >&2
      exit 1
      ;;
  esac
done

echo "Cloning VM:"
cp -r $vm_source $vm_dest
cd $vm_dest || exit 1

echo "Renaming VM:"
find ./ -type f -name "*$vm_source*" | sed -e "p;s/$vm_source/$vm_dest/" | xargs -n2 mv
sed -i "s/$vm_source/$vm_dest/g" "$vm_dest.vmdk"
sed -i "s/$vm_source/$vm_dest/g" "$vm_dest.vmx"
sed -i "s/$vm_source/$vm_dest/g" "./*.log"

echo "All done:"
ls -lah