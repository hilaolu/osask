all:img
boot:
	nasm bootloader.nas -o bootloader
img:boot osask
	dd if=bootloader of=osask.img count=1 bs=512
	dd if=/dev/zero of=osask.img bs=512 seek=1 skip=1 count=2879
osask:
	nasm osask.nas -o osask.sys
run:
	qemu-system-x86_64 -drive file=osask.img,if=floppy
clean:
	rm bootloader *.img *.sys
copy:
	sudo mkdir -p /tmp/floppy
	sudo mount -o loop osask.img /tmp/floppy -o fat=12
	sleep 1
	sudo cp osask.sys /tmp/floppy
	sleep 1
	sudo umount /tmp/floppy
