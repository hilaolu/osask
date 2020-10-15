all:img
img:
	nasm helloos.nas -o helloos.img
run:
	qemu-system-x86_64 -fda helloos.img
clean:
	rm helloos.img
