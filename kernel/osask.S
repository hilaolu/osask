#define cyls 0x0ff0
#define leds 0x0ff1
#define vmod 0x0ff2
#define scrnx 0x0ff4
#define scrny 0x0ff6
#define vram 0x0ff8

    mov $0x13,%al
    mov $0x00,%ah
    int $0x10
    movb $8,(vmod)
    movw $320,(scrnx)
    movw $200,(scrny)
    movl $0x000a0000,(vram)

    mov $0x02,%ah
    int $0x16
    mov %al,(leds)
fin:
    hlt
    jmp fin
