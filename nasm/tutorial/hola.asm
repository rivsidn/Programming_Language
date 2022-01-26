	global	main
	extern	puts

	section .text
main:
	mov	rdi, message
	call	puts
	ret

	section	.data
message:
	db	"hola, mundo", 0
