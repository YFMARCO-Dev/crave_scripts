#!/bin/bash

rm -rf .repo/local_manifests/

# Rom source repo
repo init -u --depth=1 https://github.com/ProjectPixelage/android_manifest.git -b 15 --git-lfs
echo "=================="
echo "Repo init success"
echo "=================="

# Clone local_manifests repository
git clone -b pixelage https://github.com/ij-israfil/local_manifests .repo/local_manifests
echo "============================"
echo "Local manifest clone success"
echo "============================"

# Sync the repositories
/opt/crave/resync.sh
echo "============================"

# Export
export BUILD_USERNAME=ij-israfil
export BUILD_HOSTNAME=crave
export PIXELAGE_BUILD=RMX1901
echo "======= Export Done ======"

# Set up build environment
source build/envsetup.sh
echo "====== Envsetup Done ======="

# Lunch
lunch pixelage_RMX1901-ap3a-user
echo "============="

# Make cleaninstall
make installclean
echo "============="

# Build rom
make bacon