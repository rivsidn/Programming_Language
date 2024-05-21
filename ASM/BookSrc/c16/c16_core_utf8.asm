         ;´úÂëÇåµ¥16-1
         ;ÎÄ¼þÃû£ºc16_core.asm
         ;ÎÄ¼þËµÃ÷£º±£»¤Ä£Ê½Î¢ÐÍºËÐÄ³ÌÐò 
         ;´´½¨ÈÕÆÚ£º2012-06-20 00:05

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
         mov eax,video_ram_seg_sel          ;0x800b8000¶ÎµÄÑ¡Ôñ×Ó
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
allocate_a_4k_page:                         ;·ÖÅäÒ»¸ö4KBµÄÒ³
                                            ;ÊäÈë£ºÎÞ
                                            ;Êä³ö£ºEAX=Ò³µÄÎïÀíµØÖ·
         push ebx
         push ecx
         push edx
         push ds
         
         mov eax,core_data_seg_sel
         mov ds,eax
         
         xor eax,eax
  .b1:
         bts [page_bit_map],eax
         jnc .b2
         inc eax
         cmp eax,page_map_len*8
         jl .b1
         
         mov ebx,message_3
         call sys_routine_seg_sel:put_string
         hlt                                ;Ã»ÓÐ¿ÉÒÔ·ÖÅäµÄÒ³£¬Í£»ú 
         
  .b2:
         shl eax,12                         ;³ËÒÔ4096£¨0x1000£© 
         
         pop ds
         pop edx
         pop ecx
         pop ebx
         
         ret
         
;-------------------------------------------------------------------------------
alloc_inst_a_page:                          ;·ÖÅäÒ»¸öÒ³£¬²¢°²×°ÔÚµ±Ç°»î¶¯µÄ
                                            ;²ã¼¶·ÖÒ³½á¹¹ÖÐ
                                            ;ÊäÈë£ºEBX=Ò³µÄÏßÐÔµØÖ·
         push eax
         push ebx
         push esi
         push ds
         
         mov eax,mem_0_4_gb_seg_sel
         mov ds,eax
         
         ;¼ì²é¸ÃÏßÐÔµØÖ·Ëù¶ÔÓ¦µÄÒ³±íÊÇ·ñ´æÔÚ
         mov esi,ebx
         and esi,0xffc00000
         shr esi,20                         ;µÃµ½Ò³Ä¿Â¼Ë÷Òý£¬²¢³ËÒÔ4 
         or esi,0xfffff000                  ;Ò³Ä¿Â¼×ÔÉíµÄÏßÐÔµØÖ·+±íÄÚÆ«ÒÆ 

         test dword [esi],0x00000001        ;PÎ»ÊÇ·ñÎª¡°1¡±¡£¼ì²é¸ÃÏßÐÔµØÖ·ÊÇ 
         jnz .b1                            ;·ñÒÑ¾­ÓÐ¶ÔÓ¦µÄÒ³±í
          
         ;´´½¨¸ÃÏßÐÔµØÖ·Ëù¶ÔÓ¦µÄÒ³±í 
         call allocate_a_4k_page            ;·ÖÅäÒ»¸öÒ³×öÎªÒ³±í 
         or eax,0x00000007
         mov [esi],eax                      ;ÔÚÒ³Ä¿Â¼ÖÐµÇ¼Ç¸ÃÒ³±í
          
  .b1:
         ;¿ªÊ¼·ÃÎÊ¸ÃÏßÐÔµØÖ·Ëù¶ÔÓ¦µÄÒ³±í 
         mov esi,ebx
         shr esi,10
         and esi,0x003ff000                 ;»òÕß0xfffff000£¬Òò¸ß10Î»ÊÇÁã 
         or esi,0xffc00000                  ;µÃµ½¸ÃÒ³±íµÄÏßÐÔµØÖ·
         
         ;µÃµ½¸ÃÏßÐÔµØÖ·ÔÚÒ³±íÄÚµÄ¶ÔÓ¦ÌõÄ¿£¨Ò³±íÏî£© 
         and ebx,0x003ff000
         shr ebx,10                         ;Ïàµ±ÓÚÓÒÒÆ12Î»£¬ÔÙ³ËÒÔ4
         or esi,ebx                         ;Ò³±íÏîµÄÏßÐÔµØÖ· 
         call allocate_a_4k_page            ;·ÖÅäÒ»¸öÒ³£¬Õâ²ÅÊÇÒª°²×°µÄÒ³
         or eax,0x00000007
         mov [esi],eax 
          
         pop ds
         pop esi
         pop ebx
         pop eax
         
         retf  

