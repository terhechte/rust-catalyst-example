#!/bin/bash

# We need the SDK Root
export SDKROOT=`xcrun --sdk macosx --show-sdk-path`

# lipo together the different architectures into a universal 'fat' file
# use `cargo build-std` to automatically build the std for non-tier1 platforms
# such as catalyst
cargo +nightly build -Z build-std --target x86_64-apple-ios-macabi --release
cargo build --target aarch64-apple-ios --release
lipo -create -output target/libtest1.a target/{aarch64-apple-ios,x86_64-apple-ios-macabi}/release/libtest1.a
