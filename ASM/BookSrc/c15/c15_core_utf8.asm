         ;´úÂëÇåµ¥15-1
         ;ÎÄ¼þÃû£ºc15_core.asm
         ;ÎÄ¼þËµÃ÷£º±£»¤Ä£Ê½Î¢ÐÍºËÐÄ³ÌÐò 
         ;´´½¨ÈÕÆÚ£º2011-11-19 21:40

         ;ÒÔÏÂ³£Á¿¶¨Òå²¿·Ö¡£ÄÚºËµÄ´ó²¿·ÖÄÚÈÝ¶¼Ó¦µ±¹Ì¶¨ 
         core_code_seg_sel     equ  0x38    ;ÄÚºË´úÂë¶ÎÑ¡Ôñ×Ó
         core_data_seg_sel     equ  0x30    ;ÄÚºËÊý¾Ý¶ÎÑ¡Ôñ×Ó 
         sys_routine_seg_sel   equ  0x28    ;ÏµÍ³¹«¹²Àý³Ì´úÂë¶ÎµÄÑ¡Ôñ×Ó 
         video_ram_seg_sel     equ  0x20    ;ÊÓÆµÏÔÊ¾»º³åÇøµÄ¶ÎÑ¡Ôñ×Ó
         core_stack_seg_sel    equ  0x18    ;ÄÚºË¶ÑÕ»¶ÎÑ¡Ôñ×Ó
         mem_0_4_gb_seg_sel    equ  0x08    ;Õû¸ö0-4GBÄÚ´æµÄ¶ÎµÄÑ¡Ôñ×Ó

;-------------------------------------------------------------------------------
         ;ÒÔÏÂÊÇÏµÍ³ºËÐÄµÄÍ·²¿£¬ÓÃÓÚ¼ÓÔØºËÐÄ³ÌÐò 
         core_length      dd core_end       ;ºËÐÄ³ÌÐò×Ü³¤¶È#00

         sys_routine_seg  dd section.sys_routine.start
                                            ;ÏµÍ³¹«ÓÃÀý³Ì¶ÎÎ»ÖÃ#04

         core_data_seg    dd section.core_data.start
                                            ;ºËÐÄÊý¾Ý¶ÎÎ»ÖÃ#08

         core_code_seg    dd section.core_code.start
                                            ;ºËÐÄ´úÂë¶ÎÎ»ÖÃ#0c


         core_entry       dd start          ;ºËÐÄ´úÂë¶ÎÈë¿Úµã#10
                          dw core_code_seg_sel

;===============================================================================
         [bits 32]
;===============================================================================
SECTION sys_routine vstart=0                ;ÏµÍ³¹«¹²Àý³Ì´úÂë¶Î 
;-------------------------------------------------------------------------------
         ;×Ö·û´®ÏÔÊ¾Àý³Ì
put_string:                                 ;ÏÔÊ¾0ÖÕÖ¹µÄ×Ö·û´®²¢ÒÆ¶¯¹â±ê 
                                            ;ÊäÈë£ºDS:EBX=´®µØÖ·
         push ecx
  .getc:
         mov cl,[ebx]
         or cl,cl
         jz .exit
         call put_char
         inc ebx
         jmp .getc

  .exit:
         pop ecx
         retf                               ;¶Î¼ä·µ»Ø

;-------------------------------------------------------------------------------
put_char:                                   ;ÔÚµ±Ç°¹â±ê´¦ÏÔÊ¾Ò»¸ö×Ö·û,²¢ÍÆ½ø
                                            ;¹â±ê¡£½öÓÃÓÚ¶ÎÄÚµ÷ÓÃ 
                                            ;ÊäÈë£ºCL=×Ö·ûASCIIÂë 
         pushad

         ;ÒÔÏÂÈ¡µ±Ç°¹â±êÎ»ÖÃ
         mov dx,0x3d4
         mov al,0x0e
         out dx,al
         inc dx                             ;0x3d5
         in al,dx                           ;¸ß×Ö
         mov ah,al

         dec dx                             ;0x3d4
         mov al,0x0f
         out dx,al
         inc dx                             ;0x3d5
         in al,dx                           ;µÍ×Ö
         mov bx,ax                          ;BX=´ú±í¹â±êÎ»ÖÃµÄ16Î»Êý

         cmp cl,0x0d                        ;»Ø³µ·û£¿
         jnz .put_0a
         mov ax,bx
         mov bl,80
         div bl
         mul bl
         mov bx,ax
         jmp .set_cursor

  .put_0a:
         cmp cl,0x0a                        ;»»ÐÐ·û£¿
         jnz .put_other
         add bx,80
         jmp .roll_screen

  .put_other:                               ;Õý³£ÏÔÊ¾×Ö·û
         push es
         mov eax,video_ram_seg_sel          ;0xb8000¶ÎµÄÑ¡Ôñ×Ó
         mov es,eax
         shl bx,1
         mov [es:bx],cl
         pop es

         ;ÒÔÏÂ½«¹â±êÎ»ÖÃÍÆ½øÒ»¸ö×Ö·û
         shr bx,1
         inc bx

  .roll_screen:
         cmp bx,2000                        ;¹â±ê³¬³öÆÁÄ»£¿¹öÆÁ
         jl .set_cursor

         push ds
         push es
         mov eax,video_ram_seg_sel
         mov ds,eax
         mov es,eax
         cld
         mov esi,0xa0                       ;Ð¡ÐÄ£¡32Î»Ä£Ê½ÏÂmovsb/w/d 
         mov edi,0x00                       ;Ê¹ÓÃµÄÊÇesi/edi/ecx 
         mov ecx,1920
         rep movsd
         mov bx,3840                        ;Çå³ýÆÁÄ»×îµ×Ò»ÐÐ
         mov ecx,80                         ;32Î»³ÌÐòÓ¦¸ÃÊ¹ÓÃECX
  .cls:
         mov word[es:bx],0x0720
         add bx,2
         loop .cls

         pop es
         pop ds

         mov bx,1920

  .set_cursor:
         mov dx,0x3d4
         mov al,0x0e
         out dx,al
         inc dx                             ;0x3d5
         mov al,bh
         out dx,al
         dec dx                             ;0x3d4
         mov al,0x0f
         out dx,al
         inc dx                             ;0x3d5
         mov al,bl
         out dx,al

         popad
         
         ret                                

;-------------------------------------------------------------------------------
read_hard_disk_0:                           ;´ÓÓ²ÅÌ¶ÁÈ¡Ò»¸öÂß¼­ÉÈÇø
                                            ;EAX=Âß¼­ÉÈÇøºÅ
                                            ;DS:EBX=Ä¿±ê»º³åÇøµØÖ·
                                            ;·µ»Ø£ºEBX=EBX+512
         push eax 
         push ecx
         push edx
      
         push eax
         
         mov dx,0x1f2
         mov al,1
         out dx,al                          ;¶ÁÈ¡µÄÉÈÇøÊý

         inc dx                             ;0x1f3
         pop eax
         out dx,al                          ;LBAµØÖ·7~0

         inc dx                             ;0x1f4
         mov cl,8
         shr eax,cl
         out dx,al                          ;LBAµØÖ·15~8

         inc dx                             ;0x1f5
         shr eax,cl
         out dx,al                          ;LBAµØÖ·23~16

         inc dx                             ;0x1f6
         shr eax,cl
         or al,0xe0                         ;µÚÒ»Ó²ÅÌ  LBAµØÖ·27~24
         out dx,al

         inc dx                             ;0x1f7
         mov al,0x20                        ;¶ÁÃüÁî
         out dx,al

  .waits:
         in al,dx
         and al,0x88
         cmp al,0x08
         jnz .waits                         ;²»Ã¦£¬ÇÒÓ²ÅÌÒÑ×¼±¸ºÃÊý¾Ý´«Êä 

         mov ecx,256                        ;×Ü¹²Òª¶ÁÈ¡µÄ×ÖÊý
         mov dx,0x1f0
  .readw:
         in ax,dx
         mov [ebx],ax
         add ebx,2
         loop .readw

         pop edx
         pop ecx
         pop eax
      
         retf                               ;¶Î¼ä·µ»Ø 

;-------------------------------------------------------------------------------
;»ã±àÓïÑÔ³ÌÐòÊÇ¼«ÄÑÒ»´Î³É¹¦£¬¶øÇÒµ÷ÊÔ·Ç³£À§ÄÑ¡£Õâ¸öÀý³Ì¿ÉÒÔÌá¹©°ïÖú 
put_hex_dword:                              ;ÔÚµ±Ç°¹â±ê´¦ÒÔÊ®Áù½øÖÆÐÎÊ½ÏÔÊ¾
                                            ;Ò»¸öË«×Ö²¢ÍÆ½ø¹â±ê 
                                            ;ÊäÈë£ºEDX=Òª×ª»»²¢ÏÔÊ¾µÄÊý×Ö
                                            ;Êä³ö£ºÎÞ
         pushad
         push ds
      
         mov ax,core_data_seg_sel           ;ÇÐ»»µ½ºËÐÄÊý¾Ý¶Î 
         mov ds,ax
      
         mov ebx,bin_hex                    ;Ö¸ÏòºËÐÄÊý¾Ý¶ÎÄÚµÄ×ª»»±í
         mov ecx,8
  .xlt:    
         rol edx,4
         mov eax,edx
         and eax,0x0000000f
         xlat
      
         push ecx
         mov cl,al                           
         call put_char
         pop ecx
       
         loop .xlt
      
         pop ds
         popad
         retf
      
;-------------------------------------------------------------------------------
allocate_memory:                            ;·ÖÅäÄÚ´æ
                                            ;ÊäÈë£ºECX=Ï£Íû·ÖÅäµÄ×Ö½ÚÊý
                                            ;Êä³ö£ºECX=ÆðÊ¼ÏßÐÔµØÖ· 
         push ds
         push eax
         push ebx
      
         mov eax,core_data_seg_sel
         mov ds,eax
      
         mov eax,[ram_alloc]
         add eax,ecx                        ;ÏÂÒ»´Î·ÖÅäÊ±µÄÆðÊ¼µØÖ·
      
         ;ÕâÀïÓ¦µ±ÓÐ¼ì²â¿ÉÓÃÄÚ´æÊýÁ¿µÄÖ¸Áî
          
         mov ecx,[ram_alloc]                ;·µ»Ø·ÖÅäµÄÆðÊ¼µØÖ·

         mov ebx,eax
         and ebx,0xfffffffc
         add ebx,4                          ;Ç¿ÖÆ¶ÔÆë 
         test eax,0x00000003                ;ÏÂ´Î·ÖÅäµÄÆðÊ¼µØÖ·×îºÃÊÇ4×Ö½Ú¶ÔÆë
         cmovnz eax,ebx                     ;Èç¹ûÃ»ÓÐ¶ÔÆë£¬ÔòÇ¿ÖÆ¶ÔÆë 
         mov [ram_alloc],eax                ;ÏÂ´Î´Ó¸ÃµØÖ··ÖÅäÄÚ´æ
                                            ;cmovccÖ¸Áî¿ÉÒÔ±ÜÃâ¿ØÖÆ×ªÒÆ 
         pop ebx
         pop eax
         pop ds

         retf

;-------------------------------------------------------------------------------
set_up_gdt_descriptor:                      ;ÔÚGDTÄÚ°²×°Ò»¸öÐÂµÄÃèÊö·û
                                            ;ÊäÈë£ºEDX:EAX=ÃèÊö·û 
                                            ;Êä³ö£ºCX=ÃèÊö·ûµÄÑ¡Ôñ×Ó
         push eax
         push ebx
         push edx

         push ds
         push es

         mov ebx,core_data_seg_sel          ;ÇÐ»»µ½ºËÐÄÊý¾Ý¶Î
         mov ds,ebx

         sgdt [pgdt]                        ;ÒÔ±ã¿ªÊ¼´¦ÀíGDT

         mov ebx,mem_0_4_gb_seg_sel
         mov es,ebx

         movzx ebx,word [pgdt]              ;GDT½çÏÞ
         inc bx                             ;GDT×Ü×Ö½ÚÊý£¬Ò²ÊÇÏÂÒ»¸öÃèÊö·ûÆ«ÒÆ
         add ebx,[pgdt+2]                   ;ÏÂÒ»¸öÃèÊö·ûµÄÏßÐÔµØÖ·

         mov [es:ebx],eax
         mov [es:ebx+4],edx

         add word [pgdt],8                  ;Ôö¼ÓÒ»¸öÃèÊö·ûµÄ´óÐ¡

         lgdt [pgdt]                        ;¶ÔGDTµÄ¸ü¸ÄÉúÐ§

         mov ax,[pgdt]                      ;µÃµ½GDT½çÏÞÖµ
         xor dx,dx
         mov bx,8
         div bx                             ;³ýÒÔ8£¬È¥µôÓàÊý
         mov cx,ax
         shl cx,3                           ;½«Ë÷ÒýºÅÒÆµ½ÕýÈ·Î»ÖÃ

         pop es
         pop ds

         pop edx
         pop ebx
         pop eax

         retf
;-------------------------------------------------------------------------------
make_seg_descriptor:                        ;¹¹Ôì´æ´¢Æ÷ºÍÏµÍ³µÄ¶ÎÃèÊö·û
                                            ;ÊäÈë£ºEAX=ÏßÐÔ»ùµØÖ·
                                            ;      EBX=¶Î½çÏÞ
                                            ;      ECX=ÊôÐÔ¡£¸÷ÊôÐÔÎ»¶¼ÔÚÔ­Ê¼
                                            ;          Î»ÖÃ£¬ÎÞ¹ØµÄÎ»ÇåÁã 
                                            ;·µ»Ø£ºEDX:EAX=ÃèÊö·û
         mov edx,eax
         shl eax,16
         or ax,bx                           ;ÃèÊö·ûÇ°32Î»(EAX)¹¹ÔìÍê±Ï

         and edx,0xffff0000                 ;Çå³ý»ùµØÖ·ÖÐÎÞ¹ØµÄÎ»
         rol edx,8
         bswap edx                          ;×°Åä»ùÖ·µÄ31~24ºÍ23~16  (80486+)

         xor bx,bx
         or edx,ebx                         ;×°Åä¶Î½çÏÞµÄ¸ß4Î»

         or edx,ecx                         ;×°ÅäÊôÐÔ

         retf

