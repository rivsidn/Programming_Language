	cld

	mov eax,[edi+0x04]
	mov es,eax                         ;es -> 用户程序头部 
	mov eax,core_data_seg_sel
	mov ds,eax

	mov ecx,[es:0x24]                  ;用户程序的SALT条目数
	mov edi,0x28                       ;用户程序内的SALT位于头部内0x28处
.b2: 
	push ecx
	push edi

	mov ecx,salt_items
	mov esi,salt
.b3:
	push edi
	push esi
	push ecx

	mov ecx,64                         ;检索表中，每条目的比较次数 
	repe cmpsd                         ;每次比较4字节 
	jnz .b4
	mov eax,[esi]                      ;若匹配，esi恰好指向其后的地址数据
	mov [es:edi-256],eax               ;将字符串改写成偏移地址 
	mov ax,[esi+4]
	mov [es:edi-252],ax                ;以及段选择子 
.b4:
	pop ecx
	pop esi
	add esi,salt_item_len
	pop edi                            ;从头比较 
	loop .b3

	pop edi
	add edi,256
	pop ecx
	loop .b2

