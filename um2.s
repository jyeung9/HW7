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
	movq	%rdi, -8(%rbp)
	movl	%esi, -12(%rbp)
	cmpl	$64, -12(%rbp)
	jne	.L2
	movl	$0, %eax
	jmp	.L3
.L2:
	movl	-12(%rbp), %eax
	movq	-8(%rbp), %rdx
	movl	%eax, %ecx
	salq	%cl, %rdx
	movq	%rdx, %rax
.L3:
	popq	%rbp
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
	movq	%rdi, -8(%rbp)
	movl	%esi, -12(%rbp)
	cmpl	$64, -12(%rbp)
	jne	.L5
	movl	$0, %eax
	jmp	.L6
.L5:
	movl	-12(%rbp), %eax
	movq	-8(%rbp), %rdx
	movl	%eax, %ecx
	shrq	%cl, %rdx
	movq	%rdx, %rax
.L6:
	popq	%rbp
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
	jbe	.L8
	movl	$1, %eax
	jmp	.L9
.L8:
	movl	-12(%rbp), %edx
	movq	-8(%rbp), %rax
	movl	%edx, %esi
	movq	%rax, %rdi
	call	shr
	testq	%rax, %rax
	sete	%al
.L9:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE4:
	.size	Bitpack_fitsu, .-Bitpack_fitsu
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
	subq	$32, %rsp
	.cfi_offset 3, -24
	movq	%rdi, -32(%rbp)
	movl	%esi, -36(%rbp)
	movl	%edx, -40(%rbp)
	movl	-40(%rbp), %edx
	movl	-36(%rbp), %eax
	addl	%edx, %eax
	movl	%eax, -12(%rbp)
	movl	$64, %eax
	subl	-36(%rbp), %eax
	movl	%eax, %ebx
	movl	$64, %eax
	subl	-12(%rbp), %eax
	movl	%eax, %edx
	movq	-32(%rbp), %rax
	movl	%edx, %esi
	movq	%rax, %rdi
	call	shl
	movl	%ebx, %esi
	movq	%rax, %rdi
	call	shr
	addq	$32, %rsp
	popq	%rbx
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE5:
	.size	Bitpack_getu, .-Bitpack_getu
	.section	.rodata
.LC0:
	.string	"um2.c"
.LC1:
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
	movl	-44(%rbp), %edx
	movq	-56(%rbp), %rax
	movl	%edx, %esi
	movq	%rax, %rdi
	call	Bitpack_fitsu
	xorl	$1, %eax
	testb	%al, %al
	je	.L13
	movl	$__PRETTY_FUNCTION__.3899, %ecx
	movl	$237, %edx
	movl	$.LC0, %esi
	movl	$.LC1, %edi
	call	__assert_fail
.L13:
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
.LC2:
	.string	"Invalid format\nCorrect usage: \"./um [filename]\"\n"
.LC3:
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
	jg	.L18
	cmpl	$1, -20(%rbp)
	jg	.L19
.L18:
	movq	stderr(%rip), %rax
	movq	%rax, %rcx
	movl	$48, %edx
	movl	$1, %esi
	movl	$.LC2, %edi
	call	fwrite
	movl	$1, %edi
	call	exit
.L19:
	movq	-32(%rbp), %rax
	movq	8(%rax), %rax
	movq	%rax, -8(%rbp)
	movq	-8(%rbp), %rax
	movl	$.LC3, %esi
	movq	%rax, %rdi
	call	fopen
	movq	%rax, -16(%rbp)
	cmpq	$0, -16(%rbp)
	je	.L20
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
.L20:
	movq	stderr(%rip), %rax
	movq	%rax, %rcx
	movl	$48, %edx
	movl	$1, %esi
	movl	$.LC2, %edi
	call	fwrite
	movl	$1, %edi
	call	exit
	.cfi_endproc
.LFE8:
	.size	main, .-main
	.section	.rodata
.LC4:
	.string	"seg != ((void *)0)"
.LC9:
	.string	"MAPPED != ((void *)0)"
.LC12:
	.string	"UNMAPPED != ((void *)0)"
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
	movl	$0, prog_counter(%rip)
	movl	$0, -4(%rbp)
	jmp	.L23
.L24:
	movl	-4(%rbp), %eax
	cltq
	movl	$0, registers(,%rax,4)
	addl	$1, -4(%rbp)
