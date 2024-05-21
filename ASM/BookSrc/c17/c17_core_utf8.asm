         ;´úÂëÇåµ¥17-2
         ;ÎÄ¼þÃû£ºc17_core.asm
         ;ÎÄ¼þËµÃ÷£º±£»¤Ä£Ê½Î¢ÐÍºËÐÄ³ÌÐò 
         ;´´½¨ÈÕÆÚ£º2012-07-12 23:15
;-------------------------------------------------------------------------------
         ;ÒÔÏÂ¶¨Òå³£Á¿
         flat_4gb_code_seg_sel  equ  0x0008      ;Æ½Ì¹Ä£ÐÍÏÂµÄ4GB´úÂë¶ÎÑ¡Ôñ×Ó 
         flat_4gb_data_seg_sel  equ  0x0018      ;Æ½Ì¹Ä£ÐÍÏÂµÄ4GBÊý¾Ý¶ÎÑ¡Ôñ×Ó 
         idt_linear_address     equ  0x8001f000  ;ÖÐ¶ÏÃèÊö·û±íµÄÏßÐÔ»ùµØÖ· 
;-------------------------------------------------------------------------------          
         ;ÒÔÏÂ¶¨Òåºê
         %macro alloc_core_linear 0              ;ÔÚÄÚºË¿Õ¼äÖÐ·ÖÅäÐéÄâÄÚ´æ 
               mov ebx,[core_tcb+0x06]
               add dword [core_tcb+0x06],0x1000
               call flat_4gb_code_seg_sel:alloc_inst_a_page
         %endmacro 
;-------------------------------------------------------------------------------
         %macro alloc_user_linear 0              ;ÔÚÈÎÎñ¿Õ¼äÖÐ·ÖÅäÐéÄâÄÚ´æ 
               mov ebx,[esi+0x06]
               add dword [esi+0x06],0x1000
               call flat_4gb_code_seg_sel:alloc_inst_a_page
         %endmacro
         
;===============================================================================
SECTION  core  vstart=0x80040000

         ;ÒÔÏÂÊÇÏµÍ³ºËÐÄµÄÍ·²¿£¬ÓÃÓÚ¼ÓÔØºËÐÄ³ÌÐò 
         core_length      dd core_end       ;ºËÐÄ³ÌÐò×Ü³¤¶È#00

         core_entry       dd start          ;ºËÐÄ´úÂë¶ÎÈë¿Úµã#04

;-------------------------------------------------------------------------------
         [bits 32]
;-------------------------------------------------------------------------------
         ;×Ö·û´®ÏÔÊ¾Àý³Ì£¨ÊÊÓÃÓÚÆ½Ì¹ÄÚ´æÄ£ÐÍ£© 
put_string:                                 ;ÏÔÊ¾0ÖÕÖ¹µÄ×Ö·û´®²¢ÒÆ¶¯¹â±ê 
                                            ;ÊäÈë£ºEBX=×Ö·û´®µÄÏßÐÔµØÖ·

         push ebx
         push ecx

         cli                                ;Ó²¼þ²Ù×÷ÆÚ¼ä£¬¹ØÖÐ¶Ï

  .getc:
         mov cl,[ebx]
         or cl,cl                           ;¼ì²â´®½áÊø±êÖ¾£¨0£© 
         jz .exit                           ;ÏÔÊ¾Íê±Ï£¬·µ»Ø 
         call put_char
         inc ebx
         jmp .getc

  .exit:

         sti                                ;Ó²¼þ²Ù×÷Íê±Ï£¬¿ª·ÅÖÐ¶Ï

         pop ecx
         pop ebx

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
         and ebx,0x0000ffff                 ;×¼±¸Ê¹ÓÃ32Î»Ñ°Ö··½Ê½·ÃÎÊÏÔ´æ 
         
         cmp cl,0x0d                        ;»Ø³µ·û£¿
         jnz .put_0a                         
         
         mov ax,bx                          ;ÒÔÏÂ°´»Ø³µ·û´¦Àí 
         mov bl,80
         div bl
         mul bl
         mov bx,ax
         jmp .set_cursor

  .put_0a:
         cmp cl,0x0a                        ;»»ÐÐ·û£¿
         jnz .put_other
         add bx,80                          ;Ôö¼ÓÒ»ÐÐ 
         jmp .roll_screen

  .put_other:                               ;Õý³£ÏÔÊ¾×Ö·û
         shl bx,1
         mov [0x800b8000+ebx],cl            ;ÔÚ¹â±êÎ»ÖÃ´¦ÏÔÊ¾×Ö·û 

         ;ÒÔÏÂ½«¹â±êÎ»ÖÃÍÆ½øÒ»¸ö×Ö·û
         shr bx,1
         inc bx

  .roll_screen:
         cmp bx,2000                        ;¹â±ê³¬³öÆÁÄ»£¿¹öÆÁ
         jl .set_cursor

         cld
         mov esi,0x800b80a0                 ;Ð¡ÐÄ£¡32Î»Ä£Ê½ÏÂmovsb/w/d 
         mov edi,0x800b8000                 ;Ê¹ÓÃµÄÊÇesi/edi/ecx 
         mov ecx,1920
         rep movsd
         mov bx,3840                        ;Çå³ýÆÁÄ»×îµ×Ò»ÐÐ
         mov ecx,80                         ;32Î»³ÌÐòÓ¦¸ÃÊ¹ÓÃECX
  .cls:
         mov word [0x800b8000+ebx],0x0720
         add bx,2
         loop .cls

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
read_hard_disk_0:                           ;´ÓÓ²ÅÌ¶ÁÈ¡Ò»¸öÂß¼­ÉÈÇø£¨Æ½Ì¹Ä£ÐÍ£© 
                                            ;EAX=Âß¼­ÉÈÇøºÅ
                                            ;EBX=Ä¿±ê»º³åÇøÏßÐÔµØÖ·
                                            ;·µ»Ø£ºEBX=EBX+512
         cli
         
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
      
         sti
      
         retf                               ;Ô¶·µ»Ø 

