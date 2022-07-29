use std::alloc::{GlobalAlloc, Layout};

extern crate libc;

extern "C" {
    fn fuh_init(size: libc::size_t);
    fn fuh_alloc(size: libc::size_t, align: libc::size_t) -> *const libc::c_void;
    fn fuh_dealloc(ptr: *const libc::c_void);
}

pub struct FastUnsafeHeap;

unsafe impl GlobalAlloc for FastUnsafeHeap {
    unsafe fn alloc(&self, layout: Layout) -> *mut u8 {
        fuh_alloc(layout.size(), layout.align()) as _
    }

    unsafe fn dealloc(&self, ptr: *mut u8, _layout: Layout) {
        fuh_dealloc(ptr as _);
    }
}

pub fn init(size: usize) {
    unsafe {
        fuh_init(size as _);
    }
}