;-------------------------------------------------------------------------------
make_gate_descriptor:                       ;¹¹ÔìÃÅµÄÃèÊö·û£¨µ÷ÓÃÃÅµÈ£©
                                            ;ÊäÈë£ºEAX=ÃÅ´úÂëÔÚ¶ÎÄÚÆ«ÒÆµØÖ·
                                            ;       BX=ÃÅ´úÂëËùÔÚ¶ÎµÄÑ¡Ôñ×Ó 
                                            ;       CX=¶ÎÀàÐÍ¼°ÊôÐÔµÈ£¨¸÷Êô
                                            ;          ÐÔÎ»¶¼ÔÚÔ­Ê¼Î»ÖÃ£©
                                            ;·µ»Ø£ºEDX:EAX=ÍêÕûµÄÃèÊö·û
         push ebx
         push ecx
      
         mov edx,eax
         and edx,0xffff0000                 ;µÃµ½Æ«ÒÆµØÖ·¸ß16Î» 
         or dx,cx                           ;×é×°ÊôÐÔ²¿·Öµ½EDX
       
         and eax,0x0000ffff                 ;µÃµ½Æ«ÒÆµØÖ·µÍ16Î» 
         shl ebx,16                          
         or eax,ebx                         ;×é×°¶ÎÑ¡Ôñ×Ó²¿·Ö
      
         pop ecx
         pop ebx
      
         retf                                   
                             
;-------------------------------------------------------------------------------
terminate_current_task:                     ;ÖÕÖ¹µ±Ç°ÈÎÎñ
                                            ;×¢Òâ£¬Ö´ÐÐ´ËÀý³ÌÊ±£¬µ±Ç°ÈÎÎñÈÔÔÚ
                                            ;ÔËÐÐÖÐ¡£´ËÀý³ÌÆäÊµÒ²ÊÇµ±Ç°ÈÎÎñµÄ
                                            ;Ò»²¿·Ö 
         pushfd
         mov edx,[esp]                      ;»ñµÃEFLAGS¼Ä´æÆ÷ÄÚÈÝ
         add esp,4                          ;»Ö¸´¶ÑÕ»Ö¸Õë

         mov eax,core_data_seg_sel
         mov ds,eax

         test dx,0100_0000_0000_0000B       ;²âÊÔNTÎ»
         jnz .b1                            ;µ±Ç°ÈÎÎñÊÇÇ¶Ì×µÄ£¬µ½.b1Ö´ÐÐiretd 
         mov ebx,core_msg1                  ;µ±Ç°ÈÎÎñ²»ÊÇÇ¶Ì×µÄ£¬Ö±½ÓÇÐ»»µ½ 
         call sys_routine_seg_sel:put_string
         jmp far [prgman_tss]               ;³ÌÐò¹ÜÀíÆ÷ÈÎÎñ 
       
  .b1: 
         mov ebx,core_msg0
         call sys_routine_seg_sel:put_string
         iretd
      
sys_routine_end:

;===============================================================================
SECTION core_data vstart=0                  ;ÏµÍ³ºËÐÄµÄÊý¾Ý¶Î 
;------------------------------------------------------------------------------- 
         pgdt             dw  0             ;ÓÃÓÚÉèÖÃºÍÐÞ¸ÄGDT 
                          dd  0

         ram_alloc        dd  0x00100000    ;ÏÂ´Î·ÖÅäÄÚ´æÊ±µÄÆðÊ¼µØÖ·

         ;·ûºÅµØÖ·¼ìË÷±í
         salt:
         salt_1           db  '@PrintString'
                     times 256-($-salt_1) db 0
                          dd  put_string
                          dw  sys_routine_seg_sel

         salt_2           db  '@ReadDiskData'
                     times 256-($-salt_2) db 0
                          dd  read_hard_disk_0
                          dw  sys_routine_seg_sel

         salt_3           db  '@PrintDwordAsHexString'
                     times 256-($-salt_3) db 0
                          dd  put_hex_dword
                          dw  sys_routine_seg_sel

         salt_4           db  '@TerminateProgram'
                     times 256-($-salt_4) db 0
                          dd  terminate_current_task
                          dw  sys_routine_seg_sel

         salt_item_len   equ $-salt_4
         salt_items      equ ($-salt)/salt_item_len

         message_1        db  '  If you seen this message,that means we '
                          db  'are now in protect mode,and the system '
                          db  'core is loaded,and the video display '
                          db  'routine works perfectly.',0x0d,0x0a,0

         message_2        db  '  System wide CALL-GATE mounted.',0x0d,0x0a,0
         
         bin_hex          db '0123456789ABCDEF'
                                            ;put_hex_dword×Ó¹ý³ÌÓÃµÄ²éÕÒ±í 

         core_buf   times 2048 db 0         ;ÄÚºËÓÃµÄ»º³åÇø

         cpu_brnd0        db 0x0d,0x0a,'  ',0
         cpu_brand  times 52 db 0
         cpu_brnd1        db 0x0d,0x0a,0x0d,0x0a,0

         ;ÈÎÎñ¿ØÖÆ¿éÁ´
         tcb_chain        dd  0

         ;³ÌÐò¹ÜÀíÆ÷µÄÈÎÎñÐÅÏ¢ 
         prgman_tss       dd  0             ;³ÌÐò¹ÜÀíÆ÷µÄTSS»ùµØÖ·
                          dw  0             ;³ÌÐò¹ÜÀíÆ÷µÄTSSÃèÊö·ûÑ¡Ôñ×Ó 

         prgman_msg1      db  0x0d,0x0a
                          db  '[PROGRAM MANAGER]: Hello! I am Program Manager,'
                          db  'run at CPL=0.Now,create user task and switch '
                          db  'to it by the CALL instruction...',0x0d,0x0a,0
                 
         prgman_msg2      db  0x0d,0x0a
                          db  '[PROGRAM MANAGER]: I am glad to regain control.'
                          db  'Now,create another user task and switch to '
                          db  'it by the JMP instruction...',0x0d,0x0a,0
                 
         prgman_msg3      db  0x0d,0x0a
                          db  '[PROGRAM MANAGER]: I am gain control again,'
                          db  'HALT...',0

         core_msg0        db  0x0d,0x0a
                          db  '[SYSTEM CORE]: Uh...This task initiated with '
                          db  'CALL instruction or an exeception/ interrupt,'
                          db  'should use IRETD instruction to switch back...'
                          db  0x0d,0x0a,0

         core_msg1        db  0x0d,0x0a
                          db  '[SYSTEM CORE]: Uh...This task initiated with '
                          db  'JMP instruction,  should switch to Program '
                          db  'Manager directly by the JMP instruction...'
                          db  0x0d,0x0a,0