.L23:
	cmpl	$7, -4(%rbp)
	jle	.L24
	movl	-44(%rbp), %eax
	cltq
	addq	$1, %rax
	salq	$2, %rax
	movq	%rax, %rdi
	call	malloc
	movq	%rax, -24(%rbp)
	cmpq	$0, -24(%rbp)
	jne	.L25
	movl	$__PRETTY_FUNCTION__.3921, %ecx
	movl	$322, %edx
	movl	$.LC0, %esi
	movl	$.LC4, %edi
	call	__assert_fail
.L25:
	movq	-24(%rbp), %rax
	movl	-44(%rbp), %edx
	movl	%edx, (%rax)
	movl	$0, -8(%rbp)
	jmp	.L26
.L29:
	movl	$0, -12(%rbp)
	movl	$24, -16(%rbp)
	jmp	.L27
.L28:
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
.L27:
	cmpl	$0, -16(%rbp)
	jns	.L28
	movq	-24(%rbp), %rax
	movl	-8(%rbp), %edx
	movslq	%edx, %rdx
	movl	-12(%rbp), %ecx
	movl	%ecx, 4(%rax,%rdx,4)
	addl	$1, -8(%rbp)
.L26:
	movl	-8(%rbp), %eax
	cmpl	-44(%rbp), %eax
	jl	.L29
	movss	.LC5(%rip), %xmm0
	movss	%xmm0, CAPACITY(%rip)
	movss	.LC6(%rip), %xmm0
	movss	%xmm0, CURR_LEN(%rip)
	movss	CAPACITY(%rip), %xmm1
	movss	.LC7(%rip), %xmm0
	mulss	%xmm1, %xmm0
	comiss	.LC8(%rip), %xmm0
	jnb	.L30
	cvttss2siq	%xmm0, %rax
	jmp	.L31
.L30:
	movss	.LC8(%rip), %xmm1
	subss	%xmm1, %xmm0
	cvttss2siq	%xmm0, %rax
	movabsq	$-9223372036854775808, %rdx
	xorq	%rdx, %rax
.L31:
	movq	%rax, %rdi
	call	malloc
	movq	%rax, MAPPED(%rip)
	movq	MAPPED(%rip), %rax
	testq	%rax, %rax
	jne	.L32
	movl	$__PRETTY_FUNCTION__.3921, %ecx
	movl	$337, %edx
	movl	$.LC0, %esi
	movl	$.LC9, %edi
	call	__assert_fail
.L32:
	movq	MAPPED(%rip), %rax
	movq	-24(%rbp), %rdx
	movq	%rdx, (%rax)
	movss	.LC5(%rip), %xmm0
	movss	%xmm0, UCAPACITY(%rip)
	pxor	%xmm0, %xmm0
	movss	%xmm0, UCURR_LEN(%rip)
	movss	UCAPACITY(%rip), %xmm1
	movss	.LC11(%rip), %xmm0
	mulss	%xmm1, %xmm0
	comiss	.LC8(%rip), %xmm0
	jnb	.L33
	cvttss2siq	%xmm0, %rax
	jmp	.L34
.L33:
	movss	.LC8(%rip), %xmm1
	subss	%xmm1, %xmm0
	cvttss2siq	%xmm0, %rax
	movabsq	$-9223372036854775808, %rdx
	xorq	%rdx, %rax
.L34:
	movq	%rax, %rdi
	call	malloc
	movq	%rax, UNMAPPED(%rip)
	movq	UNMAPPED(%rip), %rax
	testq	%rax, %rax
	jne	.L36
	movl	$__PRETTY_FUNCTION__.3921, %ecx
	movl	$350, %edx
	movl	$.LC0, %esi
	movl	$.LC12, %edi
	call	__assert_fail
.L36:
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
	je	.L38
	movq	UNMAPPED(%rip), %rax
	movq	%rax, %rdi
	call	free
.L38:
	movq	MAPPED(%rip), %rax
	testq	%rax, %rax
	je	.L43
	movl	$0, -4(%rbp)
	jmp	.L40
.L42:
	movq	MAPPED(%rip), %rax
	movl	-4(%rbp), %edx
	movslq	%edx, %rdx
	salq	$3, %rdx
	addq	%rdx, %rax
	movq	(%rax), %rax
	movq	%rax, -16(%rbp)
	cmpq	$0, -16(%rbp)
	je	.L41
	movq	-16(%rbp), %rax
	movq	%rax, %rdi
	call	free
