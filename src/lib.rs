use std::collections::HashMap;
use libc::c_char;

/// Free a markdown slide buffer.
#[no_mangle]
pub unsafe extern "C" fn example(buffer: *mut c_char) {
    println!("Yeah");
}

pub fn makeit() {
    // Type inference lets us omit an explicit type signature (which
    // would be `HashMap<String, String>` in this example).
    let mut book_reviews = HashMap::new();

    // Review some books.
    book_reviews.insert(
        "Adventures of Huckleberry Finn".to_string(),
        "My favorite book.".to_string(),
    );

    println!("{:?}", &book_reviews);
}

#[cfg(test)]
mod tests {
    #[test]
    fn it_works() {
        assert_eq!(2 + 2, 4);
    }
}