core_data_end:
               
;===============================================================================
SECTION core_code vstart=0
;-------------------------------------------------------------------------------
fill_descriptor_in_ldt:                     ;ÔÚLDTÄÚ°²×°Ò»¸öÐÂµÄÃèÊö·û
                                            ;ÊäÈë£ºEDX:EAX=ÃèÊö·û
                                            ;          EBX=TCB»ùµØÖ·
                                            ;Êä³ö£ºCX=ÃèÊö·ûµÄÑ¡Ôñ×Ó
         push eax
         push edx
         push edi
         push ds

         mov ecx,mem_0_4_gb_seg_sel
         mov ds,ecx

         mov edi,[ebx+0x0c]                 ;»ñµÃLDT»ùµØÖ·
         
         xor ecx,ecx
         mov cx,[ebx+0x0a]                  ;»ñµÃLDT½çÏÞ
         inc cx                             ;LDTµÄ×Ü×Ö½ÚÊý£¬¼´ÐÂÃèÊö·ûÆ«ÒÆµØÖ·
         
         mov [edi+ecx+0x00],eax
         mov [edi+ecx+0x04],edx             ;°²×°ÃèÊö·û

         add cx,8                           
         dec cx                             ;µÃµ½ÐÂµÄLDT½çÏÞÖµ 

         mov [ebx+0x0a],cx                  ;¸üÐÂLDT½çÏÞÖµµ½TCB

         mov ax,cx
         xor dx,dx
         mov cx,8
         div cx
         
         mov cx,ax
         shl cx,3                           ;×óÒÆ3Î»£¬²¢ÇÒ
         or cx,0000_0000_0000_0100B         ;Ê¹TIÎ»=1£¬Ö¸ÏòLDT£¬×îºóÊ¹RPL=00 

         pop ds
         pop edi
         pop edx
         pop eax
     
         ret
         