.L41:
	addl	$1, -4(%rbp)
.L40:
	cvtsi2ssl	-4(%rbp), %xmm1
	movss	CURR_LEN(%rip), %xmm0
	comiss	%xmm1, %xmm0
	ja	.L42
	movq	MAPPED(%rip), %rax
	movq	%rax, %rdi
	call	free
.L43:
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
.L45:
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
	jmp	.L45
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
	jne	.L47
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
	movl	-20(%rbp), %edx
	movl	-8(%rbp), %eax
	movl	%edx, %esi
	movl	%eax, %edi
	call	load_value
	jmp	.L46
.L47:
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
	cmpl	$0, -4(%rbp)
	jne	.L49
	movl	-16(%rbp), %edx
	movl	-12(%rbp), %ecx
	movl	-8(%rbp), %eax
	movl	%ecx, %esi
	movl	%eax, %edi
	call	conditional_move
	jmp	.L46
.L49:
	cmpl	$1, -4(%rbp)
	jne	.L50
	movl	-16(%rbp), %edx
	movl	-12(%rbp), %ecx
	movl	-8(%rbp), %eax
	movl	%ecx, %esi
	movl	%eax, %edi
	call	seg_load
	jmp	.L46
.L50:
	cmpl	$2, -4(%rbp)
	jne	.L51
	movl	-16(%rbp), %edx
	movl	-12(%rbp), %ecx
	movl	-8(%rbp), %eax
	movl	%ecx, %esi
	movl	%eax, %edi
	call	seg_store
	jmp	.L46
.L51:
	cmpl	$3, -4(%rbp)
	jne	.L52
	movl	-16(%rbp), %edx
	movl	-12(%rbp), %ecx
	movl	-8(%rbp), %eax
	movl	%ecx, %esi
	movl	%eax, %edi
	call	add
	jmp	.L46
.L52:
	cmpl	$4, -4(%rbp)
	jne	.L53
	movl	-16(%rbp), %edx
	movl	-12(%rbp), %ecx
	movl	-8(%rbp), %eax
	movl	%ecx, %esi
	movl	%eax, %edi
	call	multiply
	jmp	.L46
.L53:
	cmpl	$5, -4(%rbp)
	jne	.L54
	movl	-16(%rbp), %edx
	movl	-12(%rbp), %ecx
	movl	-8(%rbp), %eax
	movl	%ecx, %esi
	movl	%eax, %edi
	call	divide
	jmp	.L46
.L54:
	cmpl	$6, -4(%rbp)
	jne	.L55
	movl	-16(%rbp), %edx
	movl	-12(%rbp), %ecx
	movl	-8(%rbp), %eax
	movl	%ecx, %esi
	movl	%eax, %edi
	call	bitwise_nand
	jmp	.L46
.L55:
	cmpl	$7, -4(%rbp)
	jne	.L56
	movl	$0, %eax
	call	free_all
	movl	$0, %eax
	call	halt
	jmp	.L46
.L56:
	cmpl	$10, -4(%rbp)
	jne	.L57
	movl	-16(%rbp), %eax
	movl	%eax, %edi
	call	output
	jmp	.L46
.L57:
	cmpl	$11, -4(%rbp)
	jne	.L58
	movl	-16(%rbp), %eax
	movl	%eax, %edi
	call	input
	jmp	.L46
.L58:
	cmpl	$12, -4(%rbp)
	jne	.L59
	movl	-16(%rbp), %edx
	movl	-12(%rbp), %eax
	movl	%edx, %esi
	movl	%eax, %edi
	call	load_program
	jmp	.L46
.L59:
	cmpl	$8, -4(%rbp)
	jne	.L60
	movl	-16(%rbp), %edx
	movl	-12(%rbp), %eax
	movl	%edx, %esi
	movl	%eax, %edi
	call	map_segment
	jmp	.L46
.L60:
	cmpl	$9, -4(%rbp)
	jne	.L46
	movl	-16(%rbp), %eax
	movl	%eax, %edi
	call	unmap_segment
.L46:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE12:
	.size	execute_instruct, .-execute_instruct
	.type	add, @function
