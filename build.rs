extern crate cbindgen;

use std::env;

fn main() {
    let crate_dir = env::var("CARGO_MANIFEST_DIR").unwrap();
    let filename = "XcodeIntegration/XcodeIntegration/Rust/test1_rust.h";

    let _build = cbindgen::Builder::new()
        .with_crate(crate_dir)
        .with_config(cbindgen::Config::from_file("cbindgen.toml").unwrap())
        .generate()
        .expect("Unable to generate bindings")
        .write_to_file(filename);
}