;------------------------------------------------------------------------------- 
load_relocate_program:                      ;¼ÓÔØ²¢ÖØ¶¨Î»ÓÃ»§³ÌÐò
                                            ;ÊäÈë: PUSH Âß¼­ÉÈÇøºÅ
                                            ;      PUSH ÈÎÎñ¿ØÖÆ¿é»ùµØÖ·
                                            ;Êä³ö£ºÎÞ 
         pushad
      
         push ds
         push es
      
         mov ebp,esp                        ;Îª·ÃÎÊÍ¨¹ý¶ÑÕ»´«µÝµÄ²ÎÊý×ö×¼±¸
      
         mov ecx,mem_0_4_gb_seg_sel
         mov es,ecx
      
         mov esi,[ebp+11*4]                 ;´Ó¶ÑÕ»ÖÐÈ¡µÃTCBµÄ»ùµØÖ·

         ;ÒÔÏÂÉêÇë´´½¨LDTËùÐèÒªµÄÄÚ´æ
         mov ecx,160                        ;ÔÊÐí°²×°20¸öLDTÃèÊö·û
         call sys_routine_seg_sel:allocate_memory
         mov [es:esi+0x0c],ecx              ;µÇ¼ÇLDT»ùµØÖ·µ½TCBÖÐ
         mov word [es:esi+0x0a],0xffff      ;µÇ¼ÇLDT³õÊ¼µÄ½çÏÞµ½TCBÖÐ 

         ;ÒÔÏÂ¿ªÊ¼¼ÓÔØÓÃ»§³ÌÐò 
         mov eax,core_data_seg_sel
         mov ds,eax                         ;ÇÐ»»DSµ½ÄÚºËÊý¾Ý¶Î
       
         mov eax,[ebp+12*4]                 ;´Ó¶ÑÕ»ÖÐÈ¡³öÓÃ»§³ÌÐòÆðÊ¼ÉÈÇøºÅ 
         mov ebx,core_buf                   ;¶ÁÈ¡³ÌÐòÍ·²¿Êý¾Ý     
         call sys_routine_seg_sel:read_hard_disk_0

         ;ÒÔÏÂÅÐ¶ÏÕû¸ö³ÌÐòÓÐ¶à´ó
         mov eax,[core_buf]                 ;³ÌÐò³ß´ç
         mov ebx,eax
         and ebx,0xfffffe00                 ;Ê¹Ö®512×Ö½Ú¶ÔÆë£¨ÄÜ±»512Õû³ýµÄÊýµÍ 
         add ebx,512                        ;9Î»¶¼Îª0 
         test eax,0x000001ff                ;³ÌÐòµÄ´óÐ¡ÕýºÃÊÇ512µÄ±¶ÊýÂð? 
         cmovnz eax,ebx                     ;²»ÊÇ¡£Ê¹ÓÃ´ÕÕûµÄ½á¹û
      
         mov ecx,eax                        ;Êµ¼ÊÐèÒªÉêÇëµÄÄÚ´æÊýÁ¿
         call sys_routine_seg_sel:allocate_memory
         mov [es:esi+0x06],ecx              ;µÇ¼Ç³ÌÐò¼ÓÔØ»ùµØÖ·µ½TCBÖÐ
      
         mov ebx,ecx                        ;ebx -> ÉêÇëµ½µÄÄÚ´æÊ×µØÖ·
         xor edx,edx
         mov ecx,512
         div ecx
         mov ecx,eax                        ;×ÜÉÈÇøÊý 
      
         mov eax,mem_0_4_gb_seg_sel         ;ÇÐ»»DSµ½0-4GBµÄ¶Î
         mov ds,eax

         mov eax,[ebp+12*4]                 ;ÆðÊ¼ÉÈÇøºÅ 
  .b1:
         call sys_routine_seg_sel:read_hard_disk_0
         inc eax
         loop .b1                           ;Ñ­»·¶Á£¬Ö±µ½¶ÁÍêÕû¸öÓÃ»§³ÌÐò

         mov edi,[es:esi+0x06]              ;»ñµÃ³ÌÐò¼ÓÔØ»ùµØÖ·

         ;½¨Á¢³ÌÐòÍ·²¿¶ÎÃèÊö·û
         mov eax,edi                        ;³ÌÐòÍ·²¿ÆðÊ¼ÏßÐÔµØÖ·
         mov ebx,[edi+0x04]                 ;¶Î³¤¶È
         dec ebx                            ;¶Î½çÏÞ
         mov ecx,0x0040f200                 ;×Ö½ÚÁ£¶ÈµÄÊý¾Ý¶ÎÃèÊö·û£¬ÌØÈ¨¼¶3 
         call sys_routine_seg_sel:make_seg_descriptor
      
         ;°²×°Í·²¿¶ÎÃèÊö·ûµ½LDTÖÐ 
         mov ebx,esi                        ;TCBµÄ»ùµØÖ·
         call fill_descriptor_in_ldt

         or cx,0000_0000_0000_0011B         ;ÉèÖÃÑ¡Ôñ×ÓµÄÌØÈ¨¼¶Îª3
         mov [es:esi+0x44],cx               ;µÇ¼Ç³ÌÐòÍ·²¿¶ÎÑ¡Ôñ×Óµ½TCB 
         mov [edi+0x04],cx                  ;ºÍÍ·²¿ÄÚ 
      
         ;½¨Á¢³ÌÐò´úÂë¶ÎÃèÊö·û
         mov eax,edi
         add eax,[edi+0x14]                 ;´úÂëÆðÊ¼ÏßÐÔµØÖ·
         mov ebx,[edi+0x18]                 ;¶Î³¤¶È
         dec ebx                            ;¶Î½çÏÞ
         mov ecx,0x0040f800                 ;×Ö½ÚÁ£¶ÈµÄ´úÂë¶ÎÃèÊö·û£¬ÌØÈ¨¼¶3
         call sys_routine_seg_sel:make_seg_descriptor
         mov ebx,esi                        ;TCBµÄ»ùµØÖ·
         call fill_descriptor_in_ldt
         or cx,0000_0000_0000_0011B         ;ÉèÖÃÑ¡Ôñ×ÓµÄÌØÈ¨¼¶Îª3
         mov [edi+0x14],cx                  ;µÇ¼Ç´úÂë¶ÎÑ¡Ôñ×Óµ½Í·²¿

         ;½¨Á¢³ÌÐòÊý¾Ý¶ÎÃèÊö·û
         mov eax,edi
         add eax,[edi+0x1c]                 ;Êý¾Ý¶ÎÆðÊ¼ÏßÐÔµØÖ·
         mov ebx,[edi+0x20]                 ;¶Î³¤¶È
         dec ebx                            ;¶Î½çÏÞ 
         mov ecx,0x0040f200                 ;×Ö½ÚÁ£¶ÈµÄÊý¾Ý¶ÎÃèÊö·û£¬ÌØÈ¨¼¶3
         call sys_routine_seg_sel:make_seg_descriptor
         mov ebx,esi                        ;TCBµÄ»ùµØÖ·
         call fill_descriptor_in_ldt
         or cx,0000_0000_0000_0011B         ;ÉèÖÃÑ¡Ôñ×ÓµÄÌØÈ¨¼¶Îª3
         mov [edi+0x1c],cx                  ;µÇ¼ÇÊý¾Ý¶ÎÑ¡Ôñ×Óµ½Í·²¿

         ;½¨Á¢³ÌÐò¶ÑÕ»¶ÎÃèÊö·û
         mov ecx,[edi+0x0c]                 ;4KBµÄ±¶ÂÊ 
         mov ebx,0x000fffff
         sub ebx,ecx                        ;µÃµ½¶Î½çÏÞ
         mov eax,4096                        
         mul ecx                         
         mov ecx,eax                        ;×¼±¸Îª¶ÑÕ»·ÖÅäÄÚ´æ 
         call sys_routine_seg_sel:allocate_memory
         add eax,ecx                        ;µÃµ½¶ÑÕ»µÄ¸ß¶ËÎïÀíµØÖ· 
         mov ecx,0x00c0f600                 ;×Ö½ÚÁ£¶ÈµÄ¶ÑÕ»¶ÎÃèÊö·û£¬ÌØÈ¨¼¶3
         call sys_routine_seg_sel:make_seg_descriptor
         mov ebx,esi                        ;TCBµÄ»ùµØÖ·
         call fill_descriptor_in_ldt
         or cx,0000_0000_0000_0011B         ;ÉèÖÃÑ¡Ôñ×ÓµÄÌØÈ¨¼¶Îª3
         mov [edi+0x08],cx                  ;µÇ¼Ç¶ÑÕ»¶ÎÑ¡Ôñ×Óµ½Í·²¿

         ;ÖØ¶¨Î»SALT 
         mov eax,mem_0_4_gb_seg_sel         ;ÕâÀïºÍÇ°Ò»ÕÂ²»Í¬£¬Í·²¿¶ÎÃèÊö·û
         mov es,eax                         ;ÒÑ°²×°£¬µ«»¹Ã»ÓÐÉúÐ§£¬¹ÊÖ»ÄÜÍ¨
                                            ;¹ý4GB¶Î·ÃÎÊÓÃ»§³ÌÐòÍ·²¿          
         mov eax,core_data_seg_sel
         mov ds,eax
      
         cld

         mov ecx,[es:edi+0x24]              ;U-SALTÌõÄ¿Êý(Í¨¹ý·ÃÎÊ4GB¶ÎÈ¡µÃ) 
         add edi,0x28                       ;U-SALTÔÚ4GB¶ÎÄÚµÄÆ«ÒÆ 
  .b2: 
         push ecx
         push edi
      
         mov ecx,salt_items
         mov esi,salt
  .b3:
         push edi
         push esi
         push ecx

         mov ecx,64                         ;¼ìË÷±íÖÐ£¬Ã¿ÌõÄ¿µÄ±È½Ï´ÎÊý 
         repe cmpsd                         ;Ã¿´Î±È½Ï4×Ö½Ú 
         jnz .b4
         mov eax,[esi]                      ;ÈôÆ¥Åä£¬ÔòesiÇ¡ºÃÖ¸ÏòÆäºóµÄµØÖ·
         mov [es:edi-256],eax               ;½«×Ö·û´®¸ÄÐ´³ÉÆ«ÒÆµØÖ· 
         mov ax,[esi+4]
         or ax,0000000000000011B            ;ÒÔÓÃ»§³ÌÐò×Ô¼ºµÄÌØÈ¨¼¶Ê¹ÓÃµ÷ÓÃÃÅ
                                            ;¹ÊRPL=3 
         mov [es:edi-252],ax                ;»ØÌîµ÷ÓÃÃÅÑ¡Ôñ×Ó 
  .b4:
      
         pop ecx
         pop esi
         add esi,salt_item_len
         pop edi                            ;´ÓÍ·±È½Ï 
         loop .b3
      
         pop edi
         add edi,256
         pop ecx
         loop .b2

         mov esi,[ebp+11*4]                 ;´Ó¶ÑÕ»ÖÐÈ¡µÃTCBµÄ»ùµØÖ·

         ;´´½¨0ÌØÈ¨¼¶¶ÑÕ»
         mov ecx,4096
         mov eax,ecx                        ;ÎªÉú³É¶ÑÕ»¸ß¶ËµØÖ·×ö×¼±¸ 
         mov [es:esi+0x1a],ecx
         shr dword [es:esi+0x1a],12         ;µÇ¼Ç0ÌØÈ¨¼¶¶ÑÕ»³ß´çµ½TCB 
         call sys_routine_seg_sel:allocate_memory
         add eax,ecx                        ;¶ÑÕ»±ØÐëÊ¹ÓÃ¸ß¶ËµØÖ·Îª»ùµØÖ·
         mov [es:esi+0x1e],eax              ;µÇ¼Ç0ÌØÈ¨¼¶¶ÑÕ»»ùµØÖ·µ½TCB 
         mov ebx,0xffffe                    ;¶Î³¤¶È£¨½çÏÞ£©
         mov ecx,0x00c09600                 ;4KBÁ£¶È£¬¶ÁÐ´£¬ÌØÈ¨¼¶0
         call sys_routine_seg_sel:make_seg_descriptor
         mov ebx,esi                        ;TCBµÄ»ùµØÖ·
         call fill_descriptor_in_ldt
         ;or cx,0000_0000_0000_0000          ;ÉèÖÃÑ¡Ôñ×ÓµÄÌØÈ¨¼¶Îª0
         mov [es:esi+0x22],cx               ;µÇ¼Ç0ÌØÈ¨¼¶¶ÑÕ»Ñ¡Ôñ×Óµ½TCB
         mov dword [es:esi+0x24],0          ;µÇ¼Ç0ÌØÈ¨¼¶¶ÑÕ»³õÊ¼ESPµ½TCB
      
         ;´´½¨1ÌØÈ¨¼¶¶ÑÕ»
         mov ecx,4096
         mov eax,ecx                        ;ÎªÉú³É¶ÑÕ»¸ß¶ËµØÖ·×ö×¼±¸
         mov [es:esi+0x28],ecx
         shr [es:esi+0x28],12               ;µÇ¼Ç1ÌØÈ¨¼¶¶ÑÕ»³ß´çµ½TCB
         call sys_routine_seg_sel:allocate_memory
         add eax,ecx                        ;¶ÑÕ»±ØÐëÊ¹ÓÃ¸ß¶ËµØÖ·Îª»ùµØÖ·
         mov [es:esi+0x2c],eax              ;µÇ¼Ç1ÌØÈ¨¼¶¶ÑÕ»»ùµØÖ·µ½TCB
         mov ebx,0xffffe                    ;¶Î³¤¶È£¨½çÏÞ£©
         mov ecx,0x00c0b600                 ;4KBÁ£¶È£¬¶ÁÐ´£¬ÌØÈ¨¼¶1
         call sys_routine_seg_sel:make_seg_descriptor
         mov ebx,esi                        ;TCBµÄ»ùµØÖ·
         call fill_descriptor_in_ldt
         or cx,0000_0000_0000_0001          ;ÉèÖÃÑ¡Ôñ×ÓµÄÌØÈ¨¼¶Îª1
         mov [es:esi+0x30],cx               ;µÇ¼Ç1ÌØÈ¨¼¶¶ÑÕ»Ñ¡Ôñ×Óµ½TCB
         mov dword [es:esi+0x32],0          ;µÇ¼Ç1ÌØÈ¨¼¶¶ÑÕ»³õÊ¼ESPµ½TCB

         ;´´½¨2ÌØÈ¨¼¶¶ÑÕ»
         mov ecx,4096
         mov eax,ecx                        ;ÎªÉú³É¶ÑÕ»¸ß¶ËµØÖ·×ö×¼±¸
         mov [es:esi+0x36],ecx
         shr [es:esi+0x36],12               ;µÇ¼Ç2ÌØÈ¨¼¶¶ÑÕ»³ß´çµ½TCB
         call sys_routine_seg_sel:allocate_memory
         add eax,ecx                        ;¶ÑÕ»±ØÐëÊ¹ÓÃ¸ß¶ËµØÖ·Îª»ùµØÖ·
         mov [es:esi+0x3a],ecx              ;µÇ¼Ç2ÌØÈ¨¼¶¶ÑÕ»»ùµØÖ·µ½TCB
         mov ebx,0xffffe                    ;¶Î³¤¶È£¨½çÏÞ£©
         mov ecx,0x00c0d600                 ;4KBÁ£¶È£¬¶ÁÐ´£¬ÌØÈ¨¼¶2
         call sys_routine_seg_sel:make_seg_descriptor
         mov ebx,esi                        ;TCBµÄ»ùµØÖ·
         call fill_descriptor_in_ldt
         or cx,0000_0000_0000_0010          ;ÉèÖÃÑ¡Ôñ×ÓµÄÌØÈ¨¼¶Îª2
         mov [es:esi+0x3e],cx               ;µÇ¼Ç2ÌØÈ¨¼¶¶ÑÕ»Ñ¡Ôñ×Óµ½TCB
         mov dword [es:esi+0x40],0          ;µÇ¼Ç2ÌØÈ¨¼¶¶ÑÕ»³õÊ¼ESPµ½TCB
      
         ;ÔÚGDTÖÐµÇ¼ÇLDTÃèÊö·û
         mov eax,[es:esi+0x0c]              ;LDTµÄÆðÊ¼ÏßÐÔµØÖ·
         movzx ebx,word [es:esi+0x0a]       ;LDT¶Î½çÏÞ
         mov ecx,0x00408200                 ;LDTÃèÊö·û£¬ÌØÈ¨¼¶0
         call sys_routine_seg_sel:make_seg_descriptor
         call sys_routine_seg_sel:set_up_gdt_descriptor
         mov [es:esi+0x10],cx               ;µÇ¼ÇLDTÑ¡Ôñ×Óµ½TCBÖÐ
       
         ;´´½¨ÓÃ»§³ÌÐòµÄTSS
         mov ecx,104                        ;tssµÄ»ù±¾³ß´ç
         mov [es:esi+0x12],cx              
         dec word [es:esi+0x12]             ;µÇ¼ÇTSS½çÏÞÖµµ½TCB 
         call sys_routine_seg_sel:allocate_memory
         mov [es:esi+0x14],ecx              ;µÇ¼ÇTSS»ùµØÖ·µ½TCB
      
         ;µÇ¼Ç»ù±¾µÄTSS±í¸ñÄÚÈÝ
         mov word [es:ecx+0],0              ;·´ÏòÁ´=0
      
         mov edx,[es:esi+0x24]              ;µÇ¼Ç0ÌØÈ¨¼¶¶ÑÕ»³õÊ¼ESP
         mov [es:ecx+4],edx                 ;µ½TSSÖÐ
      
         mov dx,[es:esi+0x22]               ;µÇ¼Ç0ÌØÈ¨¼¶¶ÑÕ»¶ÎÑ¡Ôñ×Ó
         mov [es:ecx+8],dx                  ;µ½TSSÖÐ
      
         mov edx,[es:esi+0x32]              ;µÇ¼Ç1ÌØÈ¨¼¶¶ÑÕ»³õÊ¼ESP
         mov [es:ecx+12],edx                ;µ½TSSÖÐ

         mov dx,[es:esi+0x30]               ;µÇ¼Ç1ÌØÈ¨¼¶¶ÑÕ»¶ÎÑ¡Ôñ×Ó
         mov [es:ecx+16],dx                 ;µ½TSSÖÐ

         mov edx,[es:esi+0x40]              ;µÇ¼Ç2ÌØÈ¨¼¶¶ÑÕ»³õÊ¼ESP
         mov [es:ecx+20],edx                ;µ½TSSÖÐ

         mov dx,[es:esi+0x3e]               ;µÇ¼Ç2ÌØÈ¨¼¶¶ÑÕ»¶ÎÑ¡Ôñ×Ó
         mov [es:ecx+24],dx                 ;µ½TSSÖÐ

         mov dx,[es:esi+0x10]               ;µÇ¼ÇÈÎÎñµÄLDTÑ¡Ôñ×Ó
         mov [es:ecx+96],dx                 ;µ½TSSÖÐ
      
         mov dx,[es:esi+0x12]               ;µÇ¼ÇÈÎÎñµÄI/OÎ»Í¼Æ«ÒÆ
         mov [es:ecx+102],dx                ;µ½TSSÖÐ 
      
         mov word [es:ecx+100],0            ;T=0
      
         mov dword [es:ecx+28],0            ;µÇ¼ÇCR3(PDBR)
      
         ;·ÃÎÊÓÃ»§³ÌÐòÍ·²¿£¬»ñÈ¡Êý¾ÝÌî³äTSS 
         mov ebx,[ebp+11*4]                 ;´Ó¶ÑÕ»ÖÐÈ¡µÃTCBµÄ»ùµØÖ·
         mov edi,[es:ebx+0x06]              ;ÓÃ»§³ÌÐò¼ÓÔØµÄ»ùµØÖ· 

         mov edx,[es:edi+0x10]              ;µÇ¼Ç³ÌÐòÈë¿Úµã£¨EIP£© 
         mov [es:ecx+32],edx                ;µ½TSS

         mov dx,[es:edi+0x14]               ;µÇ¼Ç³ÌÐò´úÂë¶Î£¨CS£©Ñ¡Ôñ×Ó
         mov [es:ecx+76],dx                 ;µ½TSSÖÐ

         mov dx,[es:edi+0x08]               ;µÇ¼Ç³ÌÐò¶ÑÕ»¶Î£¨SS£©Ñ¡Ôñ×Ó
         mov [es:ecx+80],dx                 ;µ½TSSÖÐ

         mov dx,[es:edi+0x04]               ;µÇ¼Ç³ÌÐòÊý¾Ý¶Î£¨DS£©Ñ¡Ôñ×Ó
         mov word [es:ecx+84],dx            ;µ½TSSÖÐ¡£×¢Òâ£¬ËüÖ¸Ïò³ÌÐòÍ·²¿¶Î
      
         mov word [es:ecx+72],0             ;TSSÖÐµÄES=0

         mov word [es:ecx+88],0             ;TSSÖÐµÄFS=0

         mov word [es:ecx+92],0             ;TSSÖÐµÄGS=0

         pushfd
         pop edx
         
         mov dword [es:ecx+36],edx          ;EFLAGS

         ;ÔÚGDTÖÐµÇ¼ÇTSSÃèÊö·û
         mov eax,[es:esi+0x14]              ;TSSµÄÆðÊ¼ÏßÐÔµØÖ·
         movzx ebx,word [es:esi+0x12]       ;¶Î³¤¶È£¨½çÏÞ£©
         mov ecx,0x00408900                 ;TSSÃèÊö·û£¬ÌØÈ¨¼¶0
         call sys_routine_seg_sel:make_seg_descriptor
         call sys_routine_seg_sel:set_up_gdt_descriptor
         mov [es:esi+0x18],cx               ;µÇ¼ÇTSSÑ¡Ôñ×Óµ½TCB

         pop es                             ;»Ö¸´µ½µ÷ÓÃ´Ë¹ý³ÌÇ°µÄes¶Î 
         pop ds                             ;»Ö¸´µ½µ÷ÓÃ´Ë¹ý³ÌÇ°µÄds¶Î
      
         popad
      
         ret 8                              ;¶ªÆúµ÷ÓÃ±¾¹ý³ÌÇ°Ñ¹ÈëµÄ²ÎÊý 
      