add:
.LFB13:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movl	%edi, -4(%rbp)
	movl	%esi, -8(%rbp)
	movl	%edx, -12(%rbp)
	movl	-8(%rbp), %eax
	movl	registers(,%rax,4), %edx
	movl	-12(%rbp), %eax
	movl	registers(,%rax,4), %eax
	addl	%eax, %edx
	movl	-4(%rbp), %eax
	movl	%edx, registers(,%rax,4)
	nop
	popq	%rbp
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
	movl	%edi, -4(%rbp)
	movl	%esi, -8(%rbp)
	movl	%edx, -12(%rbp)
	movl	-8(%rbp), %eax
	movl	registers(,%rax,4), %edx
	movl	-12(%rbp), %eax
	movl	registers(,%rax,4), %eax
	imull	%eax, %edx
	movl	-4(%rbp), %eax
	movl	%edx, registers(,%rax,4)
	nop
	popq	%rbp
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
	movl	%edi, -4(%rbp)
	movl	%esi, -8(%rbp)
	movl	%edx, -12(%rbp)
	movl	-8(%rbp), %eax
	movl	registers(,%rax,4), %eax
	movl	-12(%rbp), %edx
	movl	registers(,%rdx,4), %ecx
	movl	$0, %edx
	divl	%ecx
	movl	%eax, %edx
	movl	-4(%rbp), %eax
	movl	%edx, registers(,%rax,4)
	nop
	popq	%rbp
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
	movl	%edi, -20(%rbp)
	movl	%esi, -24(%rbp)
	movl	%edx, -28(%rbp)
	movl	-24(%rbp), %eax
	movl	registers(,%rax,4), %edx
	movl	-28(%rbp), %eax
	movl	registers(,%rax,4), %eax
	andl	%edx, %eax
	movl	%eax, -4(%rbp)
	movl	-4(%rbp), %eax
	notl	%eax
	movl	%eax, %edx
	movl	-20(%rbp), %eax
	movl	%edx, registers(,%rax,4)
	nop
	popq	%rbp
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
	movl	%edi, -4(%rbp)
	movl	%esi, -8(%rbp)
	movl	-4(%rbp), %eax
	movl	-8(%rbp), %edx
	movl	%edx, registers(,%rax,4)
	nop
	popq	%rbp
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
.LC13:
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
	movl	%edi, -36(%rbp)
	movl	%esi, -40(%rbp)
	movl	-40(%rbp), %eax
	movl	registers(,%rax,4), %eax
	movl	%eax, -12(%rbp)
	movl	-12(%rbp), %eax
	cltq
	addq	$1, %rax
	salq	$2, %rax
	movq	%rax, %rdi
	call	malloc
	movq	%rax, -24(%rbp)
	cmpq	$0, -24(%rbp)
	jne	.L73
	movl	$__PRETTY_FUNCTION__.3984, %ecx
	movl	$577, %edx
	movl	$.LC0, %esi
	movl	$.LC13, %edi
	call	__assert_fail
.L73:
	movq	-24(%rbp), %rax
	movl	-12(%rbp), %edx
	movl	%edx, (%rax)
	movl	$0, -4(%rbp)
	jmp	.L74
.L75:
	movq	-24(%rbp), %rax
	movl	-4(%rbp), %edx
	movslq	%edx, %rdx
	movl	$0, 4(%rax,%rdx,4)
	addl	$1, -4(%rbp)
.L74:
	movl	-4(%rbp), %eax
	cmpl	-12(%rbp), %eax
	jl	.L75
	movq	UNMAPPED(%rip), %rax
	testq	%rax, %rax
	je	.L76
	movss	UCURR_LEN(%rip), %xmm0
	pxor	%xmm1, %xmm1
	comiss	%xmm1, %xmm0
	jbe	.L76
	movss	UCURR_LEN(%rip), %xmm0
	movss	.LC6(%rip), %xmm1
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
	movl	-36(%rbp), %eax
	movl	%edx, registers(,%rax,4)
	movq	MAPPED(%rip), %rdx
	movl	-36(%rbp), %eax
	movl	registers(,%rax,4), %eax
	movl	%eax, %eax
	salq	$3, %rax
	addq	%rax, %rdx
	movq	-24(%rbp), %rax
	movq	%rax, (%rdx)
	jmp	.L78
