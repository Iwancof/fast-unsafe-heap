	.file	"fuh.c"
	.text
	.globl	super_heap
	.bss
	.align 8
	.type	super_heap, @object
	.size	super_heap, 8
super_heap:
	.zero	8
	.globl	SUPER_HEAP_START_ADDR
	.section	.rodata
	.align 8
	.type	SUPER_HEAP_START_ADDR, @object
	.size	SUPER_HEAP_START_ADDR, 8
SUPER_HEAP_START_ADDR:
	.quad	3735879680
	.globl	ALLOCATE_ALIGN
	.align 8
	.type	ALLOCATE_ALIGN, @object
	.size	ALLOCATE_ALIGN, 8
ALLOCATE_ALIGN:
	.quad	16
.LC0:
	.string	"Could not allocate super heap"
	.text
	.globl	allocate_super_heap
	.type	allocate_super_heap, @function
allocate_super_heap:
.LFB6:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movl	$3735879680, %eax
	movl	$0, %r9d
	movl	$-1, %r8d
	movl	$34, %ecx
	movl	$3, %edx
	movl	$1048576, %esi
	movq	%rax, %rdi
	call	mmap@PLT
	movq	%rax, super_heap(%rip)
	movq	super_heap(%rip), %rdx
	movl	$3735879680, %eax
	cmpq	%rax, %rdx
	je	.L3
	leaq	.LC0(%rip), %rax
	movq	%rax, %rdi
	call	perror@PLT
.L3:
	nop
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE6:
	.size	allocate_super_heap, .-allocate_super_heap
	.section	.init_array,"aw"
	.align 8
	.quad	allocate_super_heap
	.text
	.type	super_malloc, @function
super_malloc:
.LFB7:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movq	%rdi, -8(%rbp)
	movq	super_heap(%rip), %rax
	movl	$16, %ecx
	movq	-8(%rbp), %rdx
	addq	%rcx, %rdx
	addq	%rdx, %rax
	movq	%rax, super_heap(%rip)
	movl	$16, %eax
	notq	%rax
	movq	%rax, %rdx
	movq	super_heap(%rip), %rax
	andq	%rdx, %rax
	movq	%rax, super_heap(%rip)
	movq	super_heap(%rip), %rax
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE7:
	.size	super_malloc, .-super_malloc
	.type	super_free, @function
super_free:
.LFB8:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movq	%rdi, -8(%rbp)
	nop
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE8:
	.size	super_free, .-super_free
	.type	get_page_mask, @function
get_page_mask:
.LFB9:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movq	%rdi, -8(%rbp)
	movq	-8(%rbp), %rax
	negq	%rax
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE9:
	.size	get_page_mask, .-get_page_mask
	.type	get_page_top, @function
get_page_top:
.LFB10:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	movq	-16(%rbp), %rax
	andq	-8(%rbp), %rax
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE10:
	.size	get_page_top, .-get_page_top
	.type	get_including_page, @function
get_including_page:
.LFB11:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$64, %rsp
	movq	%rdi, -40(%rbp)
	movq	%rsi, -48(%rbp)
	movq	%rdx, -56(%rbp)
	movq	%rcx, -64(%rbp)
	call	getpagesize@PLT
	cltq
	movq	%rax, -24(%rbp)
	movq	-24(%rbp), %rax
	movq	%rax, %rdi
	call	get_page_mask
	movq	%rax, -16(%rbp)
	movq	-40(%rbp), %rdx
	movq	-16(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	get_page_top
	movq	-56(%rbp), %rdx
	movq	%rax, (%rdx)
	movq	-40(%rbp), %rdx
	movq	-48(%rbp), %rax
	addq	%rax, %rdx
	movq	-16(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	get_page_top
	movq	-24(%rbp), %rdx
	addq	%rdx, %rax
	movq	%rax, -8(%rbp)
	movq	-56(%rbp), %rax
	movq	(%rax), %rax
	movq	-8(%rbp), %rdx
	subq	%rax, %rdx
	movq	-64(%rbp), %rax
	movq	%rdx, (%rax)
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE11:
	.size	get_including_page, .-get_including_page
	.section	.rodata
	.align 8
.LC1:
	.string	"malloc at %p. including page is (%p, %lx)\n"
.LC2:
	.string	"sizeof super_malloc = %lx\n"
	.text
	.globl	main
	.type	main, @function
main:
.LFB12:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$32, %rsp
	movq	%fs:40, %rax
	movq	%rax, -8(%rbp)
	xorl	%eax, %eax
	leaq	-16(%rbp), %rdx
	leaq	-24(%rbp), %rax
	movq	%rdx, %rcx
	movq	%rax, %rdx
	movl	$256, %esi
	movq	malloc@GOTPCREL(%rip), %rax
	movq	%rax, %rdi
	call	get_including_page
	movq	-16(%rbp), %rdx
	movq	-24(%rbp), %rax
	movq	%rdx, %rcx
	movq	%rax, %rdx
	movq	malloc@GOTPCREL(%rip), %rax
	movq	%rax, %rsi
	leaq	.LC1(%rip), %rax
	movq	%rax, %rdi
	movl	$0, %eax
	call	printf@PLT
	movq	-16(%rbp), %rcx
	movq	-24(%rbp), %rax
	movl	$7, %edx
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	mprotect@PLT
	movl	$1, %esi
	leaq	.LC2(%rip), %rax
	movq	%rax, %rdi
	movl	$0, %eax
	call	printf@PLT
	movl	$0, %eax
	call	external@PLT
	movl	$0, %eax
	movq	-8(%rbp), %rdx
	subq	%fs:40, %rdx
	je	.L14
	call	__stack_chk_fail@PLT
.L14:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE12:
	.size	main, .-main
	.ident	"GCC: (GNU) 12.1.0"
	.section	.note.GNU-stack,"",@progbits
