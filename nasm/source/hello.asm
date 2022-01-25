
	global _start
	
	section	.text
_start:	mov	rax, 1			//write系统调用
	mov	rdi, 1			//文件描述符
	mov	rsi, message		//字符串地址
	mov	rdx, 13			//字符串长度
	syscall				//系统调用
	mov	rax, 60
	xor	rdi, rdi
	syscall

	section	.data
message:db	"hello, World",10