.L76:
	movss	CURR_LEN(%rip), %xmm0
	cvttss2siq	%xmm0, %rax
	movl	%eax, %edx
	movl	-36(%rbp), %eax
	movl	%edx, registers(,%rax,4)
	movq	MAPPED(%rip), %rdx
	movl	-36(%rbp), %eax
	movl	registers(,%rax,4), %eax
	movl	%eax, %eax
	salq	$3, %rax
	addq	%rax, %rdx
	movq	-24(%rbp), %rax
	movq	%rax, (%rdx)
	movss	CURR_LEN(%rip), %xmm1
	movss	.LC6(%rip), %xmm0
	addss	%xmm1, %xmm0
	movss	%xmm0, CURR_LEN(%rip)
	movss	CURR_LEN(%rip), %xmm0
	movss	CAPACITY(%rip), %xmm1
	divss	%xmm1, %xmm0
	movss	.LC14(%rip), %xmm1
	comiss	%xmm1, %xmm0
	ja	.L87
	jmp	.L72
.L87:
	movss	CAPACITY(%rip), %xmm0
	addss	%xmm0, %xmm0
	movss	%xmm0, CAPACITY(%rip)
	movss	CAPACITY(%rip), %xmm1
	movss	.LC7(%rip), %xmm0
	mulss	%xmm1, %xmm0
	comiss	.LC8(%rip), %xmm0
	jnb	.L80
	cvttss2siq	%xmm0, %rax
	jmp	.L81
.L80:
	movss	.LC8(%rip), %xmm1
	subss	%xmm1, %xmm0
	cvttss2siq	%xmm0, %rax
	movabsq	$-9223372036854775808, %rdx
	xorq	%rdx, %rax
.L81:
	movq	%rax, %rdi
	call	malloc
	movq	%rax, -32(%rbp)
	cmpq	$0, -32(%rbp)
	jne	.L82
	movl	$__PRETTY_FUNCTION__.3984, %ecx
	movl	$595, %edx
	movl	$.LC0, %esi
	movl	$.LC13, %edi
	call	__assert_fail
.L82:
	movl	$0, -8(%rbp)
	jmp	.L83
.L84:
	movq	MAPPED(%rip), %rax
	movl	-8(%rbp), %edx
	movslq	%edx, %rdx
	salq	$3, %rdx
	addq	%rdx, %rax
	movl	-8(%rbp), %edx
	movslq	%edx, %rdx
	leaq	0(,%rdx,8), %rcx
	movq	-32(%rbp), %rdx
	addq	%rcx, %rdx
	movq	(%rax), %rax
	movq	%rax, (%rdx)
	addl	$1, -8(%rbp)
.L83:
	cvtsi2ssl	-8(%rbp), %xmm1
	movss	CURR_LEN(%rip), %xmm0
	comiss	%xmm1, %xmm0
	ja	.L84
	movq	MAPPED(%rip), %rax
	movq	%rax, %rdi
	call	free
	movq	-32(%rbp), %rax
	movq	%rax, MAPPED(%rip)
.L78:
	nop
.L72:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE19:
	.size	map_segment, .-map_segment
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
	movl	-20(%rbp), %eax
	movl	registers(,%rax,4), %eax
	movl	%eax, -8(%rbp)
	movq	MAPPED(%rip), %rax
	movl	-8(%rbp), %edx
	movslq	%edx, %rdx
	salq	$3, %rdx
	addq	%rdx, %rax
	movq	(%rax), %rax
	movq	%rax, %rdi
	call	free
	movq	MAPPED(%rip), %rax
	movl	-8(%rbp), %edx
	movslq	%edx, %rdx
	salq	$3, %rdx
	addq	%rdx, %rax
	movq	$0, (%rax)
	movq	UNMAPPED(%rip), %rax
	movss	UCURR_LEN(%rip), %xmm0
	cvttss2sil	%xmm0, %edx
	movslq	%edx, %rdx
	salq	$2, %rdx
	addq	%rax, %rdx
	movl	-8(%rbp), %eax
	movl	%eax, (%rdx)
	movss	UCURR_LEN(%rip), %xmm1
	movss	.LC6(%rip), %xmm0
	addss	%xmm1, %xmm0
	movss	%xmm0, UCURR_LEN(%rip)
	movss	UCURR_LEN(%rip), %xmm0
	movss	UCAPACITY(%rip), %xmm1
	divss	%xmm1, %xmm0
	comiss	.LC14(%rip), %xmm0
	ja	.L97
	jmp	.L88