;-------------------------------------------------------------------------------
create_copy_cur_pdir:                       ;´´½¨ÐÂÒ³Ä¿Â¼£¬²¢¸´ÖÆµ±Ç°Ò³Ä¿Â¼ÄÚÈÝ
                                            ;ÊäÈë£ºÎÞ
                                            ;Êä³ö£ºEAX=ÐÂÒ³Ä¿Â¼µÄÎïÀíµØÖ· 
         push ds
         push es
         push esi
         push edi
         push ebx
         push ecx
         
         mov ebx,mem_0_4_gb_seg_sel
         mov ds,ebx
         mov es,ebx
         
         call allocate_a_4k_page            
         mov ebx,eax
         or ebx,0x00000007
         mov [0xfffffff8],ebx
         
         mov esi,0xfffff000                 ;ESI->µ±Ç°Ò³Ä¿Â¼µÄÏßÐÔµØÖ·
         mov edi,0xffffe000                 ;EDI->ÐÂÒ³Ä¿Â¼µÄÏßÐÔµØÖ·
         mov ecx,1024                       ;ECX=Òª¸´ÖÆµÄÄ¿Â¼ÏîÊý
         cld
         repe movsd 
         
         pop ecx
         pop ebx
         pop edi
         pop esi
         pop es
         pop ds
         
         retf
         
;-------------------------------------------------------------------------------
terminate_current_task:                     ;ÖÕÖ¹µ±Ç°ÈÎÎñ
                                            ;×¢Òâ£¬Ö´ÐÐ´ËÀý³ÌÊ±£¬µ±Ç°ÈÎÎñÈÔÔÚ
                                            ;ÔËÐÐÖÐ¡£´ËÀý³ÌÆäÊµÒ²ÊÇµ±Ç°ÈÎÎñµÄ
                                            ;Ò»²¿·Ö 
         mov eax,core_data_seg_sel
         mov ds,eax

         pushfd
         pop edx
 
         test dx,0100_0000_0000_0000B       ;²âÊÔNTÎ»
         jnz .b1                            ;µ±Ç°ÈÎÎñÊÇÇ¶Ì×µÄ£¬µ½.b1Ö´ÐÐiretd 
         jmp far [program_man_tss]          ;³ÌÐò¹ÜÀíÆ÷ÈÎÎñ 
  .b1: 
         iretd

sys_routine_end:

