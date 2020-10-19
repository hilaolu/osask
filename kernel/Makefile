src=osask.S
obj=osask.o
elf=osask.elf
boot=osask.sys
asm=osask.asm
address=

$(boot):$(src)
	gcc -c $(src) -m32 -o $(obj)
	ld -m elf_i386 $(obj) -e start -Ttext $(address) -o $(elf)
	objcopy -S -O binary -j .text $(elf)  $(boot)
	objdump -S $(elf) > $(asm)

clean:
	rm $(obj) $(elf) $(asm)
