
bootloader.elf:     file format elf32-i386


Disassembly of section .text:

00007c00 <start>:
    7c00:	eb 4e                	jmp    7c50 <entry>
    7c02:	00 62 6f             	add    %ah,0x6f(%edx)
    7c05:	6f                   	outsl  %ds:(%esi),(%dx)
    7c06:	74 6c                	je     7c74 <retry+0xc>
    7c08:	6f                   	outsl  %ds:(%esi),(%dx)
    7c09:	61                   	popa   
    7c0a:	64 00 02             	add    %al,%fs:(%edx)
    7c0d:	01 01                	add    %eax,(%ecx)
    7c0f:	00 02                	add    %al,(%edx)
    7c11:	e0 00                	loopne 7c13 <start+0x13>
    7c13:	40                   	inc    %eax
    7c14:	0b f0                	or     %eax,%esi
    7c16:	09 00                	or     %eax,(%eax)
    7c18:	12 00                	adc    (%eax),%al
    7c1a:	02 00                	add    (%eax),%al
    7c1c:	00 00                	add    %al,(%eax)
    7c1e:	00 00                	add    %al,(%eax)
    7c20:	40                   	inc    %eax
    7c21:	0b 00                	or     (%eax),%eax
    7c23:	00 00                	add    %al,(%eax)
    7c25:	00 29                	add    %ch,(%ecx)
    7c27:	ff                   	(bad)  
    7c28:	ff                   	(bad)  
    7c29:	ff                   	(bad)  
    7c2a:	ff 6f 73             	ljmp   *0x73(%edi)
    7c2d:	61                   	popa   
    7c2e:	73 6b                	jae    7c9b <next+0x16>
    7c30:	64 69 73 6b 20 20 66 	imul   $0x61662020,%fs:0x6b(%ebx),%esi
    7c37:	61 
    7c38:	74 31                	je     7c6b <retry+0x3>
    7c3a:	32 20                	xor    (%eax),%ah
    7c3c:	20 20                	and    %ah,(%eax)
	...

00007c50 <entry>:
    7c50:	b8 00 00 8e d0       	mov    $0xd08e0000,%eax
    7c55:	bc 00 7c 8e d8       	mov    $0xd88e7c00,%esp
    7c5a:	b8 20 08 8e c0       	mov    $0xc08e0820,%eax
    7c5f:	b5 00                	mov    $0x0,%ch
    7c61:	b6 00                	mov    $0x0,%dh
    7c63:	b1 02                	mov    $0x2,%cl

00007c65 <readloop>:
    7c65:	be                   	.byte 0xbe
	...

00007c68 <retry>:
    7c68:	b4 02                	mov    $0x2,%ah
    7c6a:	b0 01                	mov    $0x1,%al
    7c6c:	bb 00 00 b2 00       	mov    $0xb20000,%ebx
    7c71:	cd 13                	int    $0x13
    7c73:	73 10                	jae    7c85 <next>
    7c75:	83 c6 01             	add    $0x1,%esi
    7c78:	83 fe 05             	cmp    $0x5,%esi
    7c7b:	73 2e                	jae    7cab <error>
    7c7d:	b4 00                	mov    $0x0,%ah
    7c7f:	b2 00                	mov    $0x0,%dl
    7c81:	cd 13                	int    $0x13
    7c83:	eb e3                	jmp    7c68 <retry>

00007c85 <next>:
    7c85:	8c c0                	mov    %es,%eax
    7c87:	83 c0 20             	add    $0x20,%eax
    7c8a:	8e c0                	mov    %eax,%es
    7c8c:	80 c1 01             	add    $0x1,%cl
    7c8f:	80 f9 12             	cmp    $0x12,%cl
    7c92:	76 d1                	jbe    7c65 <readloop>
    7c94:	b1 01                	mov    $0x1,%cl
    7c96:	80 c6 01             	add    $0x1,%dh
    7c99:	80 fe 02             	cmp    $0x2,%dh
    7c9c:	72 c7                	jb     7c65 <readloop>
    7c9e:	b6 00                	mov    $0x0,%dh
    7ca0:	80 c5 01             	add    $0x1,%ch
    7ca3:	80 fd 0a             	cmp    $0xa,%ch
    7ca6:	72 bd                	jb     7c65 <readloop>
    7ca8:	e9                   	.byte 0xe9
    7ca9:	55                   	push   %ebp
    7caa:	47                   	inc    %edi

00007cab <error>:
    7cab:	be c6 7c e8 00       	mov    $0xe87cc6,%esi
	...

00007cb1 <putloop>:
    7cb1:	8a 04 83             	mov    (%ebx,%eax,4),%al
    7cb4:	c6 01 3c             	movb   $0x3c,(%ecx)
    7cb7:	00 74 09 b4          	add    %dh,-0x4c(%ecx,%ecx,1)
    7cbb:	0e                   	push   %cs
    7cbc:	bb 0f 00 cd 10       	mov    $0x10cd000f,%ebx
    7cc1:	eb ee                	jmp    7cb1 <putloop>

00007cc3 <fin>:
    7cc3:	f4                   	hlt    
    7cc4:	eb fd                	jmp    7cc3 <fin>

00007cc6 <msg>:
    7cc6:	6c                   	insb   (%dx),%es:(%edi)
    7cc7:	6f                   	outsl  %ds:(%esi),(%dx)
    7cc8:	61                   	popa   
    7cc9:	64 20 65 72          	and    %ah,%fs:0x72(%ebp)
    7ccd:	72 6f                	jb     7d3e <msg+0x78>
    7ccf:	72 00                	jb     7cd1 <msg+0xb>
	...
    7dfd:	00 55 aa             	add    %dl,-0x56(%ebp)