;-------------------------------------------------------------------------------
;»ã±àÓïÑÔ³ÌÐòÊÇ¼«ÄÑÒ»´Î³É¹¦£¬¶øÇÒµ÷ÊÔ·Ç³£À§ÄÑ¡£Õâ¸öÀý³Ì¿ÉÒÔÌá¹©°ïÖú 
put_hex_dword:                              ;ÔÚµ±Ç°¹â±ê´¦ÒÔÊ®Áù½øÖÆÐÎÊ½ÏÔÊ¾
                                            ;Ò»¸öË«×Ö²¢ÍÆ½ø¹â±ê 
                                            ;ÊäÈë£ºEDX=Òª×ª»»²¢ÏÔÊ¾µÄÊý×Ö
                                            ;Êä³ö£ºÎÞ
         pushad

         mov ebx,bin_hex                    ;Ö¸ÏòºËÐÄµØÖ·¿Õ¼äÄÚµÄ×ª»»±í
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
      
         popad
         retf
      
;-------------------------------------------------------------------------------
set_up_gdt_descriptor:                      ;ÔÚGDTÄÚ°²×°Ò»¸öÐÂµÄÃèÊö·û
                                            ;ÊäÈë£ºEDX:EAX=ÃèÊö·û 
                                            ;Êä³ö£ºCX=ÃèÊö·ûµÄÑ¡Ôñ×Ó
         push eax
         push ebx
         push edx

         sgdt [pgdt]                        ;È¡µÃGDTRµÄ½çÏÞºÍÏßÐÔµØÖ· 

         movzx ebx,word [pgdt]              ;GDT½çÏÞ
         inc bx                             ;GDT×Ü×Ö½ÚÊý£¬Ò²ÊÇÏÂÒ»¸öÃèÊö·ûÆ«ÒÆ
         add ebx,[pgdt+2]                   ;ÏÂÒ»¸öÃèÊö·ûµÄÏßÐÔµØÖ·

         mov [ebx],eax
         mov [ebx+4],edx

         add word [pgdt],8                  ;Ôö¼ÓÒ»¸öÃèÊö·ûµÄ´óÐ¡

         lgdt [pgdt]                        ;¶ÔGDTµÄ¸ü¸ÄÉúÐ§

         mov ax,[pgdt]                      ;µÃµ½GDT½çÏÞÖµ
         xor dx,dx
         mov bx,8
         div bx                             ;³ýÒÔ8£¬È¥µôÓàÊý
         mov cx,ax
         shl cx,3                           ;½«Ë÷ÒýºÅÒÆµ½ÕýÈ·Î»ÖÃ

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

         xor eax,eax
  .b1:
         bts [page_bit_map],eax
         jnc .b2
         inc eax
         cmp eax,page_map_len*8
         jl .b1
         
         mov ebx,message_3
         call flat_4gb_code_seg_sel:put_string
         hlt                                ;Ã»ÓÐ¿ÉÒÔ·ÖÅäµÄÒ³£¬Í£»ú 
         
  .b2:
         shl eax,12                         ;³ËÒÔ4096£¨0x1000£© 
         
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
          
         pop esi
         pop ebx
         pop eax
         
         retf  

;-------------------------------------------------------------------------------
create_copy_cur_pdir:                       ;´´½¨ÐÂÒ³Ä¿Â¼£¬²¢¸´ÖÆµ±Ç°Ò³Ä¿Â¼ÄÚÈÝ
                                            ;ÊäÈë£ºÎÞ
                                            ;Êä³ö£ºEAX=ÐÂÒ³Ä¿Â¼µÄÎïÀíµØÖ· 
         push esi
         push edi
         push ebx
         push ecx
         
         call allocate_a_4k_page            
         mov ebx,eax
         or ebx,0x00000007
         mov [0xfffffff8],ebx

         invlpg [0xfffffff8]

         mov esi,0xfffff000                 ;ESI->µ±Ç°Ò³Ä¿Â¼µÄÏßÐÔµØÖ·
         mov edi,0xffffe000                 ;EDI->ÐÂÒ³Ä¿Â¼µÄÏßÐÔµØÖ·
         mov ecx,1024                       ;ECX=Òª¸´ÖÆµÄÄ¿Â¼ÏîÊý
         cld
         repe movsd 
         
         pop ecx
         pop ebx
         pop edi
         pop esi
         
         retf
         
;-------------------------------------------------------------------------------
general_interrupt_handler:                  ;Í¨ÓÃµÄÖÐ¶Ï´¦Àí¹ý³Ì
         push eax
          
         mov al,0x20                        ;ÖÐ¶Ï½áÊøÃüÁîEOI 
         out 0xa0,al                        ;Ïò´ÓÆ¬·¢ËÍ 
         out 0x20,al                        ;ÏòÖ÷Æ¬·¢ËÍ
         
         pop eax
          
         iretd

;-------------------------------------------------------------------------------
general_exception_handler:                  ;Í¨ÓÃµÄÒì³£´¦Àí¹ý³Ì
         mov ebx,excep_msg
         call flat_4gb_code_seg_sel:put_string
         
         hlt

