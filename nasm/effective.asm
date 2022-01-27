	global	main
	extern	printf

	section	.text
main:
	push	rbx
	mov	rbx, number

	sub	rsp, 8
	mov	rdi, fmt
	mov	rsi, [rbx]
	xor	rax, rax
	call	printf
	add	rsp, 8

	pop	rbx
	ret

	section	.data
fmt	db	"%x", 10, 0
number	db	-0.2

