# -.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.

# File Name : Makefile

# Purpose :  build the kernel

# Creation Date : 20-10-2013

# Created By :  Notsgnik

#._._._._._._._._._._._._._._._._._._._._.*/

NAME="kernel"
INCLUDES=./includes
ASM=./asms
SRC=./srcs
LINKS=./links
KOUTPUT=kernel.bin
KOUTPUT64=kernel64.bin
KCFLAGS= -Wextra -Werror -Wall -O -fstrength-reduce -fomit-frame-pointer -finline-functions -nostdinc -fno-builtin -D_FORTIFY_SOURCE=2 
BCFLAGS=-Os -ffreestanding -Wall -Werror -Wextra

all:$(NAME)

$(NAME): 32

32: start32 nasm32  scrn32 gdt32 idt32 isrs32 irq32 timer32 kb32 main32 ld32 done

64: start64 nasm64  scrn64 gdt64 idt64 isrs64 irq64 timer64 kb64 main64 ld64 done


start32:
	@echo "Assembling, compiling, and linking kernel in 32"
nasm32:
	nasm -f elf32 -o start.o $(ASM)/start.asm
scrn32:
	gcc  -m32 $(KCFLAGS) -I $(INCLUDES)  $(SRC)/scrn.c -c -o scrn.o 
gdt32:
	gcc  -m32 $(KCFLAGS) -I $(INCLUDES)  $(SRC)/gdt.c -c -o gdt.o 
idt32:
	gcc  -m32 $(KCFLAGS) -I $(INCLUDES)  $(SRC)/idt.c -c -o idt.o 
isrs32:
	gcc  -m32 $(KCFLAGS) -I $(INCLUDES)  $(SRC)/isrs.c -c -o isrs.o 
irq32:
	gcc  -m32 $(KCFLAGS) -I $(INCLUDES)  $(SRC)/irq.c -c -o irq.o
timer32:
	gcc  -m32 $(KCFLAGS) -I $(INCLUDES)  $(SRC)/timer.c -c -o timer.o
kb32:
	gcc  -m32 $(KCFLAGS) -I $(INCLUDES)  $(SRC)/kb.c -c -o kb.o
main32:
	gcc  -m32 $(KCFLAGS) -I $(INCLUDES)  $(SRC)/main.c -c -o main.o 
ld32:
	ld -melf_i386 -T $(LINKS)/kernel_link.ld -o $(KOUTPUT) start.o scrn.o gdt.o idt.o isrs.o irq.o timer.o kb.o main.o


start64:
	@echo "Assembling, compiling, and linking kernel in 64"
nasm64:
	nasm -f elf64 -o start.o $(ASM)/start_64.asm
scrn64:
	gcc  -m64 $(KCFLAGS) -I $(INCLUDES)  $(SRC)/scrn.c -c -o scrn.o 
gdt64:
	gcc  -m64 $(KCFLAGS) -I $(INCLUDES)  $(SRC)/gdt.c -c -o gdt.o 
idt64:
	gcc  -m64 $(KCFLAGS) -I $(INCLUDES)  $(SRC)/idt.c -c -o idt.o 
isrs64:
	gcc  -m64 $(KCFLAGS) -I $(INCLUDES)  $(SRC)/isrs.c -c -o isrs.o 
irq64:
	gcc  -m64 $(KCFLAGS) -I $(INCLUDES)  $(SRC)/irq.c -c -o irq.o
timer64:
	gcc  -m64 $(KCFLAGS) -I $(INCLUDES)  $(SRC)/timer.c -c -o timer.o
kb64:
	gcc  -m64 $(KCFLAGS) -I $(INCLUDES)  $(SRC)/kb.c -c -o kb.o
main64:
	gcc  -m64 $(KCFLAGS) -I $(INCLUDES)  $(SRC)/main.c -c -o main.o 
ld64:
	ld -melf_x86_64 -T $(LINKS)/kernel_link.ld -o $(KOUTPUT64) start.o scrn.o gdt.o idt.o isrs.o irq.o timer.o main.o
	

done:
	@echo "Done!"

build_boot_asm: as_boot ld_boot_asm create_boot_hd
 
build_boot: gcc_boot ld_boot obj_boot create_boot_hd 

gcc_boot:
	gcc -c -m32 $(BCFLAGS) $(SRC)/boot_loader.c -o cboot_loader.o
ld_boot:
	ld -melf_i386 -static -T $(LINKS)/boot_link.ld -nostdlib --nmagic -o cboot_loader.elf cboot_loader.o
obj_boot:
	objcopy -O binary cboot_loader.elf boot_loader.bin

as_boot:
	as $(ASM)/boot_loader.asm -o aboot_loader.o
ld_boot_asm:
	ld -Ttext 0x7c00 --oformat=binary aboot_loader.o -o boot_loader.bin
create_boot_hd:
	echo "drive c: file=\"`pwd`/hdd.img\" partition=1" > ~/.mtoolsrc
	dd if=/dev/zero of=hdd.img bs=512 count=088704
	mpartition -I c:
	mpartition -c -t 88 -h 16 -s 63 c:
	mformat c:
	dd if=boot_loader.bin of=hdd.img

clean_boot:
	rm cboot_loader.o
	rm cboot_loader.elf
	rm boot_loader.bin
clean_bootf: clean_boot
	rm hdd.img
clean_bootfa: clean_boota
	rm hdd.img
clean_boota:
	rm aboot_loader.o
	rm boot_loader.bin
	
remake_boot: clean_bootf build_boot

boot_rebuild_and_run: remake_boot
	qemu-system-x86_64 -hda hdd.img

clean:
	rm start.o
	rm main.o
	rm scrn.o
	rm  gdt.o
	rm idt.o
	rm isrs.o
	rm irq.o
	rm timer.o
	rm kb.o

fclean: clean
	rm $(KOUTPUT)