;-------------------------------------------------------------------------------
rtm_0x70_interrupt_handle:                  ;ÊµÊ±Ê±ÖÓÖÐ¶Ï´¦Àí¹ý³Ì

         pushad

         mov al,0x20                        ;ÖÐ¶Ï½áÊøÃüÁîEOI
         out 0xa0,al                        ;Ïò8259A´ÓÆ¬·¢ËÍ
         out 0x20,al                        ;Ïò8259AÖ÷Æ¬·¢ËÍ

         mov al,0x0c                        ;¼Ä´æÆ÷CµÄË÷Òý¡£ÇÒ¿ª·ÅNMI
         out 0x70,al
         in al,0x71                         ;¶ÁÒ»ÏÂRTCµÄ¼Ä´æÆ÷C£¬·ñÔòÖ»·¢ÉúÒ»´ÎÖÐ¶Ï
                                            ;´Ë´¦²»¿¼ÂÇÄÖÖÓºÍÖÜÆÚÐÔÖÐ¶ÏµÄÇé¿ö
         ;ÕÒµ±Ç°ÈÎÎñ£¨×´Ì¬ÎªÃ¦µÄÈÎÎñ£©ÔÚÁ´±íÖÐµÄÎ»ÖÃ
         mov eax,tcb_chain                  
  .b0:                                      ;EAX=Á´±íÍ·»òµ±Ç°TCBÏßÐÔµØÖ·
         mov ebx,[eax]                      ;EBX=ÏÂÒ»¸öTCBÏßÐÔµØÖ·
         or ebx,ebx
         jz .irtn                           ;Á´±íÎª¿Õ£¬»òÒÑµ½Ä©Î²£¬´ÓÖÐ¶Ï·µ»Ø
         cmp word [ebx+0x04],0xffff         ;ÊÇÃ¦ÈÎÎñ£¨µ±Ç°ÈÎÎñ£©£¿
         je .b1
         mov eax,ebx                        ;¶¨Î»µ½ÏÂÒ»¸öTCB£¨µÄÏßÐÔµØÖ·£©
         jmp .b0         

         ;½«µ±Ç°ÎªÃ¦µÄÈÎÎñÒÆµ½Á´Î²
  .b1:
         mov ecx,[ebx]                      ;ÏÂÓÎTCBµÄÏßÐÔµØÖ·
         mov [eax],ecx                      ;½«µ±Ç°ÈÎÎñ´ÓÁ´ÖÐ²ð³ý

  .b2:                                      ;´ËÊ±£¬EBX=µ±Ç°ÈÎÎñµÄÏßÐÔµØÖ·
         mov edx,[eax]
         or edx,edx                         ;ÒÑµ½Á´±íÎ²¶Ë£¿
         jz .b3
         mov eax,edx
         jmp .b2

  .b3:
         mov [eax],ebx                      ;½«Ã¦ÈÎÎñµÄTCB¹ÒÔÚÁ´±íÎ²¶Ë
         mov dword [ebx],0x00000000         ;½«Ã¦ÈÎÎñµÄTCB±ê¼ÇÎªÁ´Î²

         ;´ÓÁ´Ê×ËÑË÷µÚÒ»¸ö¿ÕÏÐÈÎÎñ
         mov eax,tcb_chain
  .b4:
         mov eax,[eax]
         or eax,eax                         ;ÒÑµ½Á´Î²£¨Î´·¢ÏÖ¿ÕÏÐÈÎÎñ£©
         jz .irtn                           ;Î´·¢ÏÖ¿ÕÏÐÈÎÎñ£¬´ÓÖÐ¶Ï·µ»Ø
         cmp word [eax+0x04],0x0000         ;ÊÇ¿ÕÏÐÈÎÎñ£¿
         jnz .b4

         ;½«¿ÕÏÐÈÎÎñºÍµ±Ç°ÈÎÎñµÄ×´Ì¬¶¼È¡·´
         not word [eax+0x04]                ;ÉèÖÃ¿ÕÏÐÈÎÎñµÄ×´Ì¬ÎªÃ¦
         not word [ebx+0x04]                ;ÉèÖÃµ±Ç°ÈÎÎñ£¨Ã¦£©µÄ×´Ì¬Îª¿ÕÏÐ
         jmp far [eax+0x14]                 ;ÈÎÎñ×ª»»

  .irtn:
         popad

         iretd

;-------------------------------------------------------------------------------
terminate_current_task:                     ;ÖÕÖ¹µ±Ç°ÈÎÎñ
                                            ;×¢Òâ£¬Ö´ÐÐ´ËÀý³ÌÊ±£¬µ±Ç°ÈÎÎñÈÔÔÚ
                                            ;ÔËÐÐÖÐ¡£´ËÀý³ÌÆäÊµÒ²ÊÇµ±Ç°ÈÎÎñµÄ
                                            ;Ò»²¿·Ö 
         ;ÕÒµ±Ç°ÈÎÎñ£¨×´Ì¬ÎªÃ¦µÄÈÎÎñ£©ÔÚÁ´±íÖÐµÄÎ»ÖÃ
         mov eax,tcb_chain
  .b0:                                      ;EAX=Á´±íÍ·»òµ±Ç°TCBÏßÐÔµØÖ·
         mov ebx,[eax]                      ;EBX=ÏÂÒ»¸öTCBÏßÐÔµØÖ·
         cmp word [ebx+0x04],0xffff         ;ÊÇÃ¦ÈÎÎñ£¨µ±Ç°ÈÎÎñ£©£¿
         je .b1
         mov eax,ebx                        ;¶¨Î»µ½ÏÂÒ»¸öTCB£¨µÄÏßÐÔµØÖ·£©
         jmp .b0
         
  .b1:
         mov word [ebx+0x04],0x3333         ;ÐÞ¸Äµ±Ç°ÈÎÎñµÄ×´Ì¬Îª¡°ÍË³ö¡±
         
  .b2:
         hlt                                ;Í£»ú£¬µÈ´ý³ÌÐò¹ÜÀíÆ÷»Ö¸´ÔËÐÐÊ±£¬
                                            ;½«Æä»ØÊÕ 
         jmp .b2 

;------------------------------------------------------------------------------- 
         pgdt             dw  0             ;ÓÃÓÚÉèÖÃºÍÐÞ¸ÄGDT 
                          dd  0

         pidt             dw  0
                          dd  0
                          
         ;ÈÎÎñ¿ØÖÆ¿éÁ´
         tcb_chain        dd  0 

         core_tcb   times  32  db 0         ;ÄÚºË£¨³ÌÐò¹ÜÀíÆ÷£©µÄTCB

         page_bit_map     db  0xff,0xff,0xff,0xff,0xff,0xff,0x55,0x55
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
                          dw  flat_4gb_code_seg_sel

         salt_2           db  '@ReadDiskData'
                     times 256-($-salt_2) db 0
                          dd  read_hard_disk_0
                          dw  flat_4gb_code_seg_sel

         salt_3           db  '@PrintDwordAsHexString'
                     times 256-($-salt_3) db 0
                          dd  put_hex_dword
                          dw  flat_4gb_code_seg_sel

         salt_4           db  '@TerminateProgram'
                     times 256-($-salt_4) db 0
                          dd  terminate_current_task
                          dw  flat_4gb_code_seg_sel

         salt_item_len   equ $-salt_4
         salt_items      equ ($-salt)/salt_item_len

         excep_msg        db  '********Exception encounted********',0

         message_0        db  '  Working in system core with protection '
                          db  'and paging are all enabled.System core is mapped '
                          db  'to address 0x80000000.',0x0d,0x0a,0

         message_1        db  '  System wide CALL-GATE mounted.',0x0d,0x0a,0
         
         message_3        db  '********No more pages********',0
         
         core_msg0        db  '  System core task running!',0x0d,0x0a,0
         
         bin_hex          db '0123456789ABCDEF'
                                            ;put_hex_dword×Ó¹ý³ÌÓÃµÄ²éÕÒ±í 

         core_buf   times 512 db 0          ;ÄÚºËÓÃµÄ»º³åÇø

         cpu_brnd0        db 0x0d,0x0a,'  ',0
         cpu_brand  times 52 db 0
         cpu_brnd1        db 0x0d,0x0a,0x0d,0x0a,0