.L97:
	movss	UCAPACITY(%rip), %xmm0
	addss	%xmm0, %xmm0
	movss	%xmm0, UCAPACITY(%rip)
	movss	UCAPACITY(%rip), %xmm1
	movss	.LC11(%rip), %xmm0
	mulss	%xmm1, %xmm0
	comiss	.LC8(%rip), %xmm0
	jnb	.L91
	cvttss2siq	%xmm0, %rax
	jmp	.L92
.L91:
	movss	.LC8(%rip), %xmm1
	subss	%xmm1, %xmm0
	cvttss2siq	%xmm0, %rax
	movabsq	$-9223372036854775808, %rdx
	xorq	%rdx, %rax
.L92:
	movq	%rax, %rdi
	call	malloc
	movq	%rax, -16(%rbp)
	cmpq	$0, -16(%rbp)
	jne	.L93
	movl	$__PRETTY_FUNCTION__.3999, %ecx
	movl	$652, %edx
	movl	$.LC0, %esi
	movl	$.LC13, %edi
	call	__assert_fail
.L93:
	movl	$0, -4(%rbp)
	jmp	.L94
.L95:
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
.L94:
	cvtsi2ssl	-4(%rbp), %xmm1
	movss	UCURR_LEN(%rip), %xmm0
	comiss	%xmm1, %xmm0
	ja	.L95
	movq	UNMAPPED(%rip), %rax
	movq	%rax, %rdi
	call	free
	movq	-16(%rbp), %rax
	movq	%rax, UNMAPPED(%rip)
	nop
.L88:
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
	movl	%edi, -4(%rbp)
	movl	%esi, -8(%rbp)
	movl	%edx, -12(%rbp)
	movq	MAPPED(%rip), %rdx
	movl	-8(%rbp), %eax
	movl	registers(,%rax,4), %eax
	movl	%eax, %eax
	salq	$3, %rax
	addq	%rdx, %rax
	movq	(%rax), %rax
	movl	-12(%rbp), %edx
	movl	registers(,%rdx,4), %edx
	movl	%edx, %edx
	movl	4(%rax,%rdx,4), %edx
	movl	-4(%rbp), %eax
	movl	%edx, registers(,%rax,4)
	nop
	popq	%rbp
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
	movl	%edi, -4(%rbp)
	movl	%esi, -8(%rbp)
	movl	%edx, -12(%rbp)
	movq	MAPPED(%rip), %rdx
	movl	-4(%rbp), %eax
	movl	registers(,%rax,4), %eax
	movl	%eax, %eax
	salq	$3, %rax
	addq	%rdx, %rax
	movq	(%rax), %rax
	movl	-8(%rbp), %edx
	movl	registers(,%rdx,4), %ecx
	movl	-12(%rbp), %edx
	movl	registers(,%rdx,4), %edx
	movl	%ecx, %ecx
	movl	%edx, 4(%rax,%rcx,4)
	nop
	popq	%rbp
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
	movl	%edi, -4(%rbp)
	movl	%esi, -8(%rbp)
	movl	%edx, -12(%rbp)
	movl	-12(%rbp), %eax
	movl	registers(,%rax,4), %eax
	testl	%eax, %eax
	je	.L105
	movl	-8(%rbp), %eax
	movl	registers(,%rax,4), %edx
	movl	-4(%rbp), %eax
	movl	%edx, registers(,%rax,4)
	nop
.L105:
	nop
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE23:
	.size	conditional_move, .-conditional_move
	.section	.rodata
.LC15:
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
	subq	$48, %rsp
	movl	%edi, -36(%rbp)
	movl	%esi, -40(%rbp)
	movl	-36(%rbp), %eax
	movl	registers(,%rax,4), %eax
	movl	%eax, -8(%rbp)
	cmpl	$0, -8(%rbp)
	je	.L107
	movq	MAPPED(%rip), %rax
	movl	-8(%rbp), %edx
	movslq	%edx, %rdx
	salq	$3, %rdx
	addq	%rdx, %rax
	movq	(%rax), %rax
	movl	(%rax), %eax
	movl	%eax, -12(%rbp)
	movl	-12(%rbp), %eax
	cltq
	addq	$1, %rax
	salq	$2, %rax
	movq	%rax, %rdi
	call	malloc
	movq	%rax, -24(%rbp)
	cmpq	$0, -24(%rbp)
	jne	.L108
	movl	$__PRETTY_FUNCTION__.4026, %ecx
	movl	$757, %edx
	movl	$.LC0, %esi
	movl	$.LC15, %edi
	call	__assert_fail
