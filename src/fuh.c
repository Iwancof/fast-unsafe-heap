#include <gelf.h>
#include <malloc.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/auxv.h>
#include <sys/mman.h>
#include <unistd.h>

extern void *malloc(size_t s);
extern void free(void *p);

extern void malloc_trampoline();
extern void free_trampoline();

void *super_malloc(size_t size);
void super_free(void *free);

static void *(*super_malloc_ptr)(size_t);
static void (*super_free_ptr)(void *);

extern size_t malloc_trampoline_size, free_trampoline_size;

void *super_heap;

void *const SUPER_HEAP_START_ADDR = (void *)0xdead0000;
const size_t ALLOCATE_ALIGN = 0x10;

__attribute__((constructor)) void allocate_super_heap() {
  super_heap = mmap(SUPER_HEAP_START_ADDR, 0x100000, PROT_READ | PROT_WRITE,
                    MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);

  if (super_heap != SUPER_HEAP_START_ADDR) {
    perror("Could not allocate super heap");
  }

  super_malloc_ptr = super_malloc;
  super_free_ptr = super_free;
}

void *super_malloc(size_t size) {
  super_heap += size + ALLOCATE_ALIGN;
  super_heap = (void *)((size_t)super_heap & ~ALLOCATE_ALIGN);

  return super_heap;
}
void super_free(void *free) {
  // nothing here.
}

static size_t get_page_mask(size_t page_size) {
  return ~((size_t)page_size - 1);
}
static void *get_page_top(size_t page_mask, void *addr) {
  return (void *)(page_mask & (size_t)addr);
}

static void get_including_page(void *addr, size_t size, void **first,
                               size_t *length) {
  size_t page_size = getpagesize();
  size_t mask = get_page_mask(page_size);

  *first = get_page_top(mask, addr);

  void *end = get_page_top(mask, addr + size) + page_size;

  *length = end - *first;
}

int main() {
  void *first;
  size_t size;

  get_including_page(malloc, 0x100, &first, &size);
  mprotect(first, size, PROT_EXEC | PROT_READ | PROT_WRITE);

  memcpy((void *)malloc, (const void *)malloc_trampoline,
         malloc_trampoline_size);

  void *ptr = malloc(0x100);

  printf("ptr = %p, super_heap = %p\n", ptr, super_heap);
}