;-------------------------------------------------------------------------------
fill_descriptor_in_ldt:                     ;ÔÚLDTÄÚ°²×°Ò»¸öÐÂµÄÃèÊö·û
                                            ;ÊäÈë£ºEDX:EAX=ÃèÊö·û
                                            ;          EBX=TCB»ùµØÖ·
                                            ;Êä³ö£ºCX=ÃèÊö·ûµÄÑ¡Ôñ×Ó
         push eax
         push edx
         push edi

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
      
         mov ebp,esp                        ;Îª·ÃÎÊÍ¨¹ý¶ÑÕ»´«µÝµÄ²ÎÊý×ö×¼±¸
      
         ;Çå¿Õµ±Ç°Ò³Ä¿Â¼µÄÇ°°ë²¿·Ö£¨¶ÔÓ¦µÍ2GBµÄ¾Ö²¿µØÖ·¿Õ¼ä£© 
         mov ebx,0xfffff000
         xor esi,esi
  .b1:
         mov dword [ebx+esi*4],0x00000000
         inc esi
         cmp esi,512
         jl .b1

         mov eax,cr3
         mov cr3,eax                        ;Ë¢ÐÂTLB 
         
         ;ÒÔÏÂ¿ªÊ¼·ÖÅäÄÚ´æ²¢¼ÓÔØÓÃ»§³ÌÐò
         mov eax,[ebp+40]                   ;´Ó¶ÑÕ»ÖÐÈ¡³öÓÃ»§³ÌÐòÆðÊ¼ÉÈÇøºÅ
         mov ebx,core_buf                   ;¶ÁÈ¡³ÌÐòÍ·²¿Êý¾Ý
         call flat_4gb_code_seg_sel:read_hard_disk_0

         ;ÒÔÏÂÅÐ¶ÏÕû¸ö³ÌÐòÓÐ¶à´ó
         mov eax,[core_buf]                 ;³ÌÐò³ß´ç
         mov ebx,eax
         and ebx,0xfffff000                 ;Ê¹Ö®4KB¶ÔÆë 
         add ebx,0x1000                        
         test eax,0x00000fff                ;³ÌÐòµÄ´óÐ¡ÕýºÃÊÇ4KBµÄ±¶ÊýÂð? 
         cmovnz eax,ebx                     ;²»ÊÇ¡£Ê¹ÓÃ´ÕÕûµÄ½á¹û

         mov ecx,eax
         shr ecx,12                         ;³ÌÐòÕ¼ÓÃµÄ×Ü4KBÒ³Êý 
         
         mov eax,[ebp+40]                   ;ÆðÊ¼ÉÈÇøºÅ
         mov esi,[ebp+36]                   ;´Ó¶ÑÕ»ÖÐÈ¡µÃTCBµÄ»ùµØÖ·
  .b2:
         alloc_user_linear                  ;ºê£ºÔÚÓÃ»§ÈÎÎñµØÖ·¿Õ¼äÉÏ·ÖÅäÄÚ´æ 
         
         push ecx
         mov ecx,8
  .b3:
         call flat_4gb_code_seg_sel:read_hard_disk_0               
         inc eax
         loop .b3

         pop ecx
         loop .b2

         ;ÔÚÄÚºËµØÖ·¿Õ¼äÄÚ´´½¨ÓÃ»§ÈÎÎñµÄTSS
         alloc_core_linear                  ;ºê£ºÔÚÄÚºËµÄµØÖ·¿Õ¼äÉÏ·ÖÅäÄÚ´æ
                                            ;ÓÃ»§ÈÎÎñµÄTSS±ØÐëÔÚÈ«¾Ö¿Õ¼äÉÏ·ÖÅä 
         
         mov [esi+0x14],ebx                 ;ÔÚTCBÖÐÌîÐ´TSSµÄÏßÐÔµØÖ· 
         mov word [esi+0x12],103            ;ÔÚTCBÖÐÌîÐ´TSSµÄ½çÏÞÖµ 
          
         ;ÔÚÓÃ»§ÈÎÎñµÄ¾Ö²¿µØÖ·¿Õ¼äÄÚ´´½¨LDT 
         alloc_user_linear                  ;ºê£ºÔÚÓÃ»§ÈÎÎñµØÖ·¿Õ¼äÉÏ·ÖÅäÄÚ´æ

         mov [esi+0x0c],ebx                 ;ÌîÐ´LDTÏßÐÔµØÖ·µ½TCBÖÐ 

         ;½¨Á¢³ÌÐò´úÂë¶ÎÃèÊö·û
         mov eax,0x00000000
         mov ebx,0x000fffff                 
         mov ecx,0x00c0f800                 ;4KBÁ£¶ÈµÄ´úÂë¶ÎÃèÊö·û£¬ÌØÈ¨¼¶3
         call flat_4gb_code_seg_sel:make_seg_descriptor
         mov ebx,esi                        ;TCBµÄ»ùµØÖ·
         call fill_descriptor_in_ldt
         or cx,0000_0000_0000_0011B         ;ÉèÖÃÑ¡Ôñ×ÓµÄÌØÈ¨¼¶Îª3
         
         mov ebx,[esi+0x14]                 ;´ÓTCBÖÐ»ñÈ¡TSSµÄÏßÐÔµØÖ·
         mov [ebx+76],cx                    ;ÌîÐ´TSSµÄCSÓò 

         ;½¨Á¢³ÌÐòÊý¾Ý¶ÎÃèÊö·û
         mov eax,0x00000000
         mov ebx,0x000fffff                 
         mov ecx,0x00c0f200                 ;4KBÁ£¶ÈµÄÊý¾Ý¶ÎÃèÊö·û£¬ÌØÈ¨¼¶3
         call flat_4gb_code_seg_sel:make_seg_descriptor
         mov ebx,esi                        ;TCBµÄ»ùµØÖ·
         call fill_descriptor_in_ldt
         or cx,0000_0000_0000_0011B         ;ÉèÖÃÑ¡Ôñ×ÓµÄÌØÈ¨¼¶Îª3
         
         mov ebx,[esi+0x14]                 ;´ÓTCBÖÐ»ñÈ¡TSSµÄÏßÐÔµØÖ·
         mov [ebx+84],cx                    ;ÌîÐ´TSSµÄDSÓò 
         mov [ebx+72],cx                    ;ÌîÐ´TSSµÄESÓò
         mov [ebx+88],cx                    ;ÌîÐ´TSSµÄFSÓò
         mov [ebx+92],cx                    ;ÌîÐ´TSSµÄGSÓò
         
         ;½«Êý¾Ý¶Î×÷ÎªÓÃ»§ÈÎÎñµÄ3ÌØÈ¨¼¶¹ÌÓÐ¶ÑÕ» 
         alloc_user_linear                  ;ºê£ºÔÚÓÃ»§ÈÎÎñµØÖ·¿Õ¼äÉÏ·ÖÅäÄÚ´æ
         
         mov ebx,[esi+0x14]                 ;´ÓTCBÖÐ»ñÈ¡TSSµÄÏßÐÔµØÖ·
         mov [ebx+80],cx                    ;ÌîÐ´TSSµÄSSÓò
         mov edx,[esi+0x06]                 ;¶ÑÕ»µÄ¸ß¶ËÏßÐÔµØÖ· 
         mov [ebx+56],edx                   ;ÌîÐ´TSSµÄESPÓò 

         ;ÔÚÓÃ»§ÈÎÎñµÄ¾Ö²¿µØÖ·¿Õ¼äÄÚ´´½¨0ÌØÈ¨¼¶¶ÑÕ»
         alloc_user_linear                  ;ºê£ºÔÚÓÃ»§ÈÎÎñµØÖ·¿Õ¼äÉÏ·ÖÅäÄÚ´æ

         mov eax,0x00000000
         mov ebx,0x000fffff
         mov ecx,0x00c09200                 ;4KBÁ£¶ÈµÄ¶ÑÕ»¶ÎÃèÊö·û£¬ÌØÈ¨¼¶0
         call flat_4gb_code_seg_sel:make_seg_descriptor
         mov ebx,esi                        ;TCBµÄ»ùµØÖ·
         call fill_descriptor_in_ldt
         or cx,0000_0000_0000_0000B         ;ÉèÖÃÑ¡Ôñ×ÓµÄÌØÈ¨¼¶Îª0

         mov ebx,[esi+0x14]                 ;´ÓTCBÖÐ»ñÈ¡TSSµÄÏßÐÔµØÖ·
         mov [ebx+8],cx                     ;ÌîÐ´TSSµÄSS0Óò
         mov edx,[esi+0x06]                 ;¶ÑÕ»µÄ¸ß¶ËÏßÐÔµØÖ·
         mov [ebx+4],edx                    ;ÌîÐ´TSSµÄESP0Óò 

         ;ÔÚÓÃ»§ÈÎÎñµÄ¾Ö²¿µØÖ·¿Õ¼äÄÚ´´½¨1ÌØÈ¨¼¶¶ÑÕ»
         alloc_user_linear                  ;ºê£ºÔÚÓÃ»§ÈÎÎñµØÖ·¿Õ¼äÉÏ·ÖÅäÄÚ´æ

         mov eax,0x00000000
         mov ebx,0x000fffff
         mov ecx,0x00c0b200                 ;4KBÁ£¶ÈµÄ¶ÑÕ»¶ÎÃèÊö·û£¬ÌØÈ¨¼¶1
         call flat_4gb_code_seg_sel:make_seg_descriptor
         mov ebx,esi                        ;TCBµÄ»ùµØÖ·
         call fill_descriptor_in_ldt
         or cx,0000_0000_0000_0001B         ;ÉèÖÃÑ¡Ôñ×ÓµÄÌØÈ¨¼¶Îª1

         mov ebx,[esi+0x14]                 ;´ÓTCBÖÐ»ñÈ¡TSSµÄÏßÐÔµØÖ·
         mov [ebx+16],cx                    ;ÌîÐ´TSSµÄSS1Óò
         mov edx,[esi+0x06]                 ;¶ÑÕ»µÄ¸ß¶ËÏßÐÔµØÖ·
         mov [ebx+12],edx                   ;ÌîÐ´TSSµÄESP1Óò 

         ;ÔÚÓÃ»§ÈÎÎñµÄ¾Ö²¿µØÖ·¿Õ¼äÄÚ´´½¨2ÌØÈ¨¼¶¶ÑÕ»
         alloc_user_linear                  ;ºê£ºÔÚÓÃ»§ÈÎÎñµØÖ·¿Õ¼äÉÏ·ÖÅäÄÚ´æ

         mov eax,0x00000000
         mov ebx,0x000fffff
         mov ecx,0x00c0d200                 ;4KBÁ£¶ÈµÄ¶ÑÕ»¶ÎÃèÊö·û£¬ÌØÈ¨¼¶2
         call flat_4gb_code_seg_sel:make_seg_descriptor
         mov ebx,esi                        ;TCBµÄ»ùµØÖ·
         call fill_descriptor_in_ldt
         or cx,0000_0000_0000_0010B         ;ÉèÖÃÑ¡Ôñ×ÓµÄÌØÈ¨¼¶Îª2

         mov ebx,[esi+0x14]                 ;´ÓTCBÖÐ»ñÈ¡TSSµÄÏßÐÔµØÖ·
         mov [ebx+24],cx                    ;ÌîÐ´TSSµÄSS2Óò
         mov edx,[esi+0x06]                 ;¶ÑÕ»µÄ¸ß¶ËÏßÐÔµØÖ·
         mov [ebx+20],edx                   ;ÌîÐ´TSSµÄESP2Óò 

         ;ÖØ¶¨Î»U-SALT 
         cld

         mov ecx,[0x0c]                     ;U-SALTÌõÄ¿Êý 
         mov edi,[0x08]                     ;U-SALTÔÚ4GB¿Õ¼äÄÚµÄÆ«ÒÆ 
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
         mov [edi-256],eax                  ;½«×Ö·û´®¸ÄÐ´³ÉÆ«ÒÆµØÖ· 
         mov ax,[esi+4]
         or ax,0000000000000011B            ;ÒÔÓÃ»§³ÌÐò×Ô¼ºµÄÌØÈ¨¼¶Ê¹ÓÃµ÷ÓÃÃÅ
                                            ;¹ÊRPL=3 
         mov [edi-252],ax                   ;»ØÌîµ÷ÓÃÃÅÑ¡Ôñ×Ó 
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
         mov esi,[ebp+36]                   ;´Ó¶ÑÕ»ÖÐÈ¡µÃTCBµÄ»ùµØÖ·
         mov eax,[esi+0x0c]                 ;LDTµÄÆðÊ¼ÏßÐÔµØÖ·
         movzx ebx,word [esi+0x0a]          ;LDT¶Î½çÏÞ
         mov ecx,0x00408200                 ;LDTÃèÊö·û£¬ÌØÈ¨¼¶0
         call flat_4gb_code_seg_sel:make_seg_descriptor
         call flat_4gb_code_seg_sel:set_up_gdt_descriptor
         mov [esi+0x10],cx                  ;µÇ¼ÇLDTÑ¡Ôñ×Óµ½TCBÖÐ

         mov ebx,[esi+0x14]                 ;´ÓTCBÖÐ»ñÈ¡TSSµÄÏßÐÔµØÖ·
         mov [ebx+96],cx                    ;ÌîÐ´TSSµÄLDTÓò 

         mov word [ebx+0],0                 ;·´ÏòÁ´=0
      
         mov dx,[esi+0x12]                  ;¶Î³¤¶È£¨½çÏÞ£©
         mov [ebx+102],dx                   ;ÌîÐ´TSSµÄI/OÎ»Í¼Æ«ÒÆÓò 
      
         mov word [ebx+100],0               ;T=0
      
         mov eax,[0x04]                     ;´ÓÈÎÎñµÄ4GBµØÖ·¿Õ¼ä»ñÈ¡Èë¿Úµã 
         mov [ebx+32],eax                   ;ÌîÐ´TSSµÄEIPÓò 

         pushfd
         pop edx
         mov [ebx+36],edx                   ;ÌîÐ´TSSµÄEFLAGSÓò 

         ;ÔÚGDTÖÐµÇ¼ÇTSSÃèÊö·û
         mov eax,[esi+0x14]                 ;´ÓTCBÖÐ»ñÈ¡TSSµÄÆðÊ¼ÏßÐÔµØÖ·
         movzx ebx,word [esi+0x12]          ;¶Î³¤¶È£¨½çÏÞ£©
         mov ecx,0x00408900                 ;TSSÃèÊö·û£¬ÌØÈ¨¼¶0
         call flat_4gb_code_seg_sel:make_seg_descriptor
         call flat_4gb_code_seg_sel:set_up_gdt_descriptor
         mov [esi+0x18],cx                  ;µÇ¼ÇTSSÑ¡Ôñ×Óµ½TCB

         ;´´½¨ÓÃ»§ÈÎÎñµÄÒ³Ä¿Â¼
         ;×¢Òâ£¡Ò³µÄ·ÖÅäºÍÊ¹ÓÃÊÇÓÉÒ³Î»Í¼¾ö¶¨µÄ£¬¿ÉÒÔ²»Õ¼ÓÃÏßÐÔµØÖ·¿Õ¼ä 
         call flat_4gb_code_seg_sel:create_copy_cur_pdir
         mov ebx,[esi+0x14]                 ;´ÓTCBÖÐ»ñÈ¡TSSµÄÏßÐÔµØÖ·
         mov dword [ebx+28],eax             ;ÌîÐ´TSSµÄCR3(PDBR)Óò
                   
         popad
      
         ret 8                              ;¶ªÆúµ÷ÓÃ±¾¹ý³ÌÇ°Ñ¹ÈëµÄ²ÎÊý 
      
