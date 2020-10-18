.global start
.code16
start:
    jmp entry /*just jmp*/
	.byte 0x00 /*8bit*/
    .ascii "bootload"
    .word 512 /*2 byte*/
    .byte 1 /*data start with .*/
    .short 1
    .byte 2
    .word 224
    .word 2880
    .byte 0xf0
    .word 9
    .word 18
    .word 2
    .long 0
    .long 2880 /*4byte and short is 2byte* short is equal to word!!!*/
    .byte 0,0,0x29
    .long 0xffffffff
    .ascii "osaskdisk  "/*declare a string*/
    .ascii "fat12   "
    .fill 18 /*resb = fill??*/

entry:
	mov $0,%ax /*compared to intel syntax,operand and operator is reversed*/
    mov %ax,%ds
    mov %ax,%es /*direct operator -> $*/
    mov %ax,%ss /*register -> %*/
    mov $0x7c00,%sp

    mov $msg,%si /*label use $*/
    call putloop


putloop:
    movb (%si),%al
    add $1,%si
    cmp $0,%al
    je fin
    movb $0x0e,%ah
    movw $15,%bx
    int $0x10
    jmp putloop
fin:
    hlt
    ret

msg:
    .asciz "\r\nbootloader is running"
    .asciz "\r\nhihi"


.org 510
.word 0xaa55
