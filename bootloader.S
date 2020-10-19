
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
    mov $0,%ax
    mov %ax,%ss
    mov $0x7c00,%sp
    mov %ax,%ds

    mov $0x0820,%ax
    mov %ax,%es
    mov $0,%ch
    mov $0,%dh
    mov $2,%cl

readloop:
    mov $0,%si

retry:
    mov $0x02,%ah
    mov $1,%al
    mov $0,%bx
    mov $0x00,%dl
    int $0x13
    jnc next
    add $1,%si
    cmp $5,%si
    jae error
    mov $0x00,%ah
    mov $0x00,%dl
    int $0x13
    jmp retry

next:
    mov %es,%ax
    add $0x0020,%ax
    mov %ax,%es
    add $1,%cl
    cmp $18,%cl
    jbe readloop
    mov $1,%cl
    add $1,%dh
    cmp $2,%dh
    jb readloop
    mov $0,%dh
    add $1,%ch
    cmp $10,%ch
    jb readloop
    mov %ch,(0x0ff0)
    jmp 0xc400

error:
    mov $msg,%si
    call putloop

putloop:
    mov (%si),%al
    add $1,%si
    cmp $0,%al
    je fin
    mov $0x0e,%ah
    mov $15,%bx
    int $0x10
    jmp putloop

fin:
    hlt
    jmp fin

msg:
    .asciz "load error"


.org 510
.word 0xaa55