;-------------------------------------------------------------------------------
append_to_tcb_link:                         ;ÔÚTCBÁ´ÉÏ×·¼ÓÈÎÎñ¿ØÖÆ¿é
                                            ;ÊäÈë£ºECX=TCBÏßÐÔ»ùµØÖ·
         cli
         
         push eax
         push ebx

         mov eax,tcb_chain
  .b0:                                      ;EAX=Á´±íÍ·»òµ±Ç°TCBÏßÐÔµØÖ·
         mov ebx,[eax]                      ;EBX=ÏÂÒ»¸öTCBÏßÐÔµØÖ·
         or ebx,ebx
         jz .b1                             ;Á´±íÎª¿Õ£¬»òÒÑµ½Ä©Î²
         mov eax,ebx                        ;¶¨Î»µ½ÏÂÒ»¸öTCB£¨µÄÏßÐÔµØÖ·£©
         jmp .b0

  .b1:
         mov [eax],ecx
         mov dword [ecx],0x00000000         ;µ±Ç°TCBÖ¸ÕëÓòÇåÁã£¬ÒÔÖ¸Ê¾ÕâÊÇ×î
                                            ;ºóÒ»¸öTCB
         pop ebx
         pop eax
         
         sti
         
         ret
         
;-------------------------------------------------------------------------------
start:
         ;´´½¨ÖÐ¶ÏÃèÊö·û±íIDT
         ;ÔÚ´ËÖ®Ç°£¬½ûÖ¹µ÷ÓÃput_string¹ý³Ì£¬ÒÔ¼°ÈÎºÎº¬ÓÐstiÖ¸ÁîµÄ¹ý³Ì¡£
          
         ;Ç°20¸öÏòÁ¿ÊÇ´¦ÀíÆ÷Òì³£Ê¹ÓÃµÄ
         mov eax,general_exception_handler  ;ÃÅ´úÂëÔÚ¶ÎÄÚÆ«ÒÆµØÖ·
         mov bx,flat_4gb_code_seg_sel       ;ÃÅ´úÂëËùÔÚ¶ÎµÄÑ¡Ôñ×Ó
         mov cx,0x8e00                      ;32Î»ÖÐ¶ÏÃÅ£¬0ÌØÈ¨¼¶
         call flat_4gb_code_seg_sel:make_gate_descriptor

         mov ebx,idt_linear_address         ;ÖÐ¶ÏÃèÊö·û±íµÄÏßÐÔµØÖ·
         xor esi,esi
  .idt0:
         mov [ebx+esi*8],eax
         mov [ebx+esi*8+4],edx
         inc esi
         cmp esi,19                         ;°²×°Ç°20¸öÒì³£ÖÐ¶Ï´¦Àí¹ý³Ì
         jle .idt0

         ;ÆäÓàÎª±£Áô»òÓ²¼þÊ¹ÓÃµÄÖÐ¶ÏÏòÁ¿
         mov eax,general_interrupt_handler  ;ÃÅ´úÂëÔÚ¶ÎÄÚÆ«ÒÆµØÖ·
         mov bx,flat_4gb_code_seg_sel       ;ÃÅ´úÂëËùÔÚ¶ÎµÄÑ¡Ôñ×Ó
         mov cx,0x8e00                      ;32Î»ÖÐ¶ÏÃÅ£¬0ÌØÈ¨¼¶
         call flat_4gb_code_seg_sel:make_gate_descriptor

         mov ebx,idt_linear_address         ;ÖÐ¶ÏÃèÊö·û±íµÄÏßÐÔµØÖ·
  .idt1:
         mov [ebx+esi*8],eax
         mov [ebx+esi*8+4],edx
         inc esi
         cmp esi,255                        ;°²×°ÆÕÍ¨µÄÖÐ¶Ï´¦Àí¹ý³Ì
         jle .idt1

         ;ÉèÖÃÊµÊ±Ê±ÖÓÖÐ¶Ï´¦Àí¹ý³Ì
         mov eax,rtm_0x70_interrupt_handle  ;ÃÅ´úÂëÔÚ¶ÎÄÚÆ«ÒÆµØÖ·
         mov bx,flat_4gb_code_seg_sel       ;ÃÅ´úÂëËùÔÚ¶ÎµÄÑ¡Ôñ×Ó
         mov cx,0x8e00                      ;32Î»ÖÐ¶ÏÃÅ£¬0ÌØÈ¨¼¶
         call flat_4gb_code_seg_sel:make_gate_descriptor

         mov ebx,idt_linear_address         ;ÖÐ¶ÏÃèÊö·û±íµÄÏßÐÔµØÖ·
         mov [ebx+0x70*8],eax
         mov [ebx+0x70*8+4],edx

         ;×¼±¸¿ª·ÅÖÐ¶Ï
         mov word [pidt],256*8-1            ;IDTµÄ½çÏÞ
         mov dword [pidt+2],idt_linear_address
         lidt [pidt]                        ;¼ÓÔØÖÐ¶ÏÃèÊö·û±í¼Ä´æÆ÷IDTR

         ;ÉèÖÃ8259AÖÐ¶Ï¿ØÖÆÆ÷
         mov al,0x11
         out 0x20,al                        ;ICW1£º±ßÑØ´¥·¢/¼¶Áª·½Ê½
         mov al,0x20
         out 0x21,al                        ;ICW2:ÆðÊ¼ÖÐ¶ÏÏòÁ¿
         mov al,0x04
         out 0x21,al                        ;ICW3:´ÓÆ¬¼¶Áªµ½IR2
         mov al,0x01
         out 0x21,al                        ;ICW4:·Ç×ÜÏß»º³å£¬È«Ç¶Ì×£¬Õý³£EOI

         mov al,0x11
         out 0xa0,al                        ;ICW1£º±ßÑØ´¥·¢/¼¶Áª·½Ê½
         mov al,0x70
         out 0xa1,al                        ;ICW2:ÆðÊ¼ÖÐ¶ÏÏòÁ¿
         mov al,0x04
         out 0xa1,al                        ;ICW3:´ÓÆ¬¼¶Áªµ½IR2
         mov al,0x01
         out 0xa1,al                        ;ICW4:·Ç×ÜÏß»º³å£¬È«Ç¶Ì×£¬Õý³£EOI

         ;ÉèÖÃºÍÊ±ÖÓÖÐ¶ÏÏà¹ØµÄÓ²¼þ 
         mov al,0x0b                        ;RTC¼Ä´æÆ÷B
         or al,0x80                         ;×è¶ÏNMI
         out 0x70,al
         mov al,0x12                        ;ÉèÖÃ¼Ä´æÆ÷B£¬½ûÖ¹ÖÜÆÚÐÔÖÐ¶Ï£¬¿ª·Å¸ü
         out 0x71,al                        ;ÐÂ½áÊøºóÖÐ¶Ï£¬BCDÂë£¬24Ð¡Ê±ÖÆ

         in al,0xa1                         ;¶Á8259´ÓÆ¬µÄIMR¼Ä´æÆ÷
         and al,0xfe                        ;Çå³ýbit 0(´ËÎ»Á¬½ÓRTC)
         out 0xa1,al                        ;Ð´»Ø´Ë¼Ä´æÆ÷

         mov al,0x0c
         out 0x70,al
         in al,0x71                         ;¶ÁRTC¼Ä´æÆ÷C£¬¸´Î»Î´¾öµÄÖÐ¶Ï×´Ì¬

         sti                                ;¿ª·ÅÓ²¼þÖÐ¶Ï

         mov ebx,message_0
         call flat_4gb_code_seg_sel:put_string

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
         call flat_4gb_code_seg_sel:put_string
         mov ebx,cpu_brand
         call flat_4gb_code_seg_sel:put_string
         mov ebx,cpu_brnd1
         call flat_4gb_code_seg_sel:put_string

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
         call flat_4gb_code_seg_sel:make_gate_descriptor
         call flat_4gb_code_seg_sel:set_up_gdt_descriptor
         mov [edi+260],cx                   ;½«·µ»ØµÄÃÅÃèÊö·ûÑ¡Ôñ×Ó»ØÌî
         add edi,salt_item_len              ;Ö¸ÏòÏÂÒ»¸öC-SALTÌõÄ¿ 
         pop ecx
         loop .b4

         ;¶ÔÃÅ½øÐÐ²âÊÔ 
         mov ebx,message_1
         call far [salt_1+256]              ;Í¨¹ýÃÅÏÔÊ¾ÐÅÏ¢(Æ«ÒÆÁ¿½«±»ºöÂÔ) 

         ;³õÊ¼»¯´´½¨³ÌÐò¹ÜÀíÆ÷ÈÎÎñµÄÈÎÎñ¿ØÖÆ¿éTCB
         mov word [core_tcb+0x04],0xffff    ;ÈÎÎñ×´Ì¬£ºÃ¦Âµ
         mov dword [core_tcb+0x06],0x80100000    
                                            ;ÄÚºËÐéÄâ¿Õ¼äµÄ·ÖÅä´ÓÕâÀï¿ªÊ¼¡£
         mov word [core_tcb+0x0a],0xffff    ;µÇ¼ÇLDT³õÊ¼µÄ½çÏÞµ½TCBÖÐ£¨Î´Ê¹ÓÃ£©
         mov ecx,core_tcb
         call append_to_tcb_link            ;½«´ËTCBÌí¼Óµ½TCBÁ´ÖÐ

         ;Îª³ÌÐò¹ÜÀíÆ÷µÄTSS·ÖÅäÄÚ´æ¿Õ¼ä
         alloc_core_linear                  ;ºê£ºÔÚÄÚºËµÄÐéÄâµØÖ·¿Õ¼ä·ÖÅäÄÚ´æ

         ;ÔÚ³ÌÐò¹ÜÀíÆ÷µÄTSSÖÐÉèÖÃ±ØÒªµÄÏîÄ¿ 
         mov word [ebx+0],0                 ;·´ÏòÁ´=0
         mov eax,cr3
         mov dword [ebx+28],eax             ;µÇ¼ÇCR3(PDBR)
         mov word [ebx+96],0                ;Ã»ÓÐLDT¡£´¦ÀíÆ÷ÔÊÐíÃ»ÓÐLDTµÄÈÎÎñ¡£
         mov word [ebx+100],0               ;T=0
         mov word [ebx+102],103             ;Ã»ÓÐI/OÎ»Í¼¡£0ÌØÈ¨¼¶ÊÂÊµÉÏ²»ÐèÒª¡£
         
         ;´´½¨³ÌÐò¹ÜÀíÆ÷µÄTSSÃèÊö·û£¬²¢°²×°µ½GDTÖÐ 
         mov eax,ebx                        ;TSSµÄÆðÊ¼ÏßÐÔµØÖ·
         mov ebx,103                        ;¶Î³¤¶È£¨½çÏÞ£©
         mov ecx,0x00408900                 ;TSSÃèÊö·û£¬ÌØÈ¨¼¶0
         call flat_4gb_code_seg_sel:make_seg_descriptor
         call flat_4gb_code_seg_sel:set_up_gdt_descriptor
         mov [core_tcb+0x18],cx             ;µÇ¼ÇÄÚºËÈÎÎñµÄTSSÑ¡Ôñ×Óµ½ÆäTCB

         ;ÈÎÎñ¼Ä´æÆ÷TRÖÐµÄÄÚÈÝÊÇÈÎÎñ´æÔÚµÄ±êÖ¾£¬¸ÃÄÚÈÝÒ²¾ö¶¨ÁËµ±Ç°ÈÎÎñÊÇË­¡£
         ;ÏÂÃæµÄÖ¸ÁîÎªµ±Ç°ÕýÔÚÖ´ÐÐµÄ0ÌØÈ¨¼¶ÈÎÎñ¡°³ÌÐò¹ÜÀíÆ÷¡±ºó²¹ÊÖÐø£¨TSS£©¡£
         ltr cx

         ;ÏÖÔÚ¿ÉÈÏÎª¡°³ÌÐò¹ÜÀíÆ÷¡±ÈÎÎñÕýÖ´ÐÐÖÐ

         ;´´½¨ÓÃ»§ÈÎÎñµÄÈÎÎñ¿ØÖÆ¿é 
         alloc_core_linear                  ;ºê£ºÔÚÄÚºËµÄÐéÄâµØÖ·¿Õ¼ä·ÖÅäÄÚ´æ
         
         mov word [ebx+0x04],0              ;ÈÎÎñ×´Ì¬£º¿ÕÏÐ 
         mov dword [ebx+0x06],0             ;ÓÃ»§ÈÎÎñ¾Ö²¿¿Õ¼äµÄ·ÖÅä´Ó0¿ªÊ¼¡£
         mov word [ebx+0x0a],0xffff         ;µÇ¼ÇLDT³õÊ¼µÄ½çÏÞµ½TCBÖÐ
      
         push dword 50                      ;ÓÃ»§³ÌÐòÎ»ÓÚÂß¼­50ÉÈÇø
         push ebx                           ;Ñ¹ÈëÈÎÎñ¿ØÖÆ¿éÆðÊ¼ÏßÐÔµØÖ· 
         call load_relocate_program
         mov ecx,ebx         
         call append_to_tcb_link            ;½«´ËTCBÌí¼Óµ½TCBÁ´ÖÐ

         ;´´½¨ÓÃ»§ÈÎÎñµÄÈÎÎñ¿ØÖÆ¿é
         alloc_core_linear                  ;ºê£ºÔÚÄÚºËµÄÐéÄâµØÖ·¿Õ¼ä·ÖÅäÄÚ´æ

         mov word [ebx+0x04],0              ;ÈÎÎñ×´Ì¬£º¿ÕÏÐ
         mov dword [ebx+0x06],0             ;ÓÃ»§ÈÎÎñ¾Ö²¿¿Õ¼äµÄ·ÖÅä´Ó0¿ªÊ¼¡£
         mov word [ebx+0x0a],0xffff         ;µÇ¼ÇLDT³õÊ¼µÄ½çÏÞµ½TCBÖÐ

         push dword 100                     ;ÓÃ»§³ÌÐòÎ»ÓÚÂß¼­100ÉÈÇø
         push ebx                           ;Ñ¹ÈëÈÎÎñ¿ØÖÆ¿éÆðÊ¼ÏßÐÔµØÖ·
         call load_relocate_program
         mov ecx,ebx
         call append_to_tcb_link            ;½«´ËTCBÌí¼Óµ½TCBÁ´ÖÐ

  .core:
         mov ebx,core_msg0
         call flat_4gb_code_seg_sel:put_string
         
         ;ÕâÀï¿ÉÒÔ±àÐ´»ØÊÕÒÑÖÕÖ¹ÈÎÎñÄÚ´æµÄ´úÂë
          
         jmp .core
            
core_code_end:

;-------------------------------------------------------------------------------
SECTION core_trail
;-------------------------------------------------------------------------------
core_end: