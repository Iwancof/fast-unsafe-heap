#include <stdio.h>
#include <sys/mman.h>
#include <unistd.h>

static void *heap_front;

static void fuh_init(size_t);

static __attribute__((constructor)) void fuh_default_init() {
  fuh_init(0x1000);
}

static size_t alignment(size_t val, size_t align) {
  return (val + (align - 1)) & ~(align - 1);
}

void fuh_init(size_t allocate_size) {
  size_t page_size = getpagesize();
  size_t size = alignment(allocate_size, page_size);
  heap_front = mmap(NULL, size, PROT_EXEC | PROT_READ | PROT_WRITE,
                    MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
}

void *fuh_alloc(size_t size, size_t align) {
  void *ret = heap_front = (void *)alignment((size_t)heap_front, align);
  heap_front += size;

  return ret;
}

void fuh_dealloc(void *ptr) {}