;-------------------------------------------------------------------------------
append_to_tcb_link:                         ;ÔÚTCBÁ´ÉÏ×·¼ÓÈÎÎñ¿ØÖÆ¿é
                                            ;ÊäÈë£ºECX=TCBÏßÐÔ»ùµØÖ·
         push eax
         push edx
         push ds
         push es
         
         mov eax,core_data_seg_sel          ;ÁîDSÖ¸ÏòÄÚºËÊý¾Ý¶Î 
         mov ds,eax
         mov eax,mem_0_4_gb_seg_sel         ;ÁîESÖ¸Ïò0..4GB¶Î
         mov es,eax
         
         mov dword [es: ecx+0x00],0         ;µ±Ç°TCBÖ¸ÕëÓòÇåÁã£¬ÒÔÖ¸Ê¾ÕâÊÇ×î
                                            ;ºóÒ»¸öTCB
                                             
         mov eax,[tcb_chain]                ;TCB±íÍ·Ö¸Õë
         or eax,eax                         ;Á´±íÎª¿Õ£¿
         jz .notcb 
         
  .searc:
         mov edx,eax
         mov eax,[es: edx+0x00]
         or eax,eax               
         jnz .searc
         
         mov [es: edx+0x00],ecx
         jmp .retpc
         
  .notcb:       
         mov [tcb_chain],ecx                ;ÈôÎª¿Õ±í£¬Ö±½ÓÁî±íÍ·Ö¸ÕëÖ¸ÏòTCB
         
  .retpc:
         pop es
         pop ds
         pop edx
         pop eax
         
         ret
         
