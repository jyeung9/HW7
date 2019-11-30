	.file	"um2.c"
	.text
	.comm	registers,32,32
	.comm	prog_counter,4,4
	.comm	MAPPED,8,8
	.globl	LOAD_VAL
	.section	.rodata
	.align 4
	.type	LOAD_VAL, @object
	.size	LOAD_VAL, 4
LOAD_VAL:
	.long	1056964608
	.comm	CURR_LEN,4,4
	.comm	CAPACITY,4,4
	.comm	UNMAPPED,8,8
	.comm	UCURR_LEN,4,4
	.comm	UCAPACITY,4,4
.LC0:
	.string	"um2.c"
.LC1:
	.string	"bits <= 64"
	.text
	.type	shl, @function
shl:
.LFB2:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	movq	%rdi, -8(%rbp)
	movl	%esi, -12(%rbp)
	cmpl	$64, -12(%rbp)
	jbe	.L2
	movl	$__PRETTY_FUNCTION__.3879, %ecx
	movl	$182, %edx
	movl	$.LC0, %esi
	movl	$.LC1, %edi
	call	__assert_fail
.L2:
	cmpl	$64, -12(%rbp)
	jne	.L3
	movl	$0, %eax
	jmp	.L4
.L3:
	movl	-12(%rbp), %eax
	movq	-8(%rbp), %rdx
	movl	%eax, %ecx
	salq	%cl, %rdx
	movq	%rdx, %rax
.L4:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE2:
	.size	shl, .-shl
	.type	shr, @function
shr:
.LFB3:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	movq	%rdi, -8(%rbp)
	movl	%esi, -12(%rbp)
	cmpl	$64, -12(%rbp)
	jbe	.L6
	movl	$__PRETTY_FUNCTION__.3884, %ecx
	movl	$194, %edx
	movl	$.LC0, %esi
	movl	$.LC1, %edi
	call	__assert_fail
.L6:
	cmpl	$64, -12(%rbp)
	jne	.L7
	movl	$0, %eax
	jmp	.L8
.L7:
	movl	-12(%rbp), %eax
	movq	-8(%rbp), %rdx
	movl	%eax, %ecx
	shrq	%cl, %rdx
	movq	%rdx, %rax
.L8:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE3:
	.size	shr, .-shr
	.type	Bitpack_fitsu, @function
Bitpack_fitsu:
.LFB4:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	movq	%rdi, -8(%rbp)
	movl	%esi, -12(%rbp)
	cmpl	$63, -12(%rbp)
	jbe	.L10
	movl	$1, %eax
	jmp	.L11
.L10:
	movl	-12(%rbp), %edx
	movq	-8(%rbp), %rax
	movl	%edx, %esi
	movq	%rax, %rdi
	call	shr
	testq	%rax, %rax
	sete	%al
.L11:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE4:
	.size	Bitpack_fitsu, .-Bitpack_fitsu
	.section	.rodata
.LC2:
	.string	"hi <= 64"
	.text
	.type	Bitpack_getu, @function
Bitpack_getu:
.LFB5:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	pushq	%rbx
	subq	$40, %rsp
	.cfi_offset 3, -24
	movq	%rdi, -40(%rbp)
	movl	%esi, -44(%rbp)
	movl	%edx, -48(%rbp)
	movl	-48(%rbp), %edx
	movl	-44(%rbp), %eax
	addl	%edx, %eax
	movl	%eax, -20(%rbp)
	cmpl	$64, -20(%rbp)
	jbe	.L13
	movl	$__PRETTY_FUNCTION__.3895, %ecx
	movl	$214, %edx
	movl	$.LC0, %esi
	movl	$.LC2, %edi
	call	__assert_fail
.L13:
	movl	$64, %eax
	subl	-44(%rbp), %eax
	movl	%eax, %ebx
	movl	$64, %eax
	subl	-20(%rbp), %eax
	movl	%eax, %edx
	movq	-40(%rbp), %rax
	movl	%edx, %esi
	movq	%rax, %rdi
	call	shl
	movl	%ebx, %esi
	movq	%rax, %rdi
	call	shr
	addq	$40, %rsp
	popq	%rbx
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE5:
	.size	Bitpack_getu, .-Bitpack_getu
	.section	.rodata
.LC3:
	.string	"0"
	.text
	.type	Bitpack_newu, @function
Bitpack_newu:
.LFB6:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	pushq	%r12
	pushq	%rbx
	subq	$48, %rsp
	.cfi_offset 12, -24
	.cfi_offset 3, -32
	movq	%rdi, -40(%rbp)
	movl	%esi, -44(%rbp)
	movl	%edx, -48(%rbp)
	movq	%rcx, -56(%rbp)
	movl	-48(%rbp), %edx
	movl	-44(%rbp), %eax
	addl	%edx, %eax
	movl	%eax, -20(%rbp)
	cmpl	$64, -20(%rbp)
	jbe	.L16
	movl	$__PRETTY_FUNCTION__.3903, %ecx
	movl	$224, %edx
	movl	$.LC0, %esi
	movl	$.LC2, %edi
	call	__assert_fail
.L16:
	movl	-44(%rbp), %edx
	movq	-56(%rbp), %rax
	movl	%edx, %esi
	movq	%rax, %rdi
	call	Bitpack_fitsu
	xorl	$1, %eax
	testb	%al, %al
	je	.L17
	movl	$__PRETTY_FUNCTION__.3903, %ecx
	movl	$226, %edx
	movl	$.LC0, %esi
	movl	$.LC3, %edi
	call	__assert_fail
