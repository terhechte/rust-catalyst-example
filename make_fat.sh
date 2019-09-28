#!/bin/bash

# lipo together the different architectures into a universal 'fat' file
#xargo build --target x86_64-apple-ios-macabi --release
#xargo build --target aarch64-apple-ios --release
#xargo build --target x86_64-apple-ios --release

set -x

xcodebuild -create-xcframework \
  -library target/aarch64-apple-ios/release/libtest1.a -headers test1_rust.h \
  -library target/x86_64-apple-ios-macabi/release/libtest1.a -headers test1_rust.h \
  -library target/x86_64-apple-ios/release/libtest1.a -headers test1_rust.h \
  -output test1.xcframework

set +x

