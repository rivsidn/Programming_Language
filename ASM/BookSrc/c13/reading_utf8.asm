	cld

	mov eax,[edi+0x04]
	mov es,eax                         ;es -> ç¨æ·ç¨åºå¤´é¨ 
	mov eax,core_data_seg_sel
	mov ds,eax

	mov ecx,[es:0x24]                  ;ç¨æ·ç¨åºçSALTæ¡ç®æ°
	mov edi,0x28                       ;ç¨æ·ç¨åºåçSALTä½äºå¤´é¨å0x28å¤
.b2: 
	push ecx
	push edi

	mov ecx,salt_items
	mov esi,salt
.b3:
	push edi
	push esi
	push ecx

	mov ecx,64                         ;æ£ç´¢è¡¨ä¸­ï¼æ¯æ¡ç®çæ¯è¾æ¬¡æ° 
	repe cmpsd                         ;æ¯æ¬¡æ¯è¾4å­è 
	jnz .b4
	mov eax,[esi]                      ;è¥å¹éï¼esiæ°å¥½æåå¶åçå°åæ°æ®
	mov [es:edi-256],eax               ;å°å­ç¬¦ä¸²æ¹åæåç§»å°å 
	mov ax,[esi+4]
	mov [es:edi-252],ax                ;ä»¥åæ®µéæ©å­ 
.b4:
	pop ecx
	pop esi
	add esi,salt_item_len
	pop edi                            ;ä»å¤´æ¯è¾ 
	loop .b3

	pop edi
	add edi,256
	pop ecx
	loop .b2