.L17:
	movl	-20(%rbp), %edx
	movq	-40(%rbp), %rax
	movl	%edx, %esi
	movq	%rax, %rdi
	call	shr
	movq	%rax, %rdx
	movl	-20(%rbp), %eax
	movl	%eax, %esi
	movq	%rdx, %rdi
	call	shl
	movq	%rax, %r12
	movl	$64, %eax
	subl	-48(%rbp), %eax
	movl	%eax, %ebx
	movl	$64, %eax
	subl	-48(%rbp), %eax
	movl	%eax, %edx
	movq	-40(%rbp), %rax
	movl	%edx, %esi
	movq	%rax, %rdi
	call	shl
	movl	%ebx, %esi
	movq	%rax, %rdi
	call	shr
	movq	%r12, %rsi
	orq	%rax, %rsi
	movl	-48(%rbp), %eax
	movq	-56(%rbp), %rdx
	movl	%eax, %ecx
	salq	%cl, %rdx
	movq	%rdx, %rax
	orq	%rsi, %rax
	addq	$48, %rsp
	popq	%rbx
	popq	%r12
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE6:
	.size	Bitpack_newu, .-Bitpack_newu
	.type	word_num, @function
word_num:
.LFB7:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$176, %rsp
	movq	%rdi, -168(%rbp)
	leaq	-160(%rbp), %rdx
	movq	-168(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	stat
	movq	-112(%rbp), %rax
	movl	%eax, -4(%rbp)
	movl	-4(%rbp), %eax
	leal	3(%rax), %edx
	testl	%eax, %eax
	cmovs	%edx, %eax
	sarl	$2, %eax
	movl	%eax, -8(%rbp)
	movl	-8(%rbp), %eax
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE7:
	.size	word_num, .-word_num
	.section	.rodata
	.align 8
.LC4:
	.string	"Invalid format\nCorrect usage: \"./um [filename]\"\n"
.LC5:
	.string	"r"
	.text
	.globl	main
	.type	main, @function
main:
.LFB8:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$32, %rsp
	movl	%edi, -20(%rbp)
	movq	%rsi, -32(%rbp)
	cmpl	$2, -20(%rbp)
	jg	.L22
	cmpl	$1, -20(%rbp)
	jg	.L23
.L22:
	movq	stderr(%rip), %rax
	movq	%rax, %rcx
	movl	$48, %edx
	movl	$1, %esi
	movl	$.LC4, %edi
	call	fwrite
	movl	$1, %edi
	call	exit
.L23:
	movq	-32(%rbp), %rax
	movq	8(%rax), %rax
	movq	%rax, -8(%rbp)
	movq	-8(%rbp), %rax
	movl	$.LC5, %esi
	movq	%rax, %rdi
	call	fopen
	movq	%rax, -16(%rbp)
	cmpq	$0, -16(%rbp)
	je	.L24
	movq	-8(%rbp), %rax
	movq	%rax, %rdi
	call	word_num
	movl	%eax, %edx
	movq	-16(%rbp), %rax
	movl	%edx, %esi
	movq	%rax, %rdi
	call	init_um
	movq	-16(%rbp), %rax
	movq	%rax, %rdi
	call	fclose
	movl	$0, %eax
	call	run_program
	movl	$0, %edi
	call	exit
.L24:
	movq	stderr(%rip), %rax
	movq	%rax, %rcx
	movl	$48, %edx
	movl	$1, %esi
	movl	$.LC4, %edi
	call	fwrite
	movl	$1, %edi
	call	exit
	.cfi_endproc
.LFE8:
	.size	main, .-main
	.section	.rodata
.LC6:
	.string	"input != ((void *)0)"
.LC7:
	.string	"words > 0"
.LC8:
	.string	"seg != ((void *)0)"
	.text
	.type	init_um, @function
init_um:
.LFB9:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$48, %rsp
	movq	%rdi, -40(%rbp)
	movl	%esi, -44(%rbp)
	cmpq	$0, -40(%rbp)
	jne	.L27
	movl	$__PRETTY_FUNCTION__.3920, %ecx
	movl	$286, %edx
	movl	$.LC0, %esi
	movl	$.LC6, %edi
	call	__assert_fail
.L27:
	movl	$0, prog_counter(%rip)
	movl	$0, -4(%rbp)
	jmp	.L28
.L29:
	movl	-4(%rbp), %eax
	cltq
	movl	$0, registers(,%rax,4)
	addl	$1, -4(%rbp)
.L28:
	cmpl	$7, -4(%rbp)
	jle	.L29
	cmpl	$0, -44(%rbp)
	jg	.L30
	movl	$__PRETTY_FUNCTION__.3920, %ecx
	movl	$300, %edx
	movl	$.LC0, %esi
	movl	$.LC7, %edi
	call	__assert_fail
.L30:
	movl	-44(%rbp), %eax
	cltq
	addq	$1, %rax
	salq	$2, %rax
	movq	%rax, %rdi
	call	malloc
	movq	%rax, -24(%rbp)
	cmpq	$0, -24(%rbp)
	jne	.L31
	movl	$__PRETTY_FUNCTION__.3920, %ecx
	movl	$304, %edx
	movl	$.LC0, %esi
	movl	$.LC8, %edi
	call	__assert_fail
.L31:
	movq	-24(%rbp), %rax
	movl	-44(%rbp), %edx
	movl	%edx, (%rax)
	movl	$0, -8(%rbp)
	jmp	.L32
.L35:
	movl	$0, -12(%rbp)
	movl	$24, -16(%rbp)
	jmp	.L33
.L34:
	movq	-40(%rbp), %rax
	movq	%rax, %rdi
	call	_IO_getc
	movl	%eax, -28(%rbp)
	movl	-28(%rbp), %eax
	movl	%eax, %ecx
	movl	-16(%rbp), %edx
	movl	-12(%rbp), %eax
	movl	$8, %esi
	movq	%rax, %rdi
	call	Bitpack_newu
	movl	%eax, -12(%rbp)
	subl	$8, -16(%rbp)
.L33:
	cmpl	$0, -16(%rbp)
	jns	.L34
	movq	-24(%rbp), %rax
	movl	-8(%rbp), %edx
	movslq	%edx, %rdx
	movl	-12(%rbp), %ecx
	movl	%ecx, 4(%rax,%rdx,4)
	addl	$1, -8(%rbp)
.L32:
	movl	-8(%rbp), %eax
	cmpl	-44(%rbp), %eax
	jl	.L35
	movss	.LC9(%rip), %xmm0
	movss	%xmm0, CAPACITY(%rip)
	movss	.LC10(%rip), %xmm0
	movss	%xmm0, CURR_LEN(%rip)
	movss	CAPACITY(%rip), %xmm1
	movss	.LC11(%rip), %xmm0
	mulss	%xmm1, %xmm0
	comiss	.LC12(%rip), %xmm0
	jnb	.L36
	cvttss2siq	%xmm0, %rax
	jmp	.L37
.L36:
	movss	.LC12(%rip), %xmm1
	subss	%xmm1, %xmm0
	cvttss2siq	%xmm0, %rax
	movabsq	$-9223372036854775808, %rdx
	xorq	%rdx, %rax
.L37:
	movq	%rax, %rdi
	call	malloc
	movq	%rax, MAPPED(%rip)
	movq	MAPPED(%rip), %rax
	movq	-24(%rbp), %rdx
	movq	%rdx, (%rax)
	movss	.LC9(%rip), %xmm0
	movss	%xmm0, UCAPACITY(%rip)
	pxor	%xmm0, %xmm0
	movss	%xmm0, UCURR_LEN(%rip)
	movss	UCAPACITY(%rip), %xmm1
	movss	.LC14(%rip), %xmm0
	mulss	%xmm1, %xmm0
	comiss	.LC12(%rip), %xmm0
	jnb	.L38
	cvttss2siq	%xmm0, %rax
	jmp	.L39
.L38:
	movss	.LC12(%rip), %xmm1
	subss	%xmm1, %xmm0
	cvttss2siq	%xmm0, %rax
	movabsq	$-9223372036854775808, %rdx
	xorq	%rdx, %rax
.L39:
	movq	%rax, %rdi
	call	malloc
	movq	%rax, UNMAPPED(%rip)
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE9:
	.size	init_um, .-init_um
	.type	free_all, @function
free_all:
.LFB10:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	movq	UNMAPPED(%rip), %rax
	testq	%rax, %rax
	je	.L41
	movq	UNMAPPED(%rip), %rax
	movq	%rax, %rdi
	call	free
.L41:
	movq	MAPPED(%rip), %rax
	testq	%rax, %rax
	je	.L45
	movl	$0, -4(%rbp)
	jmp	.L43
.L44:
	movq	MAPPED(%rip), %rax
	movl	-4(%rbp), %edx
	movslq	%edx, %rdx
	salq	$3, %rdx
	addq	%rdx, %rax
	movq	(%rax), %rax
	movq	%rax, %rdi
	call	free
	addl	$1, -4(%rbp)
.L43:
	cvtsi2ssl	-4(%rbp), %xmm1
	movss	CURR_LEN(%rip), %xmm0
	comiss	%xmm1, %xmm0
	ja	.L44
	movq	MAPPED(%rip), %rax
	movq	%rax, %rdi
	call	free
.L45:
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE10:
	.size	free_all, .-free_all
	.type	run_program, @function
run_program:
.LFB11:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
.L47:
	movq	MAPPED(%rip), %rax
	movq	(%rax), %rax
	movl	prog_counter(%rip), %edx
	movslq	%edx, %rdx
	movl	4(%rax,%rdx,4), %eax
	movl	%eax, -4(%rbp)
	movl	-4(%rbp), %eax
	movl	%eax, %edi
	call	execute_instruct
	movl	prog_counter(%rip), %eax
	addl	$1, %eax
	movl	%eax, prog_counter(%rip)
	jmp	.L47
	.cfi_endproc
.LFE11:
	.size	run_program, .-run_program
	.type	execute_instruct, @function
execute_instruct:
.LFB12:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$48, %rsp
	movl	%edi, -36(%rbp)
	movl	-36(%rbp), %eax
	movl	$28, %edx
	movl	$4, %esi
	movq	%rax, %rdi
	call	Bitpack_getu
	movl	%eax, -4(%rbp)
	movl	$0, -8(%rbp)
	cmpl	$13, -4(%rbp)
	jne	.L49
	movl	-36(%rbp), %eax
	movl	$0, %edx
	movl	$25, %esi
	movq	%rax, %rdi
	call	Bitpack_getu
	movl	%eax, -20(%rbp)
	movl	-36(%rbp), %eax
	movl	$25, %edx
	movl	$3, %esi
	movq	%rax, %rdi
	call	Bitpack_getu
	movl	%eax, -8(%rbp)
	movl	-8(%rbp), %eax
	salq	$2, %rax
	leaq	registers(%rax), %rdx
	movl	-20(%rbp), %eax
	movl	%eax, %esi
	movq	%rdx, %rdi
	call	load_value
	jmp	.L48
.L49:
	movl	-36(%rbp), %eax
	movl	$6, %edx
	movl	$3, %esi
	movq	%rax, %rdi
	call	Bitpack_getu
	movl	%eax, -8(%rbp)
	movl	-36(%rbp), %eax
	movl	$3, %edx
	movl	$3, %esi
	movq	%rax, %rdi
	call	Bitpack_getu
	movl	%eax, -12(%rbp)
	movl	-36(%rbp), %eax
	movl	$0, %edx
	movl	$3, %esi
	movq	%rax, %rdi
	call	Bitpack_getu
	movl	%eax, -16(%rbp)
	cmpl	$12, -4(%rbp)
	ja	.L48
	movl	-4(%rbp), %eax
	movq	.L52(,%rax,8), %rax
	jmp	*%rax
	.section	.rodata
	.align 8
	.align 4
.L52:
	.quad	.L64
	.quad	.L63
	.quad	.L62
	.quad	.L61
	.quad	.L60
	.quad	.L59
	.quad	.L58
	.quad	.L57
	.quad	.L56
	.quad	.L55
	.quad	.L54
	.quad	.L53
	.quad	.L51
	.text
.L64:
	movl	-16(%rbp), %eax
	movl	registers(,%rax,4), %edx
	movl	-12(%rbp), %eax
	movl	registers(,%rax,4), %eax
	movl	-8(%rbp), %ecx
	salq	$2, %rcx
	addq	$registers, %rcx
	movl	%eax, %esi
	movq	%rcx, %rdi
	call	conditional_move
	jmp	.L48
.L63:
	movl	-16(%rbp), %eax
	movl	registers(,%rax,4), %edx
	movl	-12(%rbp), %eax
	movl	registers(,%rax,4), %eax
	movl	-8(%rbp), %ecx
	salq	$2, %rcx
	addq	$registers, %rcx
	movl	%eax, %esi
	movq	%rcx, %rdi
	call	seg_load
	jmp	.L48
.L62:
	movl	-16(%rbp), %eax
	movl	registers(,%rax,4), %edx
	movl	-12(%rbp), %eax
	movl	registers(,%rax,4), %ecx
	movl	-8(%rbp), %eax
	movl	registers(,%rax,4), %eax
	movl	%ecx, %esi
	movl	%eax, %edi
	call	seg_store
	jmp	.L48
.L61:
	movl	-16(%rbp), %eax
	movl	registers(,%rax,4), %edx
	movl	-12(%rbp), %eax
	movl	registers(,%rax,4), %eax
	movl	-8(%rbp), %ecx
	salq	$2, %rcx
	addq	$registers, %rcx
	movl	%eax, %esi
	movq	%rcx, %rdi
	call	add
	jmp	.L48
.L60:
	movl	-16(%rbp), %eax
	movl	registers(,%rax,4), %edx
	movl	-12(%rbp), %eax
	movl	registers(,%rax,4), %eax
	movl	-8(%rbp), %ecx
	salq	$2, %rcx
	addq	$registers, %rcx
	movl	%eax, %esi
	movq	%rcx, %rdi
	call	multiply
	jmp	.L48
.L59:
	movl	-16(%rbp), %eax
	movl	registers(,%rax,4), %edx
	movl	-12(%rbp), %eax
	movl	registers(,%rax,4), %eax
	movl	-8(%rbp), %ecx
	salq	$2, %rcx
	addq	$registers, %rcx
	movl	%eax, %esi
	movq	%rcx, %rdi
	call	divide
	jmp	.L48
.L58:
	movl	-16(%rbp), %eax
	movl	registers(,%rax,4), %edx
	movl	-12(%rbp), %eax
	movl	registers(,%rax,4), %eax
	movl	-8(%rbp), %ecx
	salq	$2, %rcx
	addq	$registers, %rcx
	movl	%eax, %esi
	movq	%rcx, %rdi
	call	bitwise_nand
	jmp	.L48
.L57:
	movl	$0, %eax
	call	free_all
	movl	$0, %eax
	call	halt
	jmp	.L48
.L54:
	movl	-16(%rbp), %eax
	movl	registers(,%rax,4), %eax
	movl	%eax, %edi
	call	output
	jmp	.L48
.L53:
	movl	-16(%rbp), %eax
	salq	$2, %rax
	addq	$registers, %rax
	movq	%rax, %rdi
	call	input
	jmp	.L48
.L51:
	movl	-16(%rbp), %eax
	movl	registers(,%rax,4), %ecx
	movl	-12(%rbp), %eax
	movl	registers(,%rax,4), %eax
	movl	$prog_counter, %edx
	movl	%ecx, %esi
	movl	%eax, %edi
	call	load_program
	jmp	.L48
.L56:
	movl	-16(%rbp), %eax
	movl	registers(,%rax,4), %eax
	movl	-12(%rbp), %edx
	salq	$2, %rdx
	addq	$registers, %rdx
	movl	%eax, %esi
	movq	%rdx, %rdi
	call	map_segment
	jmp	.L48
.L55:
	movl	-16(%rbp), %eax
	movl	registers(,%rax,4), %eax
	movl	%eax, %edi
	call	unmap_segment
	nop
.L48:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE12:
	.size	execute_instruct, .-execute_instruct
	.section	.rodata
.LC15:
	.string	"ra != ((void *)0)"
	.text
	.type	add, @function
add:
.LFB13:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	movq	%rdi, -8(%rbp)
	movl	%esi, -12(%rbp)
	movl	%edx, -16(%rbp)
	cmpq	$0, -8(%rbp)
	jne	.L66
	movl	$__PRETTY_FUNCTION__.3973, %ecx
	movl	$486, %edx
	movl	$.LC0, %esi
	movl	$.LC15, %edi
	call	__assert_fail
.L66:
	movl	-12(%rbp), %edx
	movl	-16(%rbp), %eax
	addl	%eax, %edx
	movq	-8(%rbp), %rax
	movl	%edx, (%rax)
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE13:
	.size	add, .-add
	.type	multiply, @function
multiply:
.LFB14:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	movq	%rdi, -8(%rbp)
	movl	%esi, -12(%rbp)
	movl	%edx, -16(%rbp)
	cmpq	$0, -8(%rbp)
	jne	.L69
	movl	$__PRETTY_FUNCTION__.3979, %ecx
	movl	$501, %edx
	movl	$.LC0, %esi
	movl	$.LC15, %edi
	call	__assert_fail
.L69:
	movl	-12(%rbp), %eax
	imull	-16(%rbp), %eax
	movl	%eax, %edx
	movq	-8(%rbp), %rax
	movl	%edx, (%rax)
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE14:
	.size	multiply, .-multiply
	.type	divide, @function
divide:
.LFB15:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	movq	%rdi, -8(%rbp)
	movl	%esi, -12(%rbp)
	movl	%edx, -16(%rbp)
	cmpq	$0, -8(%rbp)
	jne	.L72
	movl	$__PRETTY_FUNCTION__.3985, %ecx
	movl	$516, %edx
	movl	$.LC0, %esi
	movl	$.LC15, %edi
	call	__assert_fail
.L72:
	movl	-12(%rbp), %eax
	movl	$0, %edx
	divl	-16(%rbp)
	movl	%eax, %edx
	movq	-8(%rbp), %rax
	movl	%edx, (%rax)
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE15:
	.size	divide, .-divide
	.type	bitwise_nand, @function
bitwise_nand:
.LFB16:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$32, %rsp
	movq	%rdi, -24(%rbp)
	movl	%esi, -28(%rbp)
	movl	%edx, -32(%rbp)
	cmpq	$0, -24(%rbp)
	jne	.L75
	movl	$__PRETTY_FUNCTION__.3991, %ecx
	movl	$531, %edx
	movl	$.LC0, %esi
	movl	$.LC15, %edi
	call	__assert_fail
.L75:
	movl	-28(%rbp), %eax
	andl	-32(%rbp), %eax
	movl	%eax, -4(%rbp)
	movl	-4(%rbp), %eax
	notl	%eax
	movl	%eax, %edx
	movq	-24(%rbp), %rax
	movl	%edx, (%rax)
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE16:
	.size	bitwise_nand, .-bitwise_nand
	.type	load_value, @function
load_value:
.LFB17:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	movq	%rdi, -8(%rbp)
	movl	%esi, -12(%rbp)
	cmpq	$0, -8(%rbp)
	jne	.L78
	movl	$__PRETTY_FUNCTION__.3997, %ecx
	movl	$548, %edx
	movl	$.LC0, %esi
	movl	$.LC15, %edi
	call	__assert_fail
.L78:
	movq	-8(%rbp), %rax
	movl	-12(%rbp), %edx
	movl	%edx, (%rax)
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE17:
	.size	load_value, .-load_value
	.type	halt, @function
halt:
.LFB18:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movl	$0, %edi
	call	exit
	.cfi_endproc
.LFE18:
	.size	halt, .-halt
	.section	.rodata
.LC16:
	.string	"rb != ((void *)0)"
.LC17:
	.string	"MAPPED != ((void *)0)"
.LC18:
	.string	"UNMAPPED != ((void *)0)"
.LC19:
	.string	"temp != ((void *)0)"
	.text
	.type	map_segment, @function
map_segment:
.LFB19:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$48, %rsp
	movq	%rdi, -40(%rbp)
	movl	%esi, -44(%rbp)
	cmpq	$0, -40(%rbp)
	jne	.L82
	movl	$__PRETTY_FUNCTION__.4004, %ecx
	movl	$577, %edx
	movl	$.LC0, %esi
	movl	$.LC16, %edi
	call	__assert_fail
.L82:
	movq	MAPPED(%rip), %rax
	testq	%rax, %rax
	jne	.L83
	movl	$__PRETTY_FUNCTION__.4004, %ecx
	movl	$578, %edx
	movl	$.LC0, %esi
	movl	$.LC17, %edi
	call	__assert_fail
.L83:
	movq	UNMAPPED(%rip), %rax
	testq	%rax, %rax
	jne	.L84
	movl	$__PRETTY_FUNCTION__.4004, %ecx
	movl	$579, %edx
	movl	$.LC0, %esi
	movl	$.LC18, %edi
	call	__assert_fail
.L84:
	movl	-44(%rbp), %eax
	addq	$1, %rax
	salq	$2, %rax
	movq	%rax, %rdi
	call	malloc
	movq	%rax, -16(%rbp)
	cmpq	$0, -16(%rbp)
	jne	.L85
	movl	$__PRETTY_FUNCTION__.4004, %ecx
	movl	$582, %edx
	movl	$.LC0, %esi
	movl	$.LC19, %edi
	call	__assert_fail
.L85:
	movl	-44(%rbp), %edx
	movq	-16(%rbp), %rax
	movl	%edx, (%rax)
	movl	$0, -4(%rbp)
	jmp	.L86
.L87:
	movq	-16(%rbp), %rax
	movl	-4(%rbp), %edx
	movslq	%edx, %rdx
	movl	$0, 4(%rax,%rdx,4)
	addl	$1, -4(%rbp)
.L86:
	movl	-44(%rbp), %eax
	cmpl	%eax, -4(%rbp)
	jl	.L87
	movq	UNMAPPED(%rip), %rax
	testq	%rax, %rax
	je	.L88
	movss	UCURR_LEN(%rip), %xmm0
	pxor	%xmm1, %xmm1
	comiss	%xmm1, %xmm0
	jbe	.L88
	movss	UCURR_LEN(%rip), %xmm0
	movss	.LC10(%rip), %xmm1
	subss	%xmm1, %xmm0
	movss	%xmm0, UCURR_LEN(%rip)
	movq	UNMAPPED(%rip), %rax
	movss	UCURR_LEN(%rip), %xmm0
	cvttss2sil	%xmm0, %edx
	movslq	%edx, %rdx
	salq	$2, %rdx
	addq	%rdx, %rax
	movl	(%rax), %eax
	movl	%eax, %edx
	movq	-40(%rbp), %rax
	movl	%edx, (%rax)
	movq	MAPPED(%rip), %rdx
	movq	-40(%rbp), %rax
	movl	(%rax), %eax
	movl	%eax, %eax
	salq	$3, %rax
	addq	%rax, %rdx
	movq	-16(%rbp), %rax
	movq	%rax, (%rdx)
	jmp	.L90
.L88:
	movss	CURR_LEN(%rip), %xmm0
	cvttss2siq	%xmm0, %rax
	movl	%eax, %edx
	movq	-40(%rbp), %rax
	movl	%edx, (%rax)
	movq	MAPPED(%rip), %rdx
	movq	-40(%rbp), %rax
	movl	(%rax), %eax
	movl	%eax, %eax
	salq	$3, %rax
	addq	%rax, %rdx
	movq	-16(%rbp), %rax
	movq	%rax, (%rdx)
	movss	CURR_LEN(%rip), %xmm1
	movss	.LC10(%rip), %xmm0
	addss	%xmm1, %xmm0
	movss	%xmm0, CURR_LEN(%rip)
	movss	CURR_LEN(%rip), %xmm0
	movss	CAPACITY(%rip), %xmm1
	divss	%xmm1, %xmm0
	movss	.LC20(%rip), %xmm1
	comiss	%xmm1, %xmm0
	ja	.L98
	jmp	.L81
.L98:
	movss	CAPACITY(%rip), %xmm0
	addss	%xmm0, %xmm0
	movss	%xmm0, CAPACITY(%rip)
	movss	CAPACITY(%rip), %xmm1
	movss	.LC11(%rip), %xmm0
	mulss	%xmm1, %xmm0
	comiss	.LC12(%rip), %xmm0
	jnb	.L92
	cvttss2siq	%xmm0, %rax
	jmp	.L93
.L92:
	movss	.LC12(%rip), %xmm1
	subss	%xmm1, %xmm0
	cvttss2siq	%xmm0, %rax
	movabsq	$-9223372036854775808, %rdx
	xorq	%rdx, %rax
.L93:
	movq	%rax, %rdi
	call	malloc
	movq	%rax, -24(%rbp)
	movl	$0, -8(%rbp)
	jmp	.L94
.L95:
	movq	MAPPED(%rip), %rax
	movl	-8(%rbp), %edx
	movslq	%edx, %rdx
	salq	$3, %rdx
	addq	%rdx, %rax
	movl	-8(%rbp), %edx
	movslq	%edx, %rdx
	leaq	0(,%rdx,8), %rcx
	movq	-24(%rbp), %rdx
	addq	%rcx, %rdx
	movq	(%rax), %rax
	movq	%rax, (%rdx)
	addl	$1, -8(%rbp)
.L94:
	cvtsi2ssl	-8(%rbp), %xmm1
	movss	CURR_LEN(%rip), %xmm0
	comiss	%xmm1, %xmm0
	ja	.L95
	movq	MAPPED(%rip), %rax
	movq	%rax, %rdi
	call	free
	movq	-24(%rbp), %rax
	movq	%rax, MAPPED(%rip)
.L90:
	nop
.L81:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE19:
	.size	map_segment, .-map_segment
	.section	.rodata
.LC21:
	.string	"MAPPED[rc] != ((void *)0)"
	.text
	.type	unmap_segment, @function
unmap_segment:
.LFB20:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$32, %rsp
	movl	%edi, -20(%rbp)
	movq	MAPPED(%rip), %rax
	testq	%rax, %rax
	jne	.L100
	movl	$__PRETTY_FUNCTION__.4018, %ecx
	movl	$633, %edx
	movl	$.LC0, %esi
	movl	$.LC17, %edi
	call	__assert_fail
.L100:
	movq	UNMAPPED(%rip), %rax
	testq	%rax, %rax
	jne	.L101
	movl	$__PRETTY_FUNCTION__.4018, %ecx
	movl	$634, %edx
	movl	$.LC0, %esi
	movl	$.LC18, %edi
	call	__assert_fail
.L101:
	movq	MAPPED(%rip), %rax
	movl	-20(%rbp), %edx
	salq	$3, %rdx
	addq	%rdx, %rax
	movq	(%rax), %rax
	testq	%rax, %rax
	jne	.L102
	movl	$__PRETTY_FUNCTION__.4018, %ecx
	movl	$635, %edx
	movl	$.LC0, %esi
	movl	$.LC21, %edi
	call	__assert_fail
.L102:
	movq	MAPPED(%rip), %rax
	movl	-20(%rbp), %edx
	salq	$3, %rdx
	addq	%rdx, %rax
	movq	(%rax), %rax
	movq	%rax, %rdi
	call	free
	movq	MAPPED(%rip), %rax
	movl	-20(%rbp), %edx
	salq	$3, %rdx
	addq	%rdx, %rax
	movq	$0, (%rax)
	movq	UNMAPPED(%rip), %rax
	movss	UCURR_LEN(%rip), %xmm0
	cvttss2sil	%xmm0, %edx
	movslq	%edx, %rdx
	salq	$2, %rdx
	addq	%rax, %rdx
	movl	-20(%rbp), %eax
	movl	%eax, (%rdx)
	movss	UCURR_LEN(%rip), %xmm1
	movss	.LC10(%rip), %xmm0
	addss	%xmm1, %xmm0
	movss	%xmm0, UCURR_LEN(%rip)
	movss	UCURR_LEN(%rip), %xmm0
	movss	UCAPACITY(%rip), %xmm1
	divss	%xmm1, %xmm0
	comiss	.LC20(%rip), %xmm0
	ja	.L110
	jmp	.L99
.L110:
	movss	UCAPACITY(%rip), %xmm0
	addss	%xmm0, %xmm0
	movss	%xmm0, UCAPACITY(%rip)
	movss	UCAPACITY(%rip), %xmm1
	movss	.LC14(%rip), %xmm0
	mulss	%xmm1, %xmm0
	comiss	.LC12(%rip), %xmm0
	jnb	.L105
	cvttss2siq	%xmm0, %rax
	jmp	.L106
.L105:
	movss	.LC12(%rip), %xmm1
	subss	%xmm1, %xmm0
	cvttss2siq	%xmm0, %rax
	movabsq	$-9223372036854775808, %rdx
	xorq	%rdx, %rax
.L106:
	movq	%rax, %rdi
	call	malloc
	movq	%rax, -16(%rbp)
	movl	$0, -4(%rbp)
	jmp	.L107
.L108:
	movq	UNMAPPED(%rip), %rax
	movl	-4(%rbp), %edx
	movslq	%edx, %rdx
	salq	$2, %rdx
	addq	%rdx, %rax
	movl	-4(%rbp), %edx
	movslq	%edx, %rdx
	leaq	0(,%rdx,4), %rcx
	movq	-16(%rbp), %rdx
	addq	%rcx, %rdx
	movl	(%rax), %eax
	movl	%eax, (%rdx)
	addl	$1, -4(%rbp)
.L107:
	cvtsi2ssl	-4(%rbp), %xmm1
	movss	UCURR_LEN(%rip), %xmm0
	comiss	%xmm1, %xmm0
	ja	.L108
	movq	UNMAPPED(%rip), %rax
	movq	%rax, %rdi
	call	free
	movq	-16(%rbp), %rax
	movq	%rax, UNMAPPED(%rip)
	nop
.L99:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE20:
	.size	unmap_segment, .-unmap_segment
	.type	seg_load, @function
seg_load:
.LFB21:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	movq	%rdi, -8(%rbp)
	movl	%esi, -12(%rbp)
	movl	%edx, -16(%rbp)
	cmpq	$0, -8(%rbp)
	jne	.L112
	movl	$__PRETTY_FUNCTION__.4029, %ecx
	movl	$676, %edx
	movl	$.LC0, %esi
	movl	$.LC15, %edi
	call	__assert_fail
.L112:
	movq	MAPPED(%rip), %rax
	testq	%rax, %rax
	jne	.L113
	movl	$__PRETTY_FUNCTION__.4029, %ecx
	movl	$677, %edx
	movl	$.LC0, %esi
	movl	$.LC17, %edi
	call	__assert_fail
.L113:
	movq	MAPPED(%rip), %rax
	movl	-12(%rbp), %edx
	salq	$3, %rdx
	addq	%rdx, %rax
	movq	(%rax), %rax
	movl	-16(%rbp), %edx
	movl	4(%rax,%rdx,4), %edx
	movq	-8(%rbp), %rax
	movl	%edx, (%rax)
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE21:
	.size	seg_load, .-seg_load
	.type	seg_store, @function
seg_store:
.LFB22:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	movl	%edi, -4(%rbp)
	movl	%esi, -8(%rbp)
	movl	%edx, -12(%rbp)
	movq	MAPPED(%rip), %rax
	testq	%rax, %rax
	jne	.L116
	movl	$__PRETTY_FUNCTION__.4035, %ecx
	movl	$695, %edx
	movl	$.LC0, %esi
	movl	$.LC17, %edi
	call	__assert_fail
.L116:
	movq	MAPPED(%rip), %rax
	movl	-4(%rbp), %edx
	salq	$3, %rdx
	addq	%rdx, %rax
	movq	(%rax), %rax
	movl	-8(%rbp), %edx
	movl	-12(%rbp), %ecx
	movl	%ecx, 4(%rax,%rdx,4)
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE22:
	.size	seg_store, .-seg_store
	.type	conditional_move, @function
conditional_move:
.LFB23:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	movq	%rdi, -8(%rbp)
	movl	%esi, -12(%rbp)
	movl	%edx, -16(%rbp)
	cmpq	$0, -8(%rbp)
	jne	.L119
	movl	$__PRETTY_FUNCTION__.4041, %ecx
	movl	$713, %edx
	movl	$.LC0, %esi
	movl	$.LC15, %edi
	call	__assert_fail
.L119:
	cmpl	$0, -16(%rbp)
	je	.L122
	movq	-8(%rbp), %rax
	movl	-12(%rbp), %edx
	movl	%edx, (%rax)
	nop
.L122:
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE23:
	.size	conditional_move, .-conditional_move
	.section	.rodata
.LC22:
	.string	"count != ((void *)0)"
.LC23:
	.string	"store_here != ((void *)0)"
	.text
	.type	load_program, @function
load_program:
.LFB24:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$32, %rsp
	movl	%edi, -20(%rbp)
	movl	%esi, -24(%rbp)
	movq	%rdx, -32(%rbp)
	cmpq	$0, -32(%rbp)
	jne	.L124
	movl	$__PRETTY_FUNCTION__.4047, %ecx
	movl	$733, %edx
	movl	$.LC0, %esi
	movl	$.LC22, %edi
	call	__assert_fail
.L124:
	movq	MAPPED(%rip), %rax
	testq	%rax, %rax
	jne	.L125
	movl	$__PRETTY_FUNCTION__.4047, %ecx
	movl	$734, %edx
	movl	$.LC0, %esi
	movl	$.LC17, %edi
	call	__assert_fail
.L125:
	cmpl	$0, -20(%rbp)
	je	.L126
	movq	MAPPED(%rip), %rax
	movl	-20(%rbp), %edx
	salq	$3, %rdx
	addq	%rdx, %rax
	movq	(%rax), %rax
	movl	(%rax), %eax
	movl	%eax, -8(%rbp)
	movl	-8(%rbp), %eax
	cltq
	addq	$1, %rax
	salq	$2, %rax
	movq	%rax, %rdi
	call	malloc
	movq	%rax, -16(%rbp)
	cmpq	$0, -16(%rbp)
	jne	.L127
	movl	$__PRETTY_FUNCTION__.4047, %ecx
	movl	$741, %edx
	movl	$.LC0, %esi
	movl	$.LC23, %edi
	call	__assert_fail
.L127:
	movq	-16(%rbp), %rax
	movl	-8(%rbp), %edx
	movl	%edx, (%rax)
	movl	$0, -4(%rbp)
	jmp	.L128
.L129:
	movq	MAPPED(%rip), %rax
	movl	-20(%rbp), %edx
	salq	$3, %rdx
	addq	%rdx, %rax
	movq	(%rax), %rax
	movl	-4(%rbp), %edx
	movslq	%edx, %rdx
	movl	4(%rax,%rdx,4), %ecx
	movq	-16(%rbp), %rax
	movl	-4(%rbp), %edx
	movslq	%edx, %rdx
	movl	%ecx, 4(%rax,%rdx,4)
	addl	$1, -4(%rbp)
.L128:
	movl	-4(%rbp), %eax
	cmpl	-8(%rbp), %eax
	jl	.L129
	movq	MAPPED(%rip), %rax
	movq	(%rax), %rax
	movq	%rax, %rdi
	call	free
	movq	MAPPED(%rip), %rax
	movq	-16(%rbp), %rdx
	movq	%rdx, (%rax)
.L126:
	movl	-24(%rbp), %eax
	subl	$1, %eax
	movl	%eax, %edx
	movq	-32(%rbp), %rax
	movl	%edx, (%rax)
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE24:
	.size	load_program, .-load_program
	.section	.rodata
.LC24:
	.string	"rc != ((void *)0)"
	.text
	.type	input, @function
input:
.LFB25:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$32, %rsp
	movq	%rdi, -24(%rbp)
	cmpq	$0, -24(%rbp)
	jne	.L132
	movl	$__PRETTY_FUNCTION__.4057, %ecx
	movl	$778, %edx
	movl	$.LC0, %esi
	movl	$.LC24, %edi
	call	__assert_fail
.L132:
	call	getchar
	movl	%eax, -4(%rbp)
	cmpl	$-1, -4(%rbp)
	jne	.L133
	movq	-24(%rbp), %rax
	movl	$-1, (%rax)
	jmp	.L131
.L133:
	movl	-4(%rbp), %edx
	movq	-24(%rbp), %rax
	movl	%edx, (%rax)
	nop
.L131:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE25:
	.size	input, .-input
	.section	.rodata
.LC25:
	.string	"rc < 256"
	.text
	.type	output, @function
output:
.LFB26:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	movl	%edi, -4(%rbp)
	cmpl	$255, -4(%rbp)
	jbe	.L137
	movl	$__PRETTY_FUNCTION__.4062, %ecx
	movl	$799, %edx
	movl	$.LC0, %esi
	movl	$.LC25, %edi
	call	__assert_fail
.L137:
	movl	-4(%rbp), %eax
	movl	%eax, %edi
	call	putchar
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE26:
	.size	output, .-output
	.section	.rodata
	.align 8
	.type	__PRETTY_FUNCTION__.3920, @object
	.size	__PRETTY_FUNCTION__.3920, 8
__PRETTY_FUNCTION__.3920:
	.string	"init_um"
	.align 8
	.type	__PRETTY_FUNCTION__.3903, @object
	.size	__PRETTY_FUNCTION__.3903, 13
__PRETTY_FUNCTION__.3903:
	.string	"Bitpack_newu"
	.type	__PRETTY_FUNCTION__.3879, @object
	.size	__PRETTY_FUNCTION__.3879, 4
__PRETTY_FUNCTION__.3879:
	.string	"shl"
	.type	__PRETTY_FUNCTION__.3884, @object
	.size	__PRETTY_FUNCTION__.3884, 4
__PRETTY_FUNCTION__.3884:
	.string	"shr"
	.align 8
	.type	__PRETTY_FUNCTION__.3997, @object
	.size	__PRETTY_FUNCTION__.3997, 11
__PRETTY_FUNCTION__.3997:
	.string	"load_value"
	.align 8
	.type	__PRETTY_FUNCTION__.3895, @object
	.size	__PRETTY_FUNCTION__.3895, 13
__PRETTY_FUNCTION__.3895:
	.string	"Bitpack_getu"
	.align 16
	.type	__PRETTY_FUNCTION__.4041, @object
	.size	__PRETTY_FUNCTION__.4041, 17
__PRETTY_FUNCTION__.4041:
	.string	"conditional_move"
	.align 8
	.type	__PRETTY_FUNCTION__.4029, @object
	.size	__PRETTY_FUNCTION__.4029, 9
__PRETTY_FUNCTION__.4029:
	.string	"seg_load"
	.align 8
	.type	__PRETTY_FUNCTION__.4035, @object
	.size	__PRETTY_FUNCTION__.4035, 10
__PRETTY_FUNCTION__.4035:
	.string	"seg_store"
	.type	__PRETTY_FUNCTION__.3973, @object
	.size	__PRETTY_FUNCTION__.3973, 4
__PRETTY_FUNCTION__.3973:
	.string	"add"
	.align 8
	.type	__PRETTY_FUNCTION__.3979, @object
	.size	__PRETTY_FUNCTION__.3979, 9
__PRETTY_FUNCTION__.3979:
	.string	"multiply"
	.type	__PRETTY_FUNCTION__.3985, @object
	.size	__PRETTY_FUNCTION__.3985, 7
__PRETTY_FUNCTION__.3985:
	.string	"divide"
	.align 8
	.type	__PRETTY_FUNCTION__.3991, @object
	.size	__PRETTY_FUNCTION__.3991, 13
__PRETTY_FUNCTION__.3991:
	.string	"bitwise_nand"
	.type	__PRETTY_FUNCTION__.4062, @object
	.size	__PRETTY_FUNCTION__.4062, 7
__PRETTY_FUNCTION__.4062:
	.string	"output"
	.type	__PRETTY_FUNCTION__.4057, @object
	.size	__PRETTY_FUNCTION__.4057, 6
__PRETTY_FUNCTION__.4057:
	.string	"input"
	.align 8
	.type	__PRETTY_FUNCTION__.4047, @object
	.size	__PRETTY_FUNCTION__.4047, 13
__PRETTY_FUNCTION__.4047:
	.string	"load_program"
	.align 8
	.type	__PRETTY_FUNCTION__.4004, @object
	.size	__PRETTY_FUNCTION__.4004, 12
__PRETTY_FUNCTION__.4004:
	.string	"map_segment"
	.align 8
	.type	__PRETTY_FUNCTION__.4018, @object
	.size	__PRETTY_FUNCTION__.4018, 14
__PRETTY_FUNCTION__.4018:
	.string	"unmap_segment"
	.align 4
.LC9:
	.long	1203982336
	.align 4
.LC10:
	.long	1065353216
	.align 4
.LC11:
	.long	1090519040
	.align 4
.LC12:
	.long	1593835520
	.align 4
.LC14:
	.long	1082130432
	.align 4
.LC20:
	.long	1056964608
	.ident	"GCC: (GNU) 9.1.0"
	.section	.note.GNU-stack,"",@progbits