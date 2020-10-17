all:img
boot:
	nasm bootloader.nas -o bootloader
img:boot
	dd if=bootloader of=helloos.img count=1 bs=512
	dd if=/dev/zero of=helloos.img bs=512 seek=1 skip=1 count=2879
run:
	qemu-system-x86_64 -drive file=helloos.img,if=floppy
clean:
	rm bootloader helloos.img
