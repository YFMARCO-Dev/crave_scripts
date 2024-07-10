#!/bin/bash

rm -rf .repo/local_manifests/

# Rom source repo
repo init --depth=1 -u https://github.com/RisingTechOSS/android -b fourteen --git-lfs
echo "=================="
echo "Repo init success"
echo "=================="

# Clone local_manifests repository
git clone -b rising https://github.com/ij-israfil/local_manifests .repo/local_manifests
echo "============================"
echo "Local manifest clone success"
echo "============================"

#Remove clang
rm -rf prebuilts/clang/host/linux-x86

# Sync the repositories
/opt/crave/resync.sh
echo "============================"

# Export
export BUILD_USERNAME=ij-israfil
export BUILD_HOSTNAME=crave
echo "======= Export Done ======"

# Set up build environment
source build/envsetup.sh
echo "====== Envsetup Done ======="

# Lunch
lunch lineage_RMX1901-ap2a-user
echo "============="

# Make cleaninstall
make installclean
echo "============="

# Build rom
rise b
