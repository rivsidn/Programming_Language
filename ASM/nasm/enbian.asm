	global	main
	extern	printf

	section	.text
main:
	sub rsp, 8

	mov dx, 0x1234

	mov rdi, fmt
	mov rsi, dh		; 不允许这样操作，如何曲线救国
	xor rax, rax
	call printf

	mov rdi, fmt
	mov rsi, dl
	xor rax, rax
	call printf

	add rsp, 8

	section	.data
fmt:
	db "%d", 10
