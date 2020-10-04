# Rust Catalyst Example

This is an example that shows how to build a static library supporting Mac Catalyst (X86_64 and ARM64) from Rust.


# Usage

Until [this PR that adds Catalyst ARM64 support to Rust](https://github.com/rust-lang/rust/pull/77484) is merged, you need to build the Rust compiler. Hence, jump to the end to see how to build and use a custom Rust toolchain based on 77484.

This repo contains an Xcode project that sets up everything to include a library written in Rust and call functions in it. The repo is set up to use ARM64 and X86_64 Catalyst. It should compile fine if you select the `My Mac` target. If you select the `Any Mac` target, it requires the above mentioned PR / a custom toolchain.

The Xcode project also contains all the required binaries to try this out immediately. You can just open `XcodeIntegration.xcodeproj` and build.

# Usage with normal nightly Rust


## Requirements

1. Rustup / Rust Nightly
2. Xcode 12

## Full Local Installation

``` bash
rustup toolchain install nightly
rustup toolchain default nightly
rustup target add aarch64-apple-ios
rustup target add x86_64-apple-ios

# Or use a directory override
rustup override set nightly

./make_fat.sh
```

It will automatically generate the binaries and write them to `XcodeIntegration/Rust`

Open Xcode, hit compile.

### build-std

Catalyst is not a tier 1 Rust platform, so there is no pre-build standard library. This repository uses `cargo build-std` to automatically build the standard library for the given platform. This takes a bit longer but works reliably (at least for me).

## Custom Rust Toolchain

```
git clone https://github.com/rust-lang/rust.git
cd rust
cp config.toml.sample config.toml
```

Edit config.toml and change `build-stage = 1` to `build-stage = 2` (line 149)
                                                 
```                             
./x.py build 
```                        
             
Install with
```
rustup toolchain link myrust ~/rust/build/x86_64-apple-darwin/stage2/
```

Go back to this directory
```
rustup default myrust
```

Now you can continue with (Full Local Installation) above.

