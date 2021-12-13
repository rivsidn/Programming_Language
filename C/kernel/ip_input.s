ip_rcv:
	pushq	%rbp
	movq	%rsp, %rbp
	movq	%rdi, -8(%rbp)		//rdi 第一个参数
	movq	%rsi, -16(%rbp)		//rsi 第二个参数
	movq	%rdx, -24(%rbp)		//rdx 第三个参数
	movq	%rcx, -32(%rbp)		//rcx 第四个参数
	movq	-8(%rbp), %rax
	movl	$0, (%rax)
	nop
	popq	%rbp
	ret
main:
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$32, %rsp
	movq	%fs:40, %rax
	movq	%rax, -8(%rbp)
	xorl	%eax, %eax
	movl	$1, -24(%rbp)
	movl	$2, -20(%rbp)
	movl	$3, -16(%rbp)
	movl	$4, -12(%rbp)
	leaq	-12(%rbp), %rcx
	leaq	-16(%rbp), %rdx
	leaq	-20(%rbp), %rsi
	leaq	-24(%rbp), %rax
	movq	%rax, %rdi
	call	ip_rcv
	movl	-12(%rbp), %esi
	movl	-16(%rbp), %ecx
	movl	-20(%rbp), %edx
	movl	-24(%rbp), %eax
	movl	%esi, %r8d
	movl	%eax, %esi
	leaq	.LC0(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	movl	$0, %eax
	movq	-8(%rbp), %rdi
	xorq	%fs:40, %rdi
	je	.L4
	call	__stack_chk_fail@PLT
	leave
	ret