.L108:
	movq	-24(%rbp), %rax
	movl	-12(%rbp), %edx
	movl	%edx, (%rax)
	movl	$0, -4(%rbp)
	jmp	.L109
.L110:
	movq	MAPPED(%rip), %rax
	movl	-8(%rbp), %edx
	movslq	%edx, %rdx
	salq	$3, %rdx
	addq	%rdx, %rax
	movq	(%rax), %rax
	movl	-4(%rbp), %edx
	movslq	%edx, %rdx
	movl	4(%rax,%rdx,4), %ecx
	movq	-24(%rbp), %rax
	movl	-4(%rbp), %edx
	movslq	%edx, %rdx
	movl	%ecx, 4(%rax,%rdx,4)
	addl	$1, -4(%rbp)
.L109:
	movl	-4(%rbp), %eax
	cmpl	-12(%rbp), %eax
	jl	.L110
	movq	MAPPED(%rip), %rax
	movq	(%rax), %rax
	movq	%rax, %rdi
	call	free
	movq	MAPPED(%rip), %rax
	movq	-24(%rbp), %rdx
	movq	%rdx, (%rax)
.L107:
	movl	-40(%rbp), %eax
	movl	registers(,%rax,4), %eax
	subl	$1, %eax
	movl	%eax, prog_counter(%rip)
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE24:
	.size	load_program, .-load_program
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
	movl	%edi, -20(%rbp)
	call	getchar
	movl	%eax, -4(%rbp)
	cmpl	$-1, -4(%rbp)
	jne	.L113
	movl	-20(%rbp), %eax
	movl	$-1, registers(,%rax,4)
	jmp	.L112
.L113:
	movl	-4(%rbp), %edx
	movl	-20(%rbp), %eax
	movl	%edx, registers(,%rax,4)
	nop
.L112:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE25:
	.size	input, .-input
	.section	.rodata
.LC16:
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
	subq	$32, %rsp
	movl	%edi, -20(%rbp)
	cmpl	$255, -20(%rbp)
	jbe	.L117
	movl	$__PRETTY_FUNCTION__.4038, %ecx
	movl	$801, %edx
	movl	$.LC0, %esi
	movl	$.LC16, %edi
	call	__assert_fail
.L117:
	movl	-20(%rbp), %eax
	movl	registers(,%rax,4), %eax
	movl	%eax, -4(%rbp)
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
	.type	__PRETTY_FUNCTION__.3921, @object
	.size	__PRETTY_FUNCTION__.3921, 8
__PRETTY_FUNCTION__.3921:
	.string	"init_um"
	.align 8
	.type	__PRETTY_FUNCTION__.3899, @object
	.size	__PRETTY_FUNCTION__.3899, 13
__PRETTY_FUNCTION__.3899:
	.string	"Bitpack_newu"
	.type	__PRETTY_FUNCTION__.4038, @object
	.size	__PRETTY_FUNCTION__.4038, 7
__PRETTY_FUNCTION__.4038:
	.string	"output"
	.align 8
	.type	__PRETTY_FUNCTION__.4026, @object
	.size	__PRETTY_FUNCTION__.4026, 13
__PRETTY_FUNCTION__.4026:
	.string	"load_program"
	.align 8
	.type	__PRETTY_FUNCTION__.3984, @object
	.size	__PRETTY_FUNCTION__.3984, 12
__PRETTY_FUNCTION__.3984:
	.string	"map_segment"
	.align 8
	.type	__PRETTY_FUNCTION__.3999, @object
	.size	__PRETTY_FUNCTION__.3999, 14
__PRETTY_FUNCTION__.3999:
	.string	"unmap_segment"
	.align 4
.LC5:
	.long	1203982336
	.align 4
.LC6:
	.long	1065353216
	.align 4
.LC7:
	.long	1090519040
	.align 4
.LC8:
	.long	1593835520
	.align 4
.LC11:
	.long	1082130432
	.align 4
.LC14:
	.long	1056964608
	.ident	"GCC: (GNU) 9.1.0"
	.section	.note.GNU-stack,"",@progbits
