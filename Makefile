src=bootloader.s
obj=bootloader.o
elf=bootloader.elf
bootloader=bootloader.img
asm=bootloader.asm
kernel=osask.sys

all:$(bootloader)

$(bootloader):$(src)
	gcc -c $(src) -m32 -o $(obj)
	ld -m elf_i386 $(obj) -e start -Ttext 0x7c00 -o $(elf)
	objcopy -S -O binary -j .text $(elf) $(bootloader)
	objdump -S $(elf) > $(asm)
	cd kernel;make address=0x0ff0;mv $(kernel) ../

copy:$(bootloader)
	dd if=/dev/zero of=$(bootloader) seek=2 count=2878 >> /dev/zero
	sudo mkdir -p /tmp/img
	sudo mount -o loop   $(bootloader)  /tmp/img
	sleep 0.5
	sudo cp $(kernel) /tmp/img
	sleep 0.5
	sudo umount /tmp/img

run:$(asm)
	qemu-system-x86_64 -fda $(bootloader)

clean:
	cd kernel;make clean
	rm $(obj) $(elf) $(bootloader) $(asm) $(kernel)
