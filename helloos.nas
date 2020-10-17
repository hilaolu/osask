;hello.nas
	org 0x7c00;jump 0x7c00

fat12:
	;fat12
	jmp entry
	db 0x90
	db "chris_zz";	8bytes
	dw 512
	db 1
	dw 1
	db 2
	dw 224
	dw 2880
	db 0xf0
	dw 9
	dw 18
	dw 2
	dd 0
	dd 2880
	db 0,0,0x29
	dd 0xffffffff
	db "My First OS"
	db "FAT12   "

entry:
	;entry
	mov ax, 0
	mov ss, ax
	mov ds, ax
	mov es, ax

	mov sp, 0x7c00

	mov si, msg

putloop:
    ;interrupt
	mov al, [si]
	add si, 1
	cmp al, 0
	je fin
	mov ah, 0x0e
	mov bx, 10
	int 0x10
	jmp putloop

fin:
	hlt
	jmp fin

msg:
	db 0x0a, 0x0a;define
	db "phyzait lu"
    db 0x0a
    db 0x0d
    db "harbin institute of technology"
	db 0x0a
	db 0x0d
	db 0

endpart:
	times 510-($-$$) db 0
	db 0x55, 0xaa
