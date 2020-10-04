use std::os::raw::c_void;
use std::slice;
use std::str;

#[no_mangle]
pub unsafe extern "C" fn example(
    swift_string: *const c_void,
    len: usize
    ) {
    let bytes: &[u8] = slice::from_raw_parts(swift_string as *mut u8 as _, len);
    let string = str::from_utf8_unchecked(&bytes);
    println!("String: {}", &string);
}

