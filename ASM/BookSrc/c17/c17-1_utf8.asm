         ;´úÂëÇåµ¥17-3
         ;ÎÄ¼þÃû£ºc17_1.asm
         ;ÎÄ¼þËµÃ÷£ºÓÃ»§³ÌÐò 
         ;´´½¨ÈÕÆÚ£º2012-07-14 15:46   

         program_length   dd program_end          ;³ÌÐò×Ü³¤¶È#0x00
         entry_point      dd start                ;³ÌÐòÈë¿Úµã#0x04
         salt_position    dd salt_begin           ;SALT±íÆðÊ¼Æ«ÒÆÁ¿#0x08 
         salt_items       dd (salt_end-salt_begin)/256 ;SALTÌõÄ¿Êý#0x0C

;-------------------------------------------------------------------------------

         ;·ûºÅµØÖ·¼ìË÷±í
         salt_begin:                                     

         PrintString      db  '@PrintString'
                     times 256-($-PrintString) db 0
                     
         TerminateProgram db  '@TerminateProgram'
                     times 256-($-TerminateProgram) db 0

         ReadDiskData     db  '@ReadDiskData'
                     times 256-($-ReadDiskData) db 0
         
         PrintDwordAsHex  db  '@PrintDwordAsHexString'
                     times 256-($-PrintDwordAsHex) db 0
        
         salt_end:

         message_0        db  '  User task A->;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;'
                          db  0x0d,0x0a,0

;-------------------------------------------------------------------------------
      [bits 32]
;-------------------------------------------------------------------------------

start:
          
         mov ebx,message_0
         call far [PrintString]
         jmp start
                  
         call far [TerminateProgram]              ;ÍË³ö£¬²¢½«¿ØÖÆÈ¨·µ»Øµ½ºËÐÄ 
    
;-------------------------------------------------------------------------------
program_end: