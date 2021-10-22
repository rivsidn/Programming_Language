
a.out:     file format elf64-x86-64


Disassembly of section .interp:

0000000000000238 <.interp>:
 238:	2f                   	(bad)  
 239:	6c                   	insb   (%dx),%es:(%rdi)
 23a:	69 62 36 34 2f 6c 64 	imul   $0x646c2f34,0x36(%rdx),%esp
 241:	2d 6c 69 6e 75       	sub    $0x756e696c,%eax
 246:	78 2d                	js     275 <_init-0x27b>
 248:	78 38                	js     282 <_init-0x26e>
 24a:	36 2d 36 34 2e 73    	ss sub $0x732e3436,%eax
 250:	6f                   	outsl  %ds:(%rsi),(%dx)
 251:	2e 32 00             	xor    %cs:(%rax),%al

Disassembly of section .note.ABI-tag:

0000000000000254 <.note.ABI-tag>:
 254:	04 00                	add    $0x0,%al
 256:	00 00                	add    %al,(%rax)
 258:	10 00                	adc    %al,(%rax)
 25a:	00 00                	add    %al,(%rax)
 25c:	01 00                	add    %eax,(%rax)
 25e:	00 00                	add    %al,(%rax)
 260:	47                   	rex.RXB
 261:	4e 55                	rex.WRX push %rbp
 263:	00 00                	add    %al,(%rax)
 265:	00 00                	add    %al,(%rax)
 267:	00 03                	add    %al,(%rbx)
 269:	00 00                	add    %al,(%rax)
 26b:	00 02                	add    %al,(%rdx)
 26d:	00 00                	add    %al,(%rax)
 26f:	00 00                	add    %al,(%rax)
 271:	00 00                	add    %al,(%rax)
	...

Disassembly of section .note.gnu.build-id:

0000000000000274 <.note.gnu.build-id>:
 274:	04 00                	add    $0x0,%al
 276:	00 00                	add    %al,(%rax)
 278:	14 00                	adc    $0x0,%al
 27a:	00 00                	add    %al,(%rax)
 27c:	03 00                	add    (%rax),%eax
 27e:	00 00                	add    %al,(%rax)
 280:	47                   	rex.RXB
 281:	4e 55                	rex.WRX push %rbp
 283:	00 bc 8d f3 ea 65 de 	add    %bh,-0x219a150d(%rbp,%rcx,4)
 28a:	6c                   	insb   (%dx),%es:(%rdi)
 28b:	33 f2                	xor    %edx,%esi
 28d:	f9                   	stc    
 28e:	29 59 62             	sub    %ebx,0x62(%rcx)
 291:	e5 2c                	in     $0x2c,%eax
 293:	e3 38                	jrcxz  2cd <_init-0x223>
 295:	93                   	xchg   %eax,%ebx
 296:	0f                   	.byte 0xf
 297:	2d                   	.byte 0x2d

Disassembly of section .gnu.hash:

0000000000000298 <.gnu.hash>:
 298:	01 00                	add    %eax,(%rax)
 29a:	00 00                	add    %al,(%rax)
 29c:	01 00                	add    %eax,(%rax)
 29e:	00 00                	add    %al,(%rax)
 2a0:	01 00                	add    %eax,(%rax)
	...

Disassembly of section .dynsym:

00000000000002b8 <.dynsym>:
	...
 2d0:	3f                   	(bad)  
 2d1:	00 00                	add    %al,(%rax)
 2d3:	00 20                	add    %ah,(%rax)
	...
 2e5:	00 00                	add    %al,(%rax)
 2e7:	00 0b                	add    %cl,(%rbx)
 2e9:	00 00                	add    %al,(%rax)
 2eb:	00 12                	add    %dl,(%rdx)
	...
 2fd:	00 00                	add    %al,(%rax)
 2ff:	00 21                	add    %ah,(%rcx)
 301:	00 00                	add    %al,(%rax)
 303:	00 12                	add    %dl,(%rdx)
	...
 315:	00 00                	add    %al,(%rax)
 317:	00 5b 00             	add    %bl,0x0(%rbx)
 31a:	00 00                	add    %al,(%rax)
 31c:	20 00                	and    %al,(%rax)
	...
 32e:	00 00                	add    %al,(%rax)
 330:	6a 00                	pushq  $0x0
 332:	00 00                	add    %al,(%rax)
 334:	20 00                	and    %al,(%rax)
	...
 346:	00 00                	add    %al,(%rax)
 348:	12 00                	adc    (%rax),%al
 34a:	00 00                	add    %al,(%rax)
 34c:	22 00                	and    (%rax),%al
	...

Disassembly of section .dynstr:

0000000000000360 <.dynstr>:
 360:	00 6c 69 62          	add    %ch,0x62(%rcx,%rbp,2)
 364:	63 2e                	movslq (%rsi),%ebp
 366:	73 6f                	jae    3d7 <_init-0x119>
 368:	2e 36 00 70 72       	cs add %dh,%ss:0x72(%rax)
 36d:	69 6e 74 66 00 5f 5f 	imul   $0x5f5f0066,0x74(%rsi),%ebp
 374:	63 78 61             	movslq 0x61(%rax),%edi
 377:	5f                   	pop    %rdi
 378:	66 69 6e 61 6c 69    	imul   $0x696c,0x61(%rsi),%bp
 37e:	7a 65                	jp     3e5 <_init-0x10b>
 380:	00 5f 5f             	add    %bl,0x5f(%rdi)
 383:	6c                   	insb   (%dx),%es:(%rdi)
 384:	69 62 63 5f 73 74 61 	imul   $0x6174735f,0x63(%rdx),%esp
 38b:	72 74                	jb     401 <_init-0xef>
 38d:	5f                   	pop    %rdi
 38e:	6d                   	insl   (%dx),%es:(%rdi)
 38f:	61                   	(bad)  
 390:	69 6e 00 47 4c 49 42 	imul   $0x42494c47,0x0(%rsi),%ebp
 397:	43 5f                	rex.XB pop %r15
 399:	32 2e                	xor    (%rsi),%ch
 39b:	32 2e                	xor    (%rsi),%ch
 39d:	35 00 5f 49 54       	xor    $0x54495f00,%eax
 3a2:	4d 5f                	rex.WRB pop %r15
 3a4:	64 65 72 65          	fs gs jb 40d <_init-0xe3>
 3a8:	67 69 73 74 65 72 54 	imul   $0x4d547265,0x74(%ebx),%esi
 3af:	4d 
 3b0:	43 6c                	rex.XB insb (%dx),%es:(%rdi)
 3b2:	6f                   	outsl  %ds:(%rsi),(%dx)
 3b3:	6e                   	outsb  %ds:(%rsi),(%dx)
 3b4:	65 54                	gs push %rsp
 3b6:	61                   	(bad)  
 3b7:	62                   	(bad)  
 3b8:	6c                   	insb   (%dx),%es:(%rdi)
 3b9:	65 00 5f 5f          	add    %bl,%gs:0x5f(%rdi)
 3bd:	67 6d                	insl   (%dx),%es:(%edi)
 3bf:	6f                   	outsl  %ds:(%rsi),(%dx)
 3c0:	6e                   	outsb  %ds:(%rsi),(%dx)
 3c1:	5f                   	pop    %rdi
 3c2:	73 74                	jae    438 <_init-0xb8>
 3c4:	61                   	(bad)  
 3c5:	72 74                	jb     43b <_init-0xb5>
 3c7:	5f                   	pop    %rdi
 3c8:	5f                   	pop    %rdi
 3c9:	00 5f 49             	add    %bl,0x49(%rdi)
 3cc:	54                   	push   %rsp
 3cd:	4d 5f                	rex.WRB pop %r15
 3cf:	72 65                	jb     436 <_init-0xba>
 3d1:	67 69 73 74 65 72 54 	imul   $0x4d547265,0x74(%ebx),%esi
 3d8:	4d 
 3d9:	43 6c                	rex.XB insb (%dx),%es:(%rdi)
 3db:	6f                   	outsl  %ds:(%rsi),(%dx)
 3dc:	6e                   	outsb  %ds:(%rsi),(%dx)
 3dd:	65 54                	gs push %rsp
 3df:	61                   	(bad)  
 3e0:	62                   	.byte 0x62
 3e1:	6c                   	insb   (%dx),%es:(%rdi)
 3e2:	65                   	gs
	...

Disassembly of section .gnu.version:

00000000000003e4 <.gnu.version>:
 3e4:	00 00                	add    %al,(%rax)
 3e6:	00 00                	add    %al,(%rax)
 3e8:	02 00                	add    (%rax),%al
 3ea:	02 00                	add    (%rax),%al
 3ec:	00 00                	add    %al,(%rax)
 3ee:	00 00                	add    %al,(%rax)
 3f0:	02 00                	add    (%rax),%al

Disassembly of section .gnu.version_r:

00000000000003f8 <.gnu.version_r>:
 3f8:	01 00                	add    %eax,(%rax)
 3fa:	01 00                	add    %eax,(%rax)
 3fc:	01 00                	add    %eax,(%rax)
 3fe:	00 00                	add    %al,(%rax)
 400:	10 00                	adc    %al,(%rax)
 402:	00 00                	add    %al,(%rax)
 404:	00 00                	add    %al,(%rax)
 406:	00 00                	add    %al,(%rax)
 408:	75 1a                	jne    424 <_init-0xcc>
 40a:	69 09 00 00 02 00    	imul   $0x20000,(%rcx),%ecx
 410:	33 00                	xor    (%rax),%eax
 412:	00 00                	add    %al,(%rax)
 414:	00 00                	add    %al,(%rax)
	...

Disassembly of section .rela.dyn:

0000000000000418 <.rela.dyn>:
 418:	b8 0d 20 00 00       	mov    $0x200d,%eax
 41d:	00 00                	add    %al,(%rax)
 41f:	00 08                	add    %cl,(%rax)
 421:	00 00                	add    %al,(%rax)
 423:	00 00                	add    %al,(%rax)
 425:	00 00                	add    %al,(%rax)
 427:	00 40 06             	add    %al,0x6(%rax)
 42a:	00 00                	add    %al,(%rax)
 42c:	00 00                	add    %al,(%rax)
 42e:	00 00                	add    %al,(%rax)
 430:	c0 0d 20 00 00 00 00 	rorb   $0x0,0x20(%rip)        # 457 <_init-0x99>
 437:	00 08                	add    %cl,(%rax)
	...
 441:	06                   	(bad)  
 442:	00 00                	add    %al,(%rax)
 444:	00 00                	add    %al,(%rax)
 446:	00 00                	add    %al,(%rax)
 448:	08 10                	or     %dl,(%rax)
 44a:	20 00                	and    %al,(%rax)
 44c:	00 00                	add    %al,(%rax)
 44e:	00 00                	add    %al,(%rax)
 450:	08 00                	or     %al,(%rax)
 452:	00 00                	add    %al,(%rax)
 454:	00 00                	add    %al,(%rax)
 456:	00 00                	add    %al,(%rax)
 458:	08 10                	or     %dl,(%rax)
 45a:	20 00                	and    %al,(%rax)
 45c:	00 00                	add    %al,(%rax)
 45e:	00 00                	add    %al,(%rax)
 460:	d8 0f                	fmuls  (%rdi)
 462:	20 00                	and    %al,(%rax)
 464:	00 00                	add    %al,(%rax)
 466:	00 00                	add    %al,(%rax)
 468:	06                   	(bad)  
 469:	00 00                	add    %al,(%rax)
 46b:	00 01                	add    %al,(%rcx)
	...
 475:	00 00                	add    %al,(%rax)
 477:	00 e0                	add    %ah,%al
 479:	0f 20 00             	mov    %cr0,%rax
 47c:	00 00                	add    %al,(%rax)
 47e:	00 00                	add    %al,(%rax)
 480:	06                   	(bad)  
 481:	00 00                	add    %al,(%rax)
 483:	00 03                	add    %al,(%rbx)
	...
 48d:	00 00                	add    %al,(%rax)
 48f:	00 e8                	add    %ch,%al
 491:	0f 20 00             	mov    %cr0,%rax
 494:	00 00                	add    %al,(%rax)
 496:	00 00                	add    %al,(%rax)
 498:	06                   	(bad)  
 499:	00 00                	add    %al,(%rax)
 49b:	00 04 00             	add    %al,(%rax,%rax,1)
	...
 4a6:	00 00                	add    %al,(%rax)
 4a8:	f0 0f 20 00          	lock mov %cr0,%rax
 4ac:	00 00                	add    %al,(%rax)
 4ae:	00 00                	add    %al,(%rax)
 4b0:	06                   	(bad)  
 4b1:	00 00                	add    %al,(%rax)
 4b3:	00 05 00 00 00 00    	add    %al,0x0(%rip)        # 4b9 <_init-0x37>
 4b9:	00 00                	add    %al,(%rax)
 4bb:	00 00                	add    %al,(%rax)
 4bd:	00 00                	add    %al,(%rax)
 4bf:	00 f8                	add    %bh,%al
 4c1:	0f 20 00             	mov    %cr0,%rax
 4c4:	00 00                	add    %al,(%rax)
 4c6:	00 00                	add    %al,(%rax)
 4c8:	06                   	(bad)  
 4c9:	00 00                	add    %al,(%rax)
 4cb:	00 06                	add    %al,(%rsi)
	...

Disassembly of section .rela.plt:

00000000000004d8 <.rela.plt>:
 4d8:	d0 0f                	rorb   (%rdi)
 4da:	20 00                	and    %al,(%rax)
 4dc:	00 00                	add    %al,(%rax)
 4de:	00 00                	add    %al,(%rax)
 4e0:	07                   	(bad)  
 4e1:	00 00                	add    %al,(%rax)
 4e3:	00 02                	add    %al,(%rdx)
	...

Disassembly of section .init:

00000000000004f0 <_init>:
 4f0:	48 83 ec 08          	sub    $0x8,%rsp
 4f4:	48 8b 05 ed 0a 20 00 	mov    0x200aed(%rip),%rax        # 200fe8 <__gmon_start__>
 4fb:	48 85 c0             	test   %rax,%rax
 4fe:	74 02                	je     502 <_init+0x12>
 500:	ff d0                	callq  *%rax
 502:	48 83 c4 08          	add    $0x8,%rsp
 506:	c3                   	retq   

Disassembly of section .plt:

0000000000000510 <.plt>:
 510:	ff 35 aa 0a 20 00    	pushq  0x200aaa(%rip)        # 200fc0 <_GLOBAL_OFFSET_TABLE_+0x8>
 516:	ff 25 ac 0a 20 00    	jmpq   *0x200aac(%rip)        # 200fc8 <_GLOBAL_OFFSET_TABLE_+0x10>
 51c:	0f 1f 40 00          	nopl   0x0(%rax)

0000000000000520 <printf@plt>:
 520:	ff 25 aa 0a 20 00    	jmpq   *0x200aaa(%rip)        # 200fd0 <printf@GLIBC_2.2.5>
 526:	68 00 00 00 00       	pushq  $0x0
 52b:	e9 e0 ff ff ff       	jmpq   510 <.plt>

Disassembly of section .plt.got:

0000000000000530 <__cxa_finalize@plt>:
 530:	ff 25 c2 0a 20 00    	jmpq   *0x200ac2(%rip)        # 200ff8 <__cxa_finalize@GLIBC_2.2.5>
 536:	66 90                	xchg   %ax,%ax

Disassembly of section .text:

0000000000000540 <_start>:
 540:	31 ed                	xor    %ebp,%ebp
 542:	49 89 d1             	mov    %rdx,%r9
 545:	5e                   	pop    %rsi
 546:	48 89 e2             	mov    %rsp,%rdx
 549:	48 83 e4 f0          	and    $0xfffffffffffffff0,%rsp
 54d:	50                   	push   %rax
 54e:	54                   	push   %rsp
 54f:	4c 8d 05 ea 01 00 00 	lea    0x1ea(%rip),%r8        # 740 <__libc_csu_fini>
 556:	48 8d 0d 73 01 00 00 	lea    0x173(%rip),%rcx        # 6d0 <__libc_csu_init>
 55d:	48 8d 3d 54 01 00 00 	lea    0x154(%rip),%rdi        # 6b8 <main>
 564:	ff 15 76 0a 20 00    	callq  *0x200a76(%rip)        # 200fe0 <__libc_start_main@GLIBC_2.2.5>
 56a:	f4                   	hlt    
 56b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

0000000000000570 <deregister_tm_clones>:
 570:	48 8d 3d 99 0a 20 00 	lea    0x200a99(%rip),%rdi        # 201010 <__TMC_END__>
 577:	55                   	push   %rbp
 578:	48 8d 05 91 0a 20 00 	lea    0x200a91(%rip),%rax        # 201010 <__TMC_END__>
 57f:	48 39 f8             	cmp    %rdi,%rax
 582:	48 89 e5             	mov    %rsp,%rbp
 585:	74 19                	je     5a0 <deregister_tm_clones+0x30>
 587:	48 8b 05 4a 0a 20 00 	mov    0x200a4a(%rip),%rax        # 200fd8 <_ITM_deregisterTMCloneTable>
 58e:	48 85 c0             	test   %rax,%rax
 591:	74 0d                	je     5a0 <deregister_tm_clones+0x30>
 593:	5d                   	pop    %rbp
 594:	ff e0                	jmpq   *%rax
 596:	66 2e 0f 1f 84 00 00 	nopw   %cs:0x0(%rax,%rax,1)
 59d:	00 00 00 
 5a0:	5d                   	pop    %rbp
 5a1:	c3                   	retq   
 5a2:	0f 1f 40 00          	nopl   0x0(%rax)
 5a6:	66 2e 0f 1f 84 00 00 	nopw   %cs:0x0(%rax,%rax,1)
 5ad:	00 00 00 

00000000000005b0 <register_tm_clones>:
 5b0:	48 8d 3d 59 0a 20 00 	lea    0x200a59(%rip),%rdi        # 201010 <__TMC_END__>
 5b7:	48 8d 35 52 0a 20 00 	lea    0x200a52(%rip),%rsi        # 201010 <__TMC_END__>
 5be:	55                   	push   %rbp
 5bf:	48 29 fe             	sub    %rdi,%rsi
 5c2:	48 89 e5             	mov    %rsp,%rbp
 5c5:	48 c1 fe 03          	sar    $0x3,%rsi
 5c9:	48 89 f0             	mov    %rsi,%rax
 5cc:	48 c1 e8 3f          	shr    $0x3f,%rax
 5d0:	48 01 c6             	add    %rax,%rsi
 5d3:	48 d1 fe             	sar    %rsi
 5d6:	74 18                	je     5f0 <register_tm_clones+0x40>
 5d8:	48 8b 05 11 0a 20 00 	mov    0x200a11(%rip),%rax        # 200ff0 <_ITM_registerTMCloneTable>
 5df:	48 85 c0             	test   %rax,%rax
 5e2:	74 0c                	je     5f0 <register_tm_clones+0x40>
 5e4:	5d                   	pop    %rbp
 5e5:	ff e0                	jmpq   *%rax
 5e7:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
 5ee:	00 00 
 5f0:	5d                   	pop    %rbp
 5f1:	c3                   	retq   
 5f2:	0f 1f 40 00          	nopl   0x0(%rax)
 5f6:	66 2e 0f 1f 84 00 00 	nopw   %cs:0x0(%rax,%rax,1)
 5fd:	00 00 00 

0000000000000600 <__do_global_dtors_aux>:
 600:	80 3d 09 0a 20 00 00 	cmpb   $0x0,0x200a09(%rip)        # 201010 <__TMC_END__>
 607:	75 2f                	jne    638 <__do_global_dtors_aux+0x38>
 609:	48 83 3d e7 09 20 00 	cmpq   $0x0,0x2009e7(%rip)        # 200ff8 <__cxa_finalize@GLIBC_2.2.5>
 610:	00 
 611:	55                   	push   %rbp
 612:	48 89 e5             	mov    %rsp,%rbp
 615:	74 0c                	je     623 <__do_global_dtors_aux+0x23>
 617:	48 8b 3d ea 09 20 00 	mov    0x2009ea(%rip),%rdi        # 201008 <__dso_handle>
 61e:	e8 0d ff ff ff       	callq  530 <__cxa_finalize@plt>
 623:	e8 48 ff ff ff       	callq  570 <deregister_tm_clones>
 628:	c6 05 e1 09 20 00 01 	movb   $0x1,0x2009e1(%rip)        # 201010 <__TMC_END__>
 62f:	5d                   	pop    %rbp
 630:	c3                   	retq   
 631:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
 638:	f3 c3                	repz retq 
 63a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

0000000000000640 <frame_dummy>:
 640:	55                   	push   %rbp
 641:	48 89 e5             	mov    %rsp,%rbp
 644:	5d                   	pop    %rbp
 645:	e9 66 ff ff ff       	jmpq   5b0 <register_tm_clones>

000000000000064a <func1>:
 64a:	55                   	push   %rbp
 64b:	48 89 e5             	mov    %rsp,%rbp
 64e:	48 83 ec 10          	sub    $0x10,%rsp
 652:	48 8b 45 08          	mov    0x8(%rbp),%rax
 656:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
 65a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 65e:	48 89 c2             	mov    %rax,%rdx
 661:	48 8d 35 f3 00 00 00 	lea    0xf3(%rip),%rsi        # 75b <__func__.2250>
 668:	48 8d 3d e5 00 00 00 	lea    0xe5(%rip),%rdi        # 754 <_IO_stdin_used+0x4>
 66f:	b8 00 00 00 00       	mov    $0x0,%eax
 674:	e8 a7 fe ff ff       	callq  520 <printf@plt>
 679:	90                   	nop
 67a:	c9                   	leaveq 
 67b:	c3                   	retq   

000000000000067c <func0>:
 67c:	55                   	push   %rbp
 67d:	48 89 e5             	mov    %rsp,%rbp
 680:	48 83 ec 10          	sub    $0x10,%rsp
 684:	48 8b 45 08          	mov    0x8(%rbp),%rax
 688:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
 68c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 690:	48 89 c2             	mov    %rax,%rdx
 693:	48 8d 35 c7 00 00 00 	lea    0xc7(%rip),%rsi        # 761 <__func__.2254>
 69a:	48 8d 3d b3 00 00 00 	lea    0xb3(%rip),%rdi        # 754 <_IO_stdin_used+0x4>
 6a1:	b8 00 00 00 00       	mov    $0x0,%eax
 6a6:	e8 75 fe ff ff       	callq  520 <printf@plt>
 6ab:	b8 00 00 00 00       	mov    $0x0,%eax
 6b0:	e8 95 ff ff ff       	callq  64a <func1>
 6b5:	90                   	nop
 6b6:	c9                   	leaveq 
 6b7:	c3                   	retq   

00000000000006b8 <main>:
 6b8:	55                   	push   %rbp
 6b9:	48 89 e5             	mov    %rsp,%rbp
 6bc:	b8 00 00 00 00       	mov    $0x0,%eax
 6c1:	e8 b6 ff ff ff       	callq  67c <func0>
 6c6:	b8 00 00 00 00       	mov    $0x0,%eax
 6cb:	5d                   	pop    %rbp
 6cc:	c3                   	retq   
 6cd:	0f 1f 00             	nopl   (%rax)

00000000000006d0 <__libc_csu_init>:
 6d0:	41 57                	push   %r15
 6d2:	41 56                	push   %r14
 6d4:	49 89 d7             	mov    %rdx,%r15
 6d7:	41 55                	push   %r13
 6d9:	41 54                	push   %r12
 6db:	4c 8d 25 d6 06 20 00 	lea    0x2006d6(%rip),%r12        # 200db8 <__frame_dummy_init_array_entry>
 6e2:	55                   	push   %rbp
 6e3:	48 8d 2d d6 06 20 00 	lea    0x2006d6(%rip),%rbp        # 200dc0 <__init_array_end>
 6ea:	53                   	push   %rbx
 6eb:	41 89 fd             	mov    %edi,%r13d
 6ee:	49 89 f6             	mov    %rsi,%r14
 6f1:	4c 29 e5             	sub    %r12,%rbp
 6f4:	48 83 ec 08          	sub    $0x8,%rsp
 6f8:	48 c1 fd 03          	sar    $0x3,%rbp
 6fc:	e8 ef fd ff ff       	callq  4f0 <_init>
 701:	48 85 ed             	test   %rbp,%rbp
 704:	74 20                	je     726 <__libc_csu_init+0x56>
 706:	31 db                	xor    %ebx,%ebx
 708:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
 70f:	00 
 710:	4c 89 fa             	mov    %r15,%rdx
 713:	4c 89 f6             	mov    %r14,%rsi
 716:	44 89 ef             	mov    %r13d,%edi
 719:	41 ff 14 dc          	callq  *(%r12,%rbx,8)
 71d:	48 83 c3 01          	add    $0x1,%rbx
 721:	48 39 dd             	cmp    %rbx,%rbp
 724:	75 ea                	jne    710 <__libc_csu_init+0x40>
 726:	48 83 c4 08          	add    $0x8,%rsp
 72a:	5b                   	pop    %rbx
 72b:	5d                   	pop    %rbp
 72c:	41 5c                	pop    %r12
 72e:	41 5d                	pop    %r13
 730:	41 5e                	pop    %r14
 732:	41 5f                	pop    %r15
 734:	c3                   	retq   
 735:	90                   	nop
 736:	66 2e 0f 1f 84 00 00 	nopw   %cs:0x0(%rax,%rax,1)
 73d:	00 00 00 

0000000000000740 <__libc_csu_fini>:
 740:	f3 c3                	repz retq 

Disassembly of section .fini:

0000000000000744 <_fini>:
 744:	48 83 ec 08          	sub    $0x8,%rsp
 748:	48 83 c4 08          	add    $0x8,%rsp
 74c:	c3                   	retq   

Disassembly of section .rodata:

0000000000000750 <_IO_stdin_used>:
 750:	01 00                	add    %eax,(%rax)
 752:	02 00                	add    (%rax),%al
 754:	25 73 20 25 70       	and    $0x70252073,%eax
 759:	0a 00                	or     (%rax),%al

000000000000075b <__func__.2250>:
 75b:	66 75 6e             	data16 jne 7cc <__GNU_EH_FRAME_HDR+0x64>
 75e:	63 31                	movslq (%rcx),%esi
	...

0000000000000761 <__func__.2254>:
 761:	66 75 6e             	data16 jne 7d2 <__GNU_EH_FRAME_HDR+0x6a>
 764:	63 30                	movslq (%rax),%esi
	...

Disassembly of section .eh_frame_hdr:

0000000000000768 <__GNU_EH_FRAME_HDR>:
 768:	01 1b                	add    %ebx,(%rbx)
 76a:	03 3b                	add    (%rbx),%edi
 76c:	4c 00 00             	rex.WR add %r8b,(%rax)
 76f:	00 08                	add    %cl,(%rax)
 771:	00 00                	add    %al,(%rax)
 773:	00 a8 fd ff ff 98    	add    %ch,-0x67000003(%rax)
 779:	00 00                	add    %al,(%rax)
 77b:	00 c8                	add    %cl,%al
 77d:	fd                   	std    
 77e:	ff                   	(bad)  
 77f:	ff c0                	inc    %eax
 781:	00 00                	add    %al,(%rax)
 783:	00 d8                	add    %bl,%al
 785:	fd                   	std    
 786:	ff                   	(bad)  
 787:	ff 68 00             	ljmp   *0x0(%rax)
 78a:	00 00                	add    %al,(%rax)
 78c:	e2 fe                	loop   78c <__GNU_EH_FRAME_HDR+0x24>
 78e:	ff                   	(bad)  
 78f:	ff                   	(bad)  
 790:	d8 00                	fadds  (%rax)
 792:	00 00                	add    %al,(%rax)
 794:	14 ff                	adc    $0xff,%al
 796:	ff                   	(bad)  
 797:	ff                   	(bad)  
 798:	f8                   	clc    
 799:	00 00                	add    %al,(%rax)
 79b:	00 50 ff             	add    %dl,-0x1(%rax)
 79e:	ff                   	(bad)  
 79f:	ff 18                	lcall  *(%rax)
 7a1:	01 00                	add    %eax,(%rax)
 7a3:	00 68 ff             	add    %ch,-0x1(%rax)
 7a6:	ff                   	(bad)  
 7a7:	ff                   	(bad)  
 7a8:	38 01                	cmp    %al,(%rcx)
 7aa:	00 00                	add    %al,(%rax)
 7ac:	d8 ff                	fdivr  %st(7),%st
 7ae:	ff                   	(bad)  
 7af:	ff                   	.byte 0xff
 7b0:	80 01 00             	addb   $0x0,(%rcx)
	...

Disassembly of section .eh_frame:

00000000000007b8 <__FRAME_END__-0x144>:
 7b8:	14 00                	adc    $0x0,%al
 7ba:	00 00                	add    %al,(%rax)
 7bc:	00 00                	add    %al,(%rax)
 7be:	00 00                	add    %al,(%rax)
 7c0:	01 7a 52             	add    %edi,0x52(%rdx)
 7c3:	00 01                	add    %al,(%rcx)
 7c5:	78 10                	js     7d7 <__GNU_EH_FRAME_HDR+0x6f>
 7c7:	01 1b                	add    %ebx,(%rbx)
 7c9:	0c 07                	or     $0x7,%al
 7cb:	08 90 01 07 10 14    	or     %dl,0x14100701(%rax)
 7d1:	00 00                	add    %al,(%rax)
 7d3:	00 1c 00             	add    %bl,(%rax,%rax,1)
 7d6:	00 00                	add    %al,(%rax)
 7d8:	68 fd ff ff 2b       	pushq  $0x2bfffffd
	...
 7e5:	00 00                	add    %al,(%rax)
 7e7:	00 14 00             	add    %dl,(%rax,%rax,1)
 7ea:	00 00                	add    %al,(%rax)
 7ec:	00 00                	add    %al,(%rax)
 7ee:	00 00                	add    %al,(%rax)
 7f0:	01 7a 52             	add    %edi,0x52(%rdx)
 7f3:	00 01                	add    %al,(%rcx)
 7f5:	78 10                	js     807 <__GNU_EH_FRAME_HDR+0x9f>
 7f7:	01 1b                	add    %ebx,(%rbx)
 7f9:	0c 07                	or     $0x7,%al
 7fb:	08 90 01 00 00 24    	or     %dl,0x24000001(%rax)
 801:	00 00                	add    %al,(%rax)
 803:	00 1c 00             	add    %bl,(%rax,%rax,1)
 806:	00 00                	add    %al,(%rax)
 808:	08 fd                	or     %bh,%ch
 80a:	ff                   	(bad)  
 80b:	ff 20                	jmpq   *(%rax)
 80d:	00 00                	add    %al,(%rax)
 80f:	00 00                	add    %al,(%rax)
 811:	0e                   	(bad)  
 812:	10 46 0e             	adc    %al,0xe(%rsi)
 815:	18 4a 0f             	sbb    %cl,0xf(%rdx)
 818:	0b 77 08             	or     0x8(%rdi),%esi
 81b:	80 00 3f             	addb   $0x3f,(%rax)
 81e:	1a 3b                	sbb    (%rbx),%bh
 820:	2a 33                	sub    (%rbx),%dh
 822:	24 22                	and    $0x22,%al
 824:	00 00                	add    %al,(%rax)
 826:	00 00                	add    %al,(%rax)
 828:	14 00                	adc    $0x0,%al
 82a:	00 00                	add    %al,(%rax)
 82c:	44 00 00             	add    %r8b,(%rax)
 82f:	00 00                	add    %al,(%rax)
 831:	fd                   	std    
 832:	ff                   	(bad)  
 833:	ff 08                	decl   (%rax)
	...
 83d:	00 00                	add    %al,(%rax)
 83f:	00 1c 00             	add    %bl,(%rax,%rax,1)
 842:	00 00                	add    %al,(%rax)
 844:	5c                   	pop    %rsp
 845:	00 00                	add    %al,(%rax)
 847:	00 02                	add    %al,(%rdx)
 849:	fe                   	(bad)  
 84a:	ff                   	(bad)  
 84b:	ff 32                	pushq  (%rdx)
 84d:	00 00                	add    %al,(%rax)
 84f:	00 00                	add    %al,(%rax)
 851:	41 0e                	rex.B (bad) 
 853:	10 86 02 43 0d 06    	adc    %al,0x60d4302(%rsi)
 859:	6d                   	insl   (%dx),%es:(%rdi)
 85a:	0c 07                	or     $0x7,%al
 85c:	08 00                	or     %al,(%rax)
 85e:	00 00                	add    %al,(%rax)
 860:	1c 00                	sbb    $0x0,%al
 862:	00 00                	add    %al,(%rax)
 864:	7c 00                	jl     866 <__GNU_EH_FRAME_HDR+0xfe>
 866:	00 00                	add    %al,(%rax)
 868:	14 fe                	adc    $0xfe,%al
 86a:	ff                   	(bad)  
 86b:	ff                   	(bad)  
 86c:	3c 00                	cmp    $0x0,%al
 86e:	00 00                	add    %al,(%rax)
 870:	00 41 0e             	add    %al,0xe(%rcx)
 873:	10 86 02 43 0d 06    	adc    %al,0x60d4302(%rsi)
 879:	77 0c                	ja     887 <__GNU_EH_FRAME_HDR+0x11f>
 87b:	07                   	(bad)  
 87c:	08 00                	or     %al,(%rax)
 87e:	00 00                	add    %al,(%rax)
 880:	1c 00                	sbb    $0x0,%al
 882:	00 00                	add    %al,(%rax)
 884:	9c                   	pushfq 
 885:	00 00                	add    %al,(%rax)
 887:	00 30                	add    %dh,(%rax)
 889:	fe                   	(bad)  
 88a:	ff                   	(bad)  
 88b:	ff 15 00 00 00 00    	callq  *0x0(%rip)        # 891 <__GNU_EH_FRAME_HDR+0x129>
 891:	41 0e                	rex.B (bad) 
 893:	10 86 02 43 0d 06    	adc    %al,0x60d4302(%rsi)
 899:	50                   	push   %rax
 89a:	0c 07                	or     $0x7,%al
 89c:	08 00                	or     %al,(%rax)
 89e:	00 00                	add    %al,(%rax)
 8a0:	44 00 00             	add    %r8b,(%rax)
 8a3:	00 bc 00 00 00 28 fe 	add    %bh,-0x1d80000(%rax,%rax,1)
 8aa:	ff                   	(bad)  
 8ab:	ff 65 00             	jmpq   *0x0(%rbp)
 8ae:	00 00                	add    %al,(%rax)
 8b0:	00 42 0e             	add    %al,0xe(%rdx)
 8b3:	10 8f 02 42 0e 18    	adc    %cl,0x180e4202(%rdi)
 8b9:	8e 03                	mov    (%rbx),%es
 8bb:	45 0e                	rex.RB (bad) 
 8bd:	20 8d 04 42 0e 28    	and    %cl,0x280e4204(%rbp)
 8c3:	8c 05 48 0e 30 86    	mov    %es,-0x79cff1b8(%rip)        # ffffffff86301711 <_end+0xffffffff861006f9>
 8c9:	06                   	(bad)  
 8ca:	48 0e                	rex.W (bad) 
 8cc:	38 83 07 4d 0e 40    	cmp    %al,0x400e4d07(%rbx)
 8d2:	72 0e                	jb     8e2 <__GNU_EH_FRAME_HDR+0x17a>
 8d4:	38 41 0e             	cmp    %al,0xe(%rcx)
 8d7:	30 41 0e             	xor    %al,0xe(%rcx)
 8da:	28 42 0e             	sub    %al,0xe(%rdx)
 8dd:	20 42 0e             	and    %al,0xe(%rdx)
 8e0:	18 42 0e             	sbb    %al,0xe(%rdx)
 8e3:	10 42 0e             	adc    %al,0xe(%rdx)
 8e6:	08 00                	or     %al,(%rax)
 8e8:	10 00                	adc    %al,(%rax)
 8ea:	00 00                	add    %al,(%rax)
 8ec:	04 01                	add    $0x1,%al
 8ee:	00 00                	add    %al,(%rax)
 8f0:	50                   	push   %rax
 8f1:	fe                   	(bad)  
 8f2:	ff                   	(bad)  
 8f3:	ff 02                	incl   (%rdx)
 8f5:	00 00                	add    %al,(%rax)
 8f7:	00 00                	add    %al,(%rax)
 8f9:	00 00                	add    %al,(%rax)
	...

00000000000008fc <__FRAME_END__>:
 8fc:	00 00                	add    %al,(%rax)
	...

Disassembly of section .init_array:

0000000000200db8 <__frame_dummy_init_array_entry>:
  200db8:	40 06                	rex (bad) 
  200dba:	00 00                	add    %al,(%rax)
  200dbc:	00 00                	add    %al,(%rax)
	...

Disassembly of section .fini_array:

0000000000200dc0 <__do_global_dtors_aux_fini_array_entry>:
  200dc0:	00 06                	add    %al,(%rsi)
  200dc2:	00 00                	add    %al,(%rax)
  200dc4:	00 00                	add    %al,(%rax)
	...

Disassembly of section .dynamic:

0000000000200dc8 <_DYNAMIC>:
  200dc8:	01 00                	add    %eax,(%rax)
  200dca:	00 00                	add    %al,(%rax)
  200dcc:	00 00                	add    %al,(%rax)
  200dce:	00 00                	add    %al,(%rax)
  200dd0:	01 00                	add    %eax,(%rax)
  200dd2:	00 00                	add    %al,(%rax)
  200dd4:	00 00                	add    %al,(%rax)
  200dd6:	00 00                	add    %al,(%rax)
  200dd8:	0c 00                	or     $0x0,%al
  200dda:	00 00                	add    %al,(%rax)
  200ddc:	00 00                	add    %al,(%rax)
  200dde:	00 00                	add    %al,(%rax)
  200de0:	f0 04 00             	lock add $0x0,%al
  200de3:	00 00                	add    %al,(%rax)
  200de5:	00 00                	add    %al,(%rax)
  200de7:	00 0d 00 00 00 00    	add    %cl,0x0(%rip)        # 200ded <_DYNAMIC+0x25>
  200ded:	00 00                	add    %al,(%rax)
  200def:	00 44 07 00          	add    %al,0x0(%rdi,%rax,1)
  200df3:	00 00                	add    %al,(%rax)
  200df5:	00 00                	add    %al,(%rax)
  200df7:	00 19                	add    %bl,(%rcx)
  200df9:	00 00                	add    %al,(%rax)
  200dfb:	00 00                	add    %al,(%rax)
  200dfd:	00 00                	add    %al,(%rax)
  200dff:	00 b8 0d 20 00 00    	add    %bh,0x200d(%rax)
  200e05:	00 00                	add    %al,(%rax)
  200e07:	00 1b                	add    %bl,(%rbx)
  200e09:	00 00                	add    %al,(%rax)
  200e0b:	00 00                	add    %al,(%rax)
  200e0d:	00 00                	add    %al,(%rax)
  200e0f:	00 08                	add    %cl,(%rax)
  200e11:	00 00                	add    %al,(%rax)
  200e13:	00 00                	add    %al,(%rax)
  200e15:	00 00                	add    %al,(%rax)
  200e17:	00 1a                	add    %bl,(%rdx)
  200e19:	00 00                	add    %al,(%rax)
  200e1b:	00 00                	add    %al,(%rax)
  200e1d:	00 00                	add    %al,(%rax)
  200e1f:	00 c0                	add    %al,%al
  200e21:	0d 20 00 00 00       	or     $0x20,%eax
  200e26:	00 00                	add    %al,(%rax)
  200e28:	1c 00                	sbb    $0x0,%al
  200e2a:	00 00                	add    %al,(%rax)
  200e2c:	00 00                	add    %al,(%rax)
  200e2e:	00 00                	add    %al,(%rax)
  200e30:	08 00                	or     %al,(%rax)
  200e32:	00 00                	add    %al,(%rax)
  200e34:	00 00                	add    %al,(%rax)
  200e36:	00 00                	add    %al,(%rax)
  200e38:	f5                   	cmc    
  200e39:	fe                   	(bad)  
  200e3a:	ff 6f 00             	ljmp   *0x0(%rdi)
  200e3d:	00 00                	add    %al,(%rax)
  200e3f:	00 98 02 00 00 00    	add    %bl,0x2(%rax)
  200e45:	00 00                	add    %al,(%rax)
  200e47:	00 05 00 00 00 00    	add    %al,0x0(%rip)        # 200e4d <_DYNAMIC+0x85>
  200e4d:	00 00                	add    %al,(%rax)
  200e4f:	00 60 03             	add    %ah,0x3(%rax)
  200e52:	00 00                	add    %al,(%rax)
  200e54:	00 00                	add    %al,(%rax)
  200e56:	00 00                	add    %al,(%rax)
  200e58:	06                   	(bad)  
  200e59:	00 00                	add    %al,(%rax)
  200e5b:	00 00                	add    %al,(%rax)
  200e5d:	00 00                	add    %al,(%rax)
  200e5f:	00 b8 02 00 00 00    	add    %bh,0x2(%rax)
  200e65:	00 00                	add    %al,(%rax)
  200e67:	00 0a                	add    %cl,(%rdx)
  200e69:	00 00                	add    %al,(%rax)
  200e6b:	00 00                	add    %al,(%rax)
  200e6d:	00 00                	add    %al,(%rax)
  200e6f:	00 84 00 00 00 00 00 	add    %al,0x0(%rax,%rax,1)
  200e76:	00 00                	add    %al,(%rax)
  200e78:	0b 00                	or     (%rax),%eax
  200e7a:	00 00                	add    %al,(%rax)
  200e7c:	00 00                	add    %al,(%rax)
  200e7e:	00 00                	add    %al,(%rax)
  200e80:	18 00                	sbb    %al,(%rax)
  200e82:	00 00                	add    %al,(%rax)
  200e84:	00 00                	add    %al,(%rax)
  200e86:	00 00                	add    %al,(%rax)
  200e88:	15 00 00 00 00       	adc    $0x0,%eax
	...
  200e95:	00 00                	add    %al,(%rax)
  200e97:	00 03                	add    %al,(%rbx)
  200e99:	00 00                	add    %al,(%rax)
  200e9b:	00 00                	add    %al,(%rax)
  200e9d:	00 00                	add    %al,(%rax)
  200e9f:	00 b8 0f 20 00 00    	add    %bh,0x200f(%rax)
  200ea5:	00 00                	add    %al,(%rax)
  200ea7:	00 02                	add    %al,(%rdx)
  200ea9:	00 00                	add    %al,(%rax)
  200eab:	00 00                	add    %al,(%rax)
  200ead:	00 00                	add    %al,(%rax)
  200eaf:	00 18                	add    %bl,(%rax)
  200eb1:	00 00                	add    %al,(%rax)
  200eb3:	00 00                	add    %al,(%rax)
  200eb5:	00 00                	add    %al,(%rax)
  200eb7:	00 14 00             	add    %dl,(%rax,%rax,1)
  200eba:	00 00                	add    %al,(%rax)
  200ebc:	00 00                	add    %al,(%rax)
  200ebe:	00 00                	add    %al,(%rax)
  200ec0:	07                   	(bad)  
  200ec1:	00 00                	add    %al,(%rax)
  200ec3:	00 00                	add    %al,(%rax)
  200ec5:	00 00                	add    %al,(%rax)
  200ec7:	00 17                	add    %dl,(%rdi)
  200ec9:	00 00                	add    %al,(%rax)
  200ecb:	00 00                	add    %al,(%rax)
  200ecd:	00 00                	add    %al,(%rax)
  200ecf:	00 d8                	add    %bl,%al
  200ed1:	04 00                	add    $0x0,%al
  200ed3:	00 00                	add    %al,(%rax)
  200ed5:	00 00                	add    %al,(%rax)
  200ed7:	00 07                	add    %al,(%rdi)
  200ed9:	00 00                	add    %al,(%rax)
  200edb:	00 00                	add    %al,(%rax)
  200edd:	00 00                	add    %al,(%rax)
  200edf:	00 18                	add    %bl,(%rax)
  200ee1:	04 00                	add    $0x0,%al
  200ee3:	00 00                	add    %al,(%rax)
  200ee5:	00 00                	add    %al,(%rax)
  200ee7:	00 08                	add    %cl,(%rax)
  200ee9:	00 00                	add    %al,(%rax)
  200eeb:	00 00                	add    %al,(%rax)
  200eed:	00 00                	add    %al,(%rax)
  200eef:	00 c0                	add    %al,%al
  200ef1:	00 00                	add    %al,(%rax)
  200ef3:	00 00                	add    %al,(%rax)
  200ef5:	00 00                	add    %al,(%rax)
  200ef7:	00 09                	add    %cl,(%rcx)
  200ef9:	00 00                	add    %al,(%rax)
  200efb:	00 00                	add    %al,(%rax)
  200efd:	00 00                	add    %al,(%rax)
  200eff:	00 18                	add    %bl,(%rax)
  200f01:	00 00                	add    %al,(%rax)
  200f03:	00 00                	add    %al,(%rax)
  200f05:	00 00                	add    %al,(%rax)
  200f07:	00 1e                	add    %bl,(%rsi)
  200f09:	00 00                	add    %al,(%rax)
  200f0b:	00 00                	add    %al,(%rax)
  200f0d:	00 00                	add    %al,(%rax)
  200f0f:	00 08                	add    %cl,(%rax)
  200f11:	00 00                	add    %al,(%rax)
  200f13:	00 00                	add    %al,(%rax)
  200f15:	00 00                	add    %al,(%rax)
  200f17:	00 fb                	add    %bh,%bl
  200f19:	ff                   	(bad)  
  200f1a:	ff 6f 00             	ljmp   *0x0(%rdi)
  200f1d:	00 00                	add    %al,(%rax)
  200f1f:	00 01                	add    %al,(%rcx)
  200f21:	00 00                	add    %al,(%rax)
  200f23:	08 00                	or     %al,(%rax)
  200f25:	00 00                	add    %al,(%rax)
  200f27:	00 fe                	add    %bh,%dh
  200f29:	ff                   	(bad)  
  200f2a:	ff 6f 00             	ljmp   *0x0(%rdi)
  200f2d:	00 00                	add    %al,(%rax)
  200f2f:	00 f8                	add    %bh,%al
  200f31:	03 00                	add    (%rax),%eax
  200f33:	00 00                	add    %al,(%rax)
  200f35:	00 00                	add    %al,(%rax)
  200f37:	00 ff                	add    %bh,%bh
  200f39:	ff                   	(bad)  
  200f3a:	ff 6f 00             	ljmp   *0x0(%rdi)
  200f3d:	00 00                	add    %al,(%rax)
  200f3f:	00 01                	add    %al,(%rcx)
  200f41:	00 00                	add    %al,(%rax)
  200f43:	00 00                	add    %al,(%rax)
  200f45:	00 00                	add    %al,(%rax)
  200f47:	00 f0                	add    %dh,%al
  200f49:	ff                   	(bad)  
  200f4a:	ff 6f 00             	ljmp   *0x0(%rdi)
  200f4d:	00 00                	add    %al,(%rax)
  200f4f:	00 e4                	add    %ah,%ah
  200f51:	03 00                	add    (%rax),%eax
  200f53:	00 00                	add    %al,(%rax)
  200f55:	00 00                	add    %al,(%rax)
  200f57:	00 f9                	add    %bh,%cl
  200f59:	ff                   	(bad)  
  200f5a:	ff 6f 00             	ljmp   *0x0(%rdi)
  200f5d:	00 00                	add    %al,(%rax)
  200f5f:	00 03                	add    %al,(%rbx)
	...

Disassembly of section .got:

0000000000200fb8 <_GLOBAL_OFFSET_TABLE_>:
  200fb8:	c8 0d 20 00          	enterq $0x200d,$0x0
	...
  200fd0:	26 05 00 00 00 00    	es add $0x0,%eax
	...

Disassembly of section .data:

0000000000201000 <__data_start>:
	...

0000000000201008 <__dso_handle>:
  201008:	08 10                	or     %dl,(%rax)
  20100a:	20 00                	and    %al,(%rax)
  20100c:	00 00                	add    %al,(%rax)
	...

Disassembly of section .bss:

0000000000201010 <__bss_start>:
	...

Disassembly of section .comment:

0000000000000000 <.comment>:
   0:	47                   	rex.RXB
   1:	43                   	rex.XB
   2:	43 3a 20             	rex.XB cmp (%r8),%spl
   5:	28 55 62             	sub    %dl,0x62(%rbp)
   8:	75 6e                	jne    78 <_init-0x478>
   a:	74 75                	je     81 <_init-0x46f>
   c:	20 37                	and    %dh,(%rdi)
   e:	2e 35 2e 30 2d 33    	cs xor $0x332d302e,%eax
  14:	75 62                	jne    78 <_init-0x478>
  16:	75 6e                	jne    86 <_init-0x46a>
  18:	74 75                	je     8f <_init-0x461>
  1a:	31 7e 31             	xor    %edi,0x31(%rsi)
  1d:	38 2e                	cmp    %ch,(%rsi)
  1f:	30 34 29             	xor    %dh,(%rcx,%rbp,1)
  22:	20 37                	and    %dh,(%rdi)
  24:	2e                   	cs
  25:	35                   	.byte 0x35
  26:	2e 30 00             	xor    %al,%cs:(%rax)
