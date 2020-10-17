;bootloader
	org 0x7c00;jump 0x7c00
	jmp entry
	db 0x90
	db "bootload";	8bytes
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
	db "bootloader "
	db "FAT12   "
    resb 18

entry:
	;entry
	mov ax,0
    mov ss,ax
    mov sp,0x7c00
    mov ds,ax

    mov ax,0x0820
    mov es,ax
    mov ch,0
    mov dh,0
    mov cl,2

    mov ah,0x02
    mov al,1
    mov bx,0
    mov dl,0x00
    int 0x13
    jc error

error:
    mov si,msg

putloop:
    ;interrupt
	mov al, [si]
	add si, 1
	cmp al, 0
	je fin
	mov ah, 0x0e
	mov bx, 15
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
    db "disk load error!!!"
	db 0x0a
	db 0

    resb 0x1fe-($-$$)

    db 0x55,0xaa
