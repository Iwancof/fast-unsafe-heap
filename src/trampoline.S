.text

.global super_malloc
.global super_free

.global super_malloc_ptr
.global super_free_ptr

.globl malloc_trampoline
.type malloc_trampoline, @function
malloc_trampoline: 
  jmp *super_malloc_ptr

.global malloc_trampoline_size
malloc_trampoline_size:
.quad .-malloc_trampoline # FIXME(support 32-bit)
  

.global free_trampoline
.type free_trampoline, @function
free_trampoline:
  jmp *super_free_ptr

.global free_trampoline_size
free_trampoline_size:
# .size free_trampoline, .-free_trampoline
.quad .-free_trampoline # FIXME(same)

