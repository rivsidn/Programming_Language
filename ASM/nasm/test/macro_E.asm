%line 20+1 macro.asm

 jmp ..@0.endstr
%line 21+0 macro.asm
 ..@0.str: db "hello",13, 10
 ..@0.endstr:
 mov dx,..@0.str
 mov cx,..@0.endstr-..@0.str
 mov bx,[file]
 mov ah,0x40
 int 0x21
%line 22+1 macro.asm

