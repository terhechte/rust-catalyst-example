#!/bin/bash

# lipo together the different architectures into a universal 'fat' file
xargo build --target x86_64-apple-ios-macabi --release
xargo build --target aarch64-apple-ios --release
lipo -create -output target/libtest1.a target/{x86_64-apple-darwin,aarch64-apple-ios,x86_64-apple-darwin}/release/libtest1.a