;-------------------------------------------------------------------------------
start:
         mov ecx,core_data_seg_sel          ;ÁîDSÖ¸ÏòºËÐÄÊý¾Ý¶Î 
         mov ds,ecx

         mov ecx,mem_0_4_gb_seg_sel         ;ÁîESÖ¸Ïò4GBÊý¾Ý¶Î 
         mov es,ecx

         mov ebx,message_1                    
         call sys_routine_seg_sel:put_string
                                         
         ;ÏÔÊ¾´¦ÀíÆ÷Æ·ÅÆÐÅÏ¢ 
         mov eax,0x80000002
         cpuid
         mov [cpu_brand + 0x00],eax
         mov [cpu_brand + 0x04],ebx
         mov [cpu_brand + 0x08],ecx
         mov [cpu_brand + 0x0c],edx
      
         mov eax,0x80000003
         cpuid
         mov [cpu_brand + 0x10],eax
         mov [cpu_brand + 0x14],ebx
         mov [cpu_brand + 0x18],ecx
         mov [cpu_brand + 0x1c],edx

         mov eax,0x80000004
         cpuid
         mov [cpu_brand + 0x20],eax
         mov [cpu_brand + 0x24],ebx
         mov [cpu_brand + 0x28],ecx
         mov [cpu_brand + 0x2c],edx

         mov ebx,cpu_brnd0                  ;ÏÔÊ¾´¦ÀíÆ÷Æ·ÅÆÐÅÏ¢ 
         call sys_routine_seg_sel:put_string
         mov ebx,cpu_brand
         call sys_routine_seg_sel:put_string
         mov ebx,cpu_brnd1
         call sys_routine_seg_sel:put_string

         ;ÒÔÏÂ¿ªÊ¼°²×°ÎªÕû¸öÏµÍ³·þÎñµÄµ÷ÓÃÃÅ¡£ÌØÈ¨¼¶Ö®¼äµÄ¿ØÖÆ×ªÒÆ±ØÐëÊ¹ÓÃÃÅ
         mov edi,salt                       ;C-SALT±íµÄÆðÊ¼Î»ÖÃ 
         mov ecx,salt_items                 ;C-SALT±íµÄÌõÄ¿ÊýÁ¿ 
  .b3:
         push ecx   
         mov eax,[edi+256]                  ;¸ÃÌõÄ¿Èë¿ÚµãµÄ32Î»Æ«ÒÆµØÖ· 
         mov bx,[edi+260]                   ;¸ÃÌõÄ¿Èë¿ÚµãµÄ¶ÎÑ¡Ôñ×Ó 
         mov cx,1_11_0_1100_000_00000B      ;ÌØÈ¨¼¶3µÄµ÷ÓÃÃÅ(3ÒÔÉÏµÄÌØÈ¨¼¶²Å
                                            ;ÔÊÐí·ÃÎÊ)£¬0¸ö²ÎÊý(ÒòÎªÓÃ¼Ä´æÆ÷
                                            ;´«µÝ²ÎÊý£¬¶øÃ»ÓÐÓÃÕ») 
         call sys_routine_seg_sel:make_gate_descriptor
         call sys_routine_seg_sel:set_up_gdt_descriptor
         mov [edi+260],cx                   ;½«·µ»ØµÄÃÅÃèÊö·ûÑ¡Ôñ×Ó»ØÌî
         add edi,salt_item_len              ;Ö¸ÏòÏÂÒ»¸öC-SALTÌõÄ¿ 
         pop ecx
         loop .b3

         ;¶ÔÃÅ½øÐÐ²âÊÔ 
         mov ebx,message_2
         call far [salt_1+256]              ;Í¨¹ýÃÅÏÔÊ¾ÐÅÏ¢(Æ«ÒÆÁ¿½«±»ºöÂÔ) 
      
         ;Îª³ÌÐò¹ÜÀíÆ÷µÄTSS·ÖÅäÄÚ´æ¿Õ¼ä 
         mov ecx,104                        ;Îª¸ÃÈÎÎñµÄTSS·ÖÅäÄÚ´æ
         call sys_routine_seg_sel:allocate_memory
         mov [prgman_tss+0x00],ecx          ;±£´æ³ÌÐò¹ÜÀíÆ÷µÄTSS»ùµØÖ· 
      
         ;ÔÚ³ÌÐò¹ÜÀíÆ÷µÄTSSÖÐÉèÖÃ±ØÒªµÄÏîÄ¿ 
         mov word [es:ecx+96],0             ;Ã»ÓÐLDT¡£´¦ÀíÆ÷ÔÊÐíÃ»ÓÐLDTµÄÈÎÎñ¡£
         mov word [es:ecx+102],103          ;Ã»ÓÐI/OÎ»Í¼¡£0ÌØÈ¨¼¶ÊÂÊµÉÏ²»ÐèÒª¡£
         mov word [es:ecx+0],0              ;·´ÏòÁ´=0
         mov dword [es:ecx+28],0            ;µÇ¼ÇCR3(PDBR)
         mov word [es:ecx+100],0            ;T=0
                                            ;²»ÐèÒª0¡¢1¡¢2ÌØÈ¨¼¶¶ÑÕ»¡£0ÌØ¼¶²»
                                            ;»áÏòµÍÌØÈ¨¼¶×ªÒÆ¿ØÖÆ¡£
         
         ;´´½¨TSSÃèÊö·û£¬²¢°²×°µ½GDTÖÐ 
         mov eax,ecx                        ;TSSµÄÆðÊ¼ÏßÐÔµØÖ·
         mov ebx,103                        ;¶Î³¤¶È£¨½çÏÞ£©
         mov ecx,0x00408900                 ;TSSÃèÊö·û£¬ÌØÈ¨¼¶0
         call sys_routine_seg_sel:make_seg_descriptor
         call sys_routine_seg_sel:set_up_gdt_descriptor
         mov [prgman_tss+0x04],cx           ;±£´æ³ÌÐò¹ÜÀíÆ÷µÄTSSÃèÊö·ûÑ¡Ôñ×Ó 

         ;ÈÎÎñ¼Ä´æÆ÷TRÖÐµÄÄÚÈÝÊÇÈÎÎñ´æÔÚµÄ±êÖ¾£¬¸ÃÄÚÈÝÒ²¾ö¶¨ÁËµ±Ç°ÈÎÎñÊÇË­¡£
         ;ÏÂÃæµÄÖ¸ÁîÎªµ±Ç°ÕýÔÚÖ´ÐÐµÄ0ÌØÈ¨¼¶ÈÎÎñ¡°³ÌÐò¹ÜÀíÆ÷¡±ºó²¹ÊÖÐø£¨TSS£©¡£
         ltr cx                              

         ;ÏÖÔÚ¿ÉÈÏÎª¡°³ÌÐò¹ÜÀíÆ÷¡±ÈÎÎñÕýÖ´ÐÐÖÐ
         mov ebx,prgman_msg1
         call sys_routine_seg_sel:put_string

         mov ecx,0x46
         call sys_routine_seg_sel:allocate_memory
         call append_to_tcb_link            ;½«´ËTCBÌí¼Óµ½TCBÁ´ÖÐ 
      
         push dword 50                      ;ÓÃ»§³ÌÐòÎ»ÓÚÂß¼­50ÉÈÇø
         push ecx                           ;Ñ¹ÈëÈÎÎñ¿ØÖÆ¿éÆðÊ¼ÏßÐÔµØÖ· 
       
         call load_relocate_program         
      
         call far [es:ecx+0x14]             ;Ö´ÐÐÈÎÎñÇÐ»»¡£ºÍÉÏÒ»ÕÂ²»Í¬£¬ÈÎÎñÇÐ
                                            ;»»Ê±Òª»Ö¸´TSSÄÚÈÝ£¬ËùÒÔÔÚ´´½¨ÈÎÎñ
                                            ;Ê±TSSÒªÌîÐ´ÍêÕû 
                                          
         ;ÖØÐÂ¼ÓÔØ²¢ÇÐ»»ÈÎÎñ 
         mov ebx,prgman_msg2
         call sys_routine_seg_sel:put_string

         mov ecx,0x46
         call sys_routine_seg_sel:allocate_memory
         call append_to_tcb_link            ;½«´ËTCBÌí¼Óµ½TCBÁ´ÖÐ

         push dword 50                      ;ÓÃ»§³ÌÐòÎ»ÓÚÂß¼­50ÉÈÇø
         push ecx                           ;Ñ¹ÈëÈÎÎñ¿ØÖÆ¿éÆðÊ¼ÏßÐÔµØÖ·

         call load_relocate_program

         jmp far [es:ecx+0x14]              ;Ö´ÐÐÈÎÎñÇÐ»»

         mov ebx,prgman_msg3
         call sys_routine_seg_sel:put_string

         hlt
            
core_code_end:

;-------------------------------------------------------------------------------
SECTION core_trail
;-------------------------------------------------------------------------------
core_end: