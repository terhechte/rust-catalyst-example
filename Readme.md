# Rust Catalyst Example

This is an example that shows how to build a static library supporting Catalyst from Rust.

## Requirements

1. [Xargo](https://github.com/japaric/xargo)
2. Rust Nightly
3. Rust Source (after switching to nightly)
4. Xcode 11+

## Not Required
- the `XARGO_RUST_SRC` env variable

## Full Local Installation

``` bash
cargo install xargo
rustup toolchain install nightly
rustup toolchain default nightly

# Or use a directory override
rustup override set nightly
```

## Using It

Just do a release build with the correct target

``` bash
xargo build --target x86_64-apple-ios-macabi --release
```

## Caveats

- Building for other archs (such as the host arch) also requires setting the target.
- Non-Release builds fail on some targets
- Lipo can be used to make a fat binary (see below)

## Fat Binary

This requires that the correct targets are installed for non-macabi:

``` bash
rustup target add aarch64-apple-ios
```

Then the following will generate a fat binary. You can also just call the `make_fat.sh` included in the example project.

``` bash
# lipo together the different architectures into a universal 'fat' file
xargo build --target x86_64-apple-ios-macabi --release
xargo build --target aarch64-apple-ios --release
lipo -create -output target/libtest1.a target/{x86_64-apple-darwin,aarch64-apple-ios,x86_64-apple-darwin}/release/libtest1.a
```

Note that we're not including `x86_64-apple-darwin` because a fat binary cannot contain darwing x86_64 and iOS x86_64 together.
