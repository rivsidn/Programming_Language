	;主扇区程序
	;通过主扇区程序引导kernel
	;主要分两部分:
	;1. 设置段描述符表，打印信息
	;2. 从硬盘读取内核代码，跳转到内核代码执行

	mov ax, 0
	mov ds, ax
	mov eax, [pgdt+0x7c00+0x02]
	mov edx, 0
	mov ebx, 16
	div ebx

	mov ds, ax
	mov ebx, edx

	;0# 号段描述符：规定的空描述符
	mov dword [ebx+0x00], 0
	mov dword [ebx+0x04], 0
	;1# 号段描述符：
	mov dword [ebx+0x08], 0
	mov dword [ebx+0x0c], 0
	;2# 号段描述符
	mov dword [ebx+0x10], 0
	mov dword [ebx+0x14], 0
	;3# 号段描述符
	mov dword [ebx+0x18], 0
	mov dword [ebx+0x1c], 0
	;4# 号段描述符
	mov dword [ebx+0x20], 0
	mov dword [ebx+0x24], 0



	;加载GDT必要的准备工作
pgdt	dw 0
	dd 0x00007e00

	;主引导扇区程序，确保主引导扇区程序有效
	times 510-($-$$) db 0
	db 0x55, 0xaa



