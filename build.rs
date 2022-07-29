extern crate cc;

fn main() {
    cc::Build::new()
        .warnings(true)
        .flag("-Wall")
        .flag("-Wextra")
        .flag("-v")
        .file("src/fuh.c")
        .compile("libfuh.a");
}
