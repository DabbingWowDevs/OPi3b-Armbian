#!/bin/bash
tag="opi3b-v20260114010316"
assets=$(gh release view $tag --repo DabbingWowDevs/OPi3b-Armbian --json assets -q '.assets[].name')
AVer=""
edge_kver=""
vendor_kver=""
for asset in $assets; do
  if [ -z "$AVer" ]; then
    AVer=$(echo $asset | sed 's/armbian-[^-]*-[^-]*-[^-]*-//' | sed 's/-\(edge\|vendor\)-.*//')
  fi
  kver=$(echo $asset | sed 's/.*-\(edge\|vendor\)-\([^-]*\)-.*-.*/\2/')
  kernel_type=$(echo $asset | sed 's/.*-\(edge\|vendor\)-\([^-]*\)-.*-.*/\1/')
  if [[ $kernel_type == "edge" ]]; then
    edge_kver=$kver
  elif [[ $kernel_type == "vendor" ]]; then
    vendor_kver=$kver
  fi
done
body="Armbian Version: $AVer
Kernel Versions:
- Edge: $edge_kver
- Vendor: $vendor_kver"
gh release edit $tag --repo DabbingWowDevs/OPi3b-Armbian --notes "$body" 