;===============================================================================
SECTION core_data vstart=0                  ;ÏµÍ³ºËÐÄµÄÊý¾Ý¶Î 
;------------------------------------------------------------------------------- 
         pgdt             dw  0             ;ÓÃÓÚÉèÖÃºÍÐÞ¸ÄGDT 
                          dd  0

         page_bit_map     db  0xff,0xff,0xff,0xff,0xff,0x55,0x55,0xff
                          db  0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff
                          db  0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff
                          db  0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff
                          db  0x55,0x55,0x55,0x55,0x55,0x55,0x55,0x55
                          db  0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00
                          db  0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00
                          db  0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00
         page_map_len     equ $-page_bit_map
                          
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

         message_0        db  '  Working in system core,protect mode.'
                          db  0x0d,0x0a,0

         message_1        db  '  Paging is enabled.System core is mapped to'
                          db  ' address 0x80000000.',0x0d,0x0a,0
         
         message_2        db  0x0d,0x0a
                          db  '  System wide CALL-GATE mounted.',0x0d,0x0a,0
         
         message_3        db  '********No more pages********',0
         
         message_4        db  0x0d,0x0a,'  Task switching...@_@',0x0d,0x0a,0
         
         message_5        db  0x0d,0x0a,'  Processor HALT.',0
         
        
         bin_hex          db '0123456789ABCDEF'
                                            ;put_hex_dword×Ó¹ý³ÌÓÃµÄ²éÕÒ±í 

         core_buf   times 512 db 0          ;ÄÚºËÓÃµÄ»º³åÇø

         cpu_brnd0        db 0x0d,0x0a,'  ',0
         cpu_brand  times 52 db 0
         cpu_brnd1        db 0x0d,0x0a,0x0d,0x0a,0

         ;ÈÎÎñ¿ØÖÆ¿éÁ´
         tcb_chain        dd  0

         ;ÄÚºËÐÅÏ¢
         core_next_laddr  dd  0x80100000    ;ÄÚºË¿Õ¼äÖÐÏÂÒ»¸ö¿É·ÖÅäµÄÏßÐÔµØÖ·        
         program_man_tss  dd  0             ;³ÌÐò¹ÜÀíÆ÷µÄTSSÃèÊö·ûÑ¡Ôñ×Ó 
                          dw  0

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
      
         ;Çå¿Õµ±Ç°Ò³Ä¿Â¼µÄÇ°°ë²¿·Ö£¨¶ÔÓ¦µÍ2GBµÄ¾Ö²¿µØÖ·¿Õ¼ä£© 
         mov ebx,0xfffff000
         xor esi,esi
  .b1:
         mov dword [es:ebx+esi*4],0x00000000
         inc esi
         cmp esi,512
         jl .b1
         
         ;ÒÔÏÂ¿ªÊ¼·ÖÅäÄÚ´æ²¢¼ÓÔØÓÃ»§³ÌÐò
         mov eax,core_data_seg_sel
         mov ds,eax                         ;ÇÐ»»DSµ½ÄÚºËÊý¾Ý¶Î

         mov eax,[ebp+12*4]                 ;´Ó¶ÑÕ»ÖÐÈ¡³öÓÃ»§³ÌÐòÆðÊ¼ÉÈÇøºÅ
         mov ebx,core_buf                   ;¶ÁÈ¡³ÌÐòÍ·²¿Êý¾Ý
         call sys_routine_seg_sel:read_hard_disk_0

         ;ÒÔÏÂÅÐ¶ÏÕû¸ö³ÌÐòÓÐ¶à´ó
         mov eax,[core_buf]                 ;³ÌÐò³ß´ç
         mov ebx,eax
         and ebx,0xfffff000                 ;Ê¹Ö®4KB¶ÔÆë 
         add ebx,0x1000                        
         test eax,0x00000fff                ;³ÌÐòµÄ´óÐ¡ÕýºÃÊÇ4KBµÄ±¶ÊýÂð? 
         cmovnz eax,ebx                     ;²»ÊÇ¡£Ê¹ÓÃ´ÕÕûµÄ½á¹û

         mov ecx,eax
         shr ecx,12                         ;³ÌÐòÕ¼ÓÃµÄ×Ü4KBÒ³Êý 
         
         mov eax,mem_0_4_gb_seg_sel         ;ÇÐ»»DSµ½0-4GBµÄ¶Î
         mov ds,eax

         mov eax,[ebp+12*4]                 ;ÆðÊ¼ÉÈÇøºÅ
         mov esi,[ebp+11*4]                 ;´Ó¶ÑÕ»ÖÐÈ¡µÃTCBµÄ»ùµØÖ·
  .b2:
         mov ebx,[es:esi+0x06]              ;È¡µÃ¿ÉÓÃµÄÏßÐÔµØÖ·
         add dword [es:esi+0x06],0x1000
         call sys_routine_seg_sel:alloc_inst_a_page

         push ecx
         mov ecx,8
  .b3:
         call sys_routine_seg_sel:read_hard_disk_0
         inc eax
         loop .b3

         pop ecx
         loop .b2

         ;ÔÚÄÚºËµØÖ·¿Õ¼äÄÚ´´½¨ÓÃ»§ÈÎÎñµÄTSS
         mov eax,core_data_seg_sel          ;ÇÐ»»DSµ½ÄÚºËÊý¾Ý¶Î
         mov ds,eax

         mov ebx,[core_next_laddr]          ;ÓÃ»§ÈÎÎñµÄTSS±ØÐëÔÚÈ«¾Ö¿Õ¼äÉÏ·ÖÅä 
         call sys_routine_seg_sel:alloc_inst_a_page
         add dword [core_next_laddr],4096
         
         mov [es:esi+0x14],ebx              ;ÔÚTCBÖÐÌîÐ´TSSµÄÏßÐÔµØÖ· 
         mov word [es:esi+0x12],103         ;ÔÚTCBÖÐÌîÐ´TSSµÄ½çÏÞÖµ 
          
         ;ÔÚÓÃ»§ÈÎÎñµÄ¾Ö²¿µØÖ·¿Õ¼äÄÚ´´½¨LDT 
         mov ebx,[es:esi+0x06]              ;´ÓTCBÖÐÈ¡µÃ¿ÉÓÃµÄÏßÐÔµØÖ·
         add dword [es:esi+0x06],0x1000
         call sys_routine_seg_sel:alloc_inst_a_page
         mov [es:esi+0x0c],ebx              ;ÌîÐ´LDTÏßÐÔµØÖ·µ½TCBÖÐ 

         ;½¨Á¢³ÌÐò´úÂë¶ÎÃèÊö·û
         mov eax,0x00000000
         mov ebx,0x000fffff                 
         mov ecx,0x00c0f800                 ;4KBÁ£¶ÈµÄ´úÂë¶ÎÃèÊö·û£¬ÌØÈ¨¼¶3
         call sys_routine_seg_sel:make_seg_descriptor
         mov ebx,esi                        ;TCBµÄ»ùµØÖ·
         call fill_descriptor_in_ldt
         or cx,0000_0000_0000_0011B         ;ÉèÖÃÑ¡Ôñ×ÓµÄÌØÈ¨¼¶Îª3
         
         mov ebx,[es:esi+0x14]              ;´ÓTCBÖÐ»ñÈ¡TSSµÄÏßÐÔµØÖ·
         mov [es:ebx+76],cx                 ;ÌîÐ´TSSµÄCSÓò 

         ;½¨Á¢³ÌÐòÊý¾Ý¶ÎÃèÊö·û
         mov eax,0x00000000
         mov ebx,0x000fffff                 
         mov ecx,0x00c0f200                 ;4KBÁ£¶ÈµÄÊý¾Ý¶ÎÃèÊö·û£¬ÌØÈ¨¼¶3
         call sys_routine_seg_sel:make_seg_descriptor
         mov ebx,esi                        ;TCBµÄ»ùµØÖ·
         call fill_descriptor_in_ldt
         or cx,0000_0000_0000_0011B         ;ÉèÖÃÑ¡Ôñ×ÓµÄÌØÈ¨¼¶Îª3
         
         mov ebx,[es:esi+0x14]              ;´ÓTCBÖÐ»ñÈ¡TSSµÄÏßÐÔµØÖ·
         mov [es:ebx+84],cx                 ;ÌîÐ´TSSµÄDSÓò 
         mov [es:ebx+72],cx                 ;ÌîÐ´TSSµÄESÓò
         mov [es:ebx+88],cx                 ;ÌîÐ´TSSµÄFSÓò
         mov [es:ebx+92],cx                 ;ÌîÐ´TSSµÄGSÓò
         
         ;½«Êý¾Ý¶Î×÷ÎªÓÃ»§ÈÎÎñµÄ3ÌØÈ¨¼¶¹ÌÓÐ¶ÑÕ» 
         mov ebx,[es:esi+0x06]              ;´ÓTCBÖÐÈ¡µÃ¿ÉÓÃµÄÏßÐÔµØÖ·
         add dword [es:esi+0x06],0x1000
         call sys_routine_seg_sel:alloc_inst_a_page
         
         mov ebx,[es:esi+0x14]              ;´ÓTCBÖÐ»ñÈ¡TSSµÄÏßÐÔµØÖ·
         mov [es:ebx+80],cx                 ;ÌîÐ´TSSµÄSSÓò
         mov edx,[es:esi+0x06]              ;¶ÑÕ»µÄ¸ß¶ËÏßÐÔµØÖ· 
         mov [es:ebx+56],edx                ;ÌîÐ´TSSµÄESPÓò 

         ;ÔÚÓÃ»§ÈÎÎñµÄ¾Ö²¿µØÖ·¿Õ¼äÄÚ´´½¨0ÌØÈ¨¼¶¶ÑÕ»
         mov ebx,[es:esi+0x06]              ;´ÓTCBÖÐÈ¡µÃ¿ÉÓÃµÄÏßÐÔµØÖ·
         add dword [es:esi+0x06],0x1000
         call sys_routine_seg_sel:alloc_inst_a_page

         mov eax,0x00000000
         mov ebx,0x000fffff
         mov ecx,0x00c09200                 ;4KBÁ£¶ÈµÄ¶ÑÕ»¶ÎÃèÊö·û£¬ÌØÈ¨¼¶0
         call sys_routine_seg_sel:make_seg_descriptor
         mov ebx,esi                        ;TCBµÄ»ùµØÖ·
         call fill_descriptor_in_ldt
         or cx,0000_0000_0000_0000B         ;ÉèÖÃÑ¡Ôñ×ÓµÄÌØÈ¨¼¶Îª0

         mov ebx,[es:esi+0x14]              ;´ÓTCBÖÐ»ñÈ¡TSSµÄÏßÐÔµØÖ·
         mov [es:ebx+8],cx                  ;ÌîÐ´TSSµÄSS0Óò
         mov edx,[es:esi+0x06]              ;¶ÑÕ»µÄ¸ß¶ËÏßÐÔµØÖ·
         mov [es:ebx+4],edx                 ;ÌîÐ´TSSµÄESP0Óò 

         ;ÔÚÓÃ»§ÈÎÎñµÄ¾Ö²¿µØÖ·¿Õ¼äÄÚ´´½¨1ÌØÈ¨¼¶¶ÑÕ»
         mov ebx,[es:esi+0x06]              ;´ÓTCBÖÐÈ¡µÃ¿ÉÓÃµÄÏßÐÔµØÖ·
         add dword [es:esi+0x06],0x1000
         call sys_routine_seg_sel:alloc_inst_a_page

         mov eax,0x00000000
         mov ebx,0x000fffff
         mov ecx,0x00c0b200                 ;4KBÁ£¶ÈµÄ¶ÑÕ»¶ÎÃèÊö·û£¬ÌØÈ¨¼¶1
         call sys_routine_seg_sel:make_seg_descriptor
         mov ebx,esi                        ;TCBµÄ»ùµØÖ·
         call fill_descriptor_in_ldt
         or cx,0000_0000_0000_0001B         ;ÉèÖÃÑ¡Ôñ×ÓµÄÌØÈ¨¼¶Îª1

         mov ebx,[es:esi+0x14]              ;´ÓTCBÖÐ»ñÈ¡TSSµÄÏßÐÔµØÖ·
         mov [es:ebx+16],cx                 ;ÌîÐ´TSSµÄSS1Óò
         mov edx,[es:esi+0x06]              ;¶ÑÕ»µÄ¸ß¶ËÏßÐÔµØÖ·
         mov [es:ebx+12],edx                ;ÌîÐ´TSSµÄESP1Óò 

         ;ÔÚÓÃ»§ÈÎÎñµÄ¾Ö²¿µØÖ·¿Õ¼äÄÚ´´½¨2ÌØÈ¨¼¶¶ÑÕ»
         mov ebx,[es:esi+0x06]              ;´ÓTCBÖÐÈ¡µÃ¿ÉÓÃµÄÏßÐÔµØÖ·
         add dword [es:esi+0x06],0x1000
         call sys_routine_seg_sel:alloc_inst_a_page

         mov eax,0x00000000
         mov ebx,0x000fffff
         mov ecx,0x00c0d200                 ;4KBÁ£¶ÈµÄ¶ÑÕ»¶ÎÃèÊö·û£¬ÌØÈ¨¼¶2
         call sys_routine_seg_sel:make_seg_descriptor
         mov ebx,esi                        ;TCBµÄ»ùµØÖ·
         call fill_descriptor_in_ldt
         or cx,0000_0000_0000_0010B         ;ÉèÖÃÑ¡Ôñ×ÓµÄÌØÈ¨¼¶Îª2

         mov ebx,[es:esi+0x14]              ;´ÓTCBÖÐ»ñÈ¡TSSµÄÏßÐÔµØÖ·
         mov [es:ebx+24],cx                 ;ÌîÐ´TSSµÄSS2Óò
         mov edx,[es:esi+0x06]              ;¶ÑÕ»µÄ¸ß¶ËÏßÐÔµØÖ·
         mov [es:ebx+20],edx                ;ÌîÐ´TSSµÄESP2Óò 


         ;ÖØ¶¨Î»SALT 
         mov eax,mem_0_4_gb_seg_sel         ;·ÃÎÊÈÎÎñµÄ4GBÐéÄâµØÖ·¿Õ¼äÊ±ÓÃ 
         mov es,eax                         
                                                    
         mov eax,core_data_seg_sel
         mov ds,eax
      
         cld

         mov ecx,[es:0x0c]                  ;U-SALTÌõÄ¿Êý 
         mov edi,[es:0x08]                  ;U-SALTÔÚ4GB¿Õ¼äÄÚµÄÆ«ÒÆ 
  .b4:
         push ecx
         push edi
      
         mov ecx,salt_items
         mov esi,salt
  .b5:
         push edi
         push esi
         push ecx

         mov ecx,64                         ;¼ìË÷±íÖÐ£¬Ã¿ÌõÄ¿µÄ±È½Ï´ÎÊý 
         repe cmpsd                         ;Ã¿´Î±È½Ï4×Ö½Ú 
         jnz .b6
         mov eax,[esi]                      ;ÈôÆ¥Åä£¬ÔòesiÇ¡ºÃÖ¸ÏòÆäºóµÄµØÖ·
         mov [es:edi-256],eax               ;½«×Ö·û´®¸ÄÐ´³ÉÆ«ÒÆµØÖ· 
         mov ax,[esi+4]
         or ax,0000000000000011B            ;ÒÔÓÃ»§³ÌÐò×Ô¼ºµÄÌØÈ¨¼¶Ê¹ÓÃµ÷ÓÃÃÅ
                                            ;¹ÊRPL=3 
         mov [es:edi-252],ax                ;»ØÌîµ÷ÓÃÃÅÑ¡Ôñ×Ó 
  .b6:
      
         pop ecx
         pop esi
         add esi,salt_item_len
         pop edi                            ;´ÓÍ·±È½Ï 
         loop .b5
      
         pop edi
         add edi,256
         pop ecx
         loop .b4

         ;ÔÚGDTÖÐµÇ¼ÇLDTÃèÊö·û
         mov esi,[ebp+11*4]                 ;´Ó¶ÑÕ»ÖÐÈ¡µÃTCBµÄ»ùµØÖ·
         mov eax,[es:esi+0x0c]              ;LDTµÄÆðÊ¼ÏßÐÔµØÖ·
         movzx ebx,word [es:esi+0x0a]       ;LDT¶Î½çÏÞ
         mov ecx,0x00408200                 ;LDTÃèÊö·û£¬ÌØÈ¨¼¶0
         call sys_routine_seg_sel:make_seg_descriptor
         call sys_routine_seg_sel:set_up_gdt_descriptor
         mov [es:esi+0x10],cx               ;µÇ¼ÇLDTÑ¡Ôñ×Óµ½TCBÖÐ

         mov ebx,[es:esi+0x14]              ;´ÓTCBÖÐ»ñÈ¡TSSµÄÏßÐÔµØÖ·
         mov [es:ebx+96],cx                 ;ÌîÐ´TSSµÄLDTÓò 

         mov word [es:ebx+0],0              ;·´ÏòÁ´=0
      
         mov dx,[es:esi+0x12]               ;¶Î³¤¶È£¨½çÏÞ£©
         mov [es:ebx+102],dx                ;ÌîÐ´TSSµÄI/OÎ»Í¼Æ«ÒÆÓò 
      
         mov word [es:ebx+100],0            ;T=0
      
         mov eax,[es:0x04]                  ;´ÓÈÎÎñµÄ4GBµØÖ·¿Õ¼ä»ñÈ¡Èë¿Úµã 
         mov [es:ebx+32],eax                ;ÌîÐ´TSSµÄEIPÓò 

         pushfd
         pop edx
         mov [es:ebx+36],edx                ;ÌîÐ´TSSµÄEFLAGSÓò 

         ;ÔÚGDTÖÐµÇ¼ÇTSSÃèÊö·û
         mov eax,[es:esi+0x14]              ;´ÓTCBÖÐ»ñÈ¡TSSµÄÆðÊ¼ÏßÐÔµØÖ·
         movzx ebx,word [es:esi+0x12]       ;¶Î³¤¶È£¨½çÏÞ£©
         mov ecx,0x00408900                 ;TSSÃèÊö·û£¬ÌØÈ¨¼¶0
         call sys_routine_seg_sel:make_seg_descriptor
         call sys_routine_seg_sel:set_up_gdt_descriptor
         mov [es:esi+0x18],cx               ;µÇ¼ÇTSSÑ¡Ôñ×Óµ½TCB

         ;´´½¨ÓÃ»§ÈÎÎñµÄÒ³Ä¿Â¼
         ;×¢Òâ£¡Ò³µÄ·ÖÅäºÍÊ¹ÓÃÊÇÓÉÒ³Î»Í¼¾ö¶¨µÄ£¬¿ÉÒÔ²»Õ¼ÓÃÏßÐÔµØÖ·¿Õ¼ä 
         call sys_routine_seg_sel:create_copy_cur_pdir
         mov ebx,[es:esi+0x14]              ;´ÓTCBÖÐ»ñÈ¡TSSµÄÏßÐÔµØÖ·
         mov dword [es:ebx+28],eax          ;ÌîÐ´TSSµÄCR3(PDBR)Óò
                   
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

         mov ebx,message_0                    
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

         ;×¼±¸´ò¿ª·ÖÒ³»úÖÆ
         
         ;´´½¨ÏµÍ³ÄÚºËµÄÒ³Ä¿Â¼±íPDT
         ;Ò³Ä¿Â¼±íÇåÁã 
         mov ecx,1024                       ;1024¸öÄ¿Â¼Ïî
         mov ebx,0x00020000                 ;Ò³Ä¿Â¼µÄÎïÀíµØÖ·
         xor esi,esi
  .b1:
         mov dword [es:ebx+esi],0x00000000  ;Ò³Ä¿Â¼±íÏîÇåÁã 
         add esi,4
         loop .b1
         
         ;ÔÚÒ³Ä¿Â¼ÄÚ´´½¨Ö¸ÏòÒ³Ä¿Â¼×Ô¼ºµÄÄ¿Â¼Ïî
         mov dword [es:ebx+4092],0x00020003 

         ;ÔÚÒ³Ä¿Â¼ÄÚ´´½¨ÓëÏßÐÔµØÖ·0x00000000¶ÔÓ¦µÄÄ¿Â¼Ïî
         mov dword [es:ebx+0],0x00021003    ;Ð´ÈëÄ¿Â¼Ïî£¨Ò³±íµÄÎïÀíµØÖ·ºÍÊôÐÔ£©      

         ;´´½¨ÓëÉÏÃæÄÇ¸öÄ¿Â¼ÏîÏà¶ÔÓ¦µÄÒ³±í£¬³õÊ¼»¯Ò³±íÏî 
         mov ebx,0x00021000                 ;Ò³±íµÄÎïÀíµØÖ·
         xor eax,eax                        ;ÆðÊ¼Ò³µÄÎïÀíµØÖ· 
         xor esi,esi
  .b2:       
         mov edx,eax
         or edx,0x00000003                                                      
         mov [es:ebx+esi*4],edx             ;µÇ¼ÇÒ³µÄÎïÀíµØÖ·
         add eax,0x1000                     ;ÏÂÒ»¸öÏàÁÚÒ³µÄÎïÀíµØÖ· 
         inc esi
         cmp esi,256                        ;½öµÍ¶Ë1MBÄÚ´æ¶ÔÓ¦µÄÒ³²ÅÊÇÓÐÐ§µÄ 
         jl .b2
         
  .b3:                                      ;ÆäÓàµÄÒ³±íÏîÖÃÎªÎÞÐ§
         mov dword [es:ebx+esi*4],0x00000000  
         inc esi
         cmp esi,1024
         jl .b3 

         ;ÁîCR3¼Ä´æÆ÷Ö¸ÏòÒ³Ä¿Â¼£¬²¢ÕýÊ½¿ªÆôÒ³¹¦ÄÜ 
         mov eax,0x00020000                 ;PCD=PWT=0
         mov cr3,eax

         mov eax,cr0
         or eax,0x80000000
         mov cr0,eax                        ;¿ªÆô·ÖÒ³»úÖÆ

         ;ÔÚÒ³Ä¿Â¼ÄÚ´´½¨ÓëÏßÐÔµØÖ·0x80000000¶ÔÓ¦µÄÄ¿Â¼Ïî
         mov ebx,0xfffff000                 ;Ò³Ä¿Â¼×Ô¼ºµÄÏßÐÔµØÖ· 
         mov esi,0x80000000                 ;Ó³ÉäµÄÆðÊ¼µØÖ·
         shr esi,22                         ;ÏßÐÔµØÖ·µÄ¸ß10Î»ÊÇÄ¿Â¼Ë÷Òý
         shl esi,2
         mov dword [es:ebx+esi],0x00021003  ;Ð´ÈëÄ¿Â¼Ïî£¨Ò³±íµÄÎïÀíµØÖ·ºÍÊôÐÔ£©
                                            ;Ä¿±êµ¥ÔªµÄÏßÐÔµØÖ·Îª0xFFFFF200
                                             
         ;½«GDTÖÐµÄ¶ÎÃèÊö·ûÓ³Éäµ½ÏßÐÔµØÖ·0x80000000
         sgdt [pgdt]
         
         mov ebx,[pgdt+2]
         
         or dword [es:ebx+0x10+4],0x80000000
         or dword [es:ebx+0x18+4],0x80000000
         or dword [es:ebx+0x20+4],0x80000000
         or dword [es:ebx+0x28+4],0x80000000
         or dword [es:ebx+0x30+4],0x80000000
         or dword [es:ebx+0x38+4],0x80000000
         
         add dword [pgdt+2],0x80000000      ;GDTRÒ²ÓÃµÄÊÇÏßÐÔµØÖ· 
         
         lgdt [pgdt]
        
         jmp core_code_seg_sel:flush        ;Ë¢ÐÂ¶Î¼Ä´æÆ÷CS£¬ÆôÓÃ¸ß¶ËÏßÐÔµØÖ· 
                                             
   flush:
         mov eax,core_stack_seg_sel
         mov ss,eax
         
         mov eax,core_data_seg_sel
         mov ds,eax
          
         mov ebx,message_1
         call sys_routine_seg_sel:put_string

         ;ÒÔÏÂ¿ªÊ¼°²×°ÎªÕû¸öÏµÍ³·þÎñµÄµ÷ÓÃÃÅ¡£ÌØÈ¨¼¶Ö®¼äµÄ¿ØÖÆ×ªÒÆ±ØÐëÊ¹ÓÃÃÅ
         mov edi,salt                       ;C-SALT±íµÄÆðÊ¼Î»ÖÃ 
         mov ecx,salt_items                 ;C-SALT±íµÄÌõÄ¿ÊýÁ¿ 
  .b4:
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
         loop .b4

         ;¶ÔÃÅ½øÐÐ²âÊÔ 
         mov ebx,message_2
         call far [salt_1+256]              ;Í¨¹ýÃÅÏÔÊ¾ÐÅÏ¢(Æ«ÒÆÁ¿½«±»ºöÂÔ) 
      
         ;Îª³ÌÐò¹ÜÀíÆ÷µÄTSS·ÖÅäÄÚ´æ¿Õ¼ä
         mov ebx,[core_next_laddr]
         call sys_routine_seg_sel:alloc_inst_a_page
         add dword [core_next_laddr],4096

         ;ÔÚ³ÌÐò¹ÜÀíÆ÷µÄTSSÖÐÉèÖÃ±ØÒªµÄÏîÄ¿ 
         mov word [es:ebx+0],0              ;·´ÏòÁ´=0

         mov eax,cr3
         mov dword [es:ebx+28],eax          ;µÇ¼ÇCR3(PDBR)

         mov word [es:ebx+96],0             ;Ã»ÓÐLDT¡£´¦ÀíÆ÷ÔÊÐíÃ»ÓÐLDTµÄÈÎÎñ¡£
         mov word [es:ebx+100],0            ;T=0
         mov word [es:ebx+102],103          ;Ã»ÓÐI/OÎ»Í¼¡£0ÌØÈ¨¼¶ÊÂÊµÉÏ²»ÐèÒª¡£
         
         ;´´½¨³ÌÐò¹ÜÀíÆ÷µÄTSSÃèÊö·û£¬²¢°²×°µ½GDTÖÐ 
         mov eax,ebx                        ;TSSµÄÆðÊ¼ÏßÐÔµØÖ·
         mov ebx,103                        ;¶Î³¤¶È£¨½çÏÞ£©
         mov ecx,0x00408900                 ;TSSÃèÊö·û£¬ÌØÈ¨¼¶0
         call sys_routine_seg_sel:make_seg_descriptor
         call sys_routine_seg_sel:set_up_gdt_descriptor
         mov [program_man_tss+4],cx         ;±£´æ³ÌÐò¹ÜÀíÆ÷µÄTSSÃèÊö·ûÑ¡Ôñ×Ó 

         ;ÈÎÎñ¼Ä´æÆ÷TRÖÐµÄÄÚÈÝÊÇÈÎÎñ´æÔÚµÄ±êÖ¾£¬¸ÃÄÚÈÝÒ²¾ö¶¨ÁËµ±Ç°ÈÎÎñÊÇË­¡£
         ;ÏÂÃæµÄÖ¸ÁîÎªµ±Ç°ÕýÔÚÖ´ÐÐµÄ0ÌØÈ¨¼¶ÈÎÎñ¡°³ÌÐò¹ÜÀíÆ÷¡±ºó²¹ÊÖÐø£¨TSS£©¡£
         ltr cx

         ;ÏÖÔÚ¿ÉÈÏÎª¡°³ÌÐò¹ÜÀíÆ÷¡±ÈÎÎñÕýÖ´ÐÐÖÐ

         ;´´½¨ÓÃ»§ÈÎÎñµÄÈÎÎñ¿ØÖÆ¿é 
         mov ebx,[core_next_laddr]
         call sys_routine_seg_sel:alloc_inst_a_page
         add dword [core_next_laddr],4096
         
         mov dword [es:ebx+0x06],0          ;ÓÃ»§ÈÎÎñ¾Ö²¿¿Õ¼äµÄ·ÖÅä´Ó0¿ªÊ¼¡£
         mov word [es:ebx+0x0a],0xffff      ;µÇ¼ÇLDT³õÊ¼µÄ½çÏÞµ½TCBÖÐ
         mov ecx,ebx
         call append_to_tcb_link            ;½«´ËTCBÌí¼Óµ½TCBÁ´ÖÐ 
      
         push dword 50                      ;ÓÃ»§³ÌÐòÎ»ÓÚÂß¼­50ÉÈÇø
         push ecx                           ;Ñ¹ÈëÈÎÎñ¿ØÖÆ¿éÆðÊ¼ÏßÐÔµØÖ· 
       
         call load_relocate_program         
      
         mov ebx,message_4
         call sys_routine_seg_sel:put_string
         
         call far [es:ecx+0x14]             ;Ö´ÐÐÈÎÎñÇÐ»»¡£
         
         mov ebx,message_5
         call sys_routine_seg_sel:put_string

         hlt
            
core_code_end:

;-------------------------------------------------------------------------------
SECTION core_trail
;-------------------------------------------------------------------------------
core_end: