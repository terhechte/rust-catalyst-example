#!/bin/bash

# We need the SDK Root
export SDKROOT=`xcrun --sdk macosx --show-sdk-path`

# We will build two different frameworks:
# The first one contains X86_64 iOS (Simulator) and ARM iOS
# The other contains Catalyst ARM and Catalyst X86_64
# Then we tell Xcode to only use the first one for iOS builds, 
# and the second one for macOS builds.
# The reason is that fat binaries can't contain the same architecture
# slice twice (i.e. ARM64 iOS and ARM64 Catalyst)

# Simulator:
echo "Building for iOS X86_64 (Simulator)..."
cargo build -Z build-std --target x86_64-apple-ios --release > /dev/null 2>&1

# X86 Catalyst
# use `cargo build-std` to automatically build the std for non-tier1 platforms
echo "Building for Mac Catalyst X86_64..."
cargo +nightly build -Z build-std --target x86_64-apple-ios-macabi --release > /dev/null 2>&1

# ARM64 Catalyst
echo "Building for Mac Catalyst ARM64..."
cargo +nightly build -Z build-std --target aarch64-apple-ios-macabi --release > /dev/null 2>&1

# iOS
echo "Building for ARM iOS..."
cargo build -Z build-std --target aarch64-apple-ios --release > /dev/null 2>&1


# Build Fat Libraries:
# lipo together the different architectures into a universal 'fat' file

# macOS
echo "Building Fat Libaries"
lipo -create -output XcodeIntegration/XcodeIntegration/Rust/libtest1_mac.a target/{aarch64-apple-ios-macabi,x86_64-apple-ios-macabi}/release/libtest1.a

echo "Wrote XcodeIntegration/XcodeIntegration/Rust/libtest1_ios.a"

# iOS
lipo -create -output XcodeIntegration/XcodeIntegration/Rust/libtest1_ios.a target/{aarch64-apple-ios,x86_64-apple-ios}/release/libtest1.a

echo "Wrote XcodeIntegration/XcodeIntegration/Rust/libtest1_mac.a"
