src=bootloader.s
obj=bootloader.o
elf=bootloader.elf
bootloader=bootloader.out
asm=bootloader.asm

all:$(bootloader)

$(bootloader):$(src)
	gcc -c $(src) -m32 -o $(obj)
	ld -m elf_i386 $(obj) -e start -Ttext 0x7c00 -o $(elf)
	objcopy -S -O binary -j .text $(elf) $(bootloader)
	objdump -S $(elf) > $(asm)

run:$(asm)
	qemu-system-x86_64 -fda $(bootloader)

clean:
	rm $(obj) $(elf) $(bootloader) $(asm)
