# -.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.

# File Name : Makefile

# Purpose :  build the kernel

# Creation Date : 20-10-2013

# Created By :  Notsgnik

#._._._._._._._._._._._._._._._._._._._._.*/

NAME="kernel"
INCLUDES=./includes
ASM=./asms/start.asm
SRC=./srcs
KOUTPUT=kernel.bin
KOUTPUT64=kernel64.bin
CFLAGS= -Wextra  -Wall -O -fstrength-reduce -fomit-frame-pointer -finline-functions -nostdinc -fno-builtin -D_FORTIFY_SOURCE=2 

all:$(NAME)

$(NAME): 32

32: start32 nasm32  scrn32 gdt32 idt32 isrs32 irq32 timer32 kb32 main32 ld32 done

64: start64 nasm64  scrn64 gdt64 idt64 isrs64 irq64 timer64 kb32 main64 ld64 done


start32:
	@echo "Assembling, compiling, and linking kernel in 32"
nasm32:
	nasm -f elf32 -o start.o $(ASM)
scrn32:
	gcc  -m32 $(CFLAGS) -I $(INCLUDES)  $(SRC)/scrn.c -c -o scrn.o 
gdt32:
	gcc  -m32 $(CFLAGS) -I $(INCLUDES)  $(SRC)/gdt.c -c -o gdt.o 
idt32:
	gcc  -m32 $(CFLAGS) -I $(INCLUDES)  $(SRC)/idt.c -c -o idt.o 
isrs32:
	gcc  -m32 $(CFLAGS) -I $(INCLUDES)  $(SRC)/isrs.c -c -o isrs.o 
irq32:
	gcc  -m32 $(CFLAGS) -I $(INCLUDES)  $(SRC)/irq.c -c -o irq.o
timer32:
	gcc  -m32 $(CFLAGS) -I $(INCLUDES)  $(SRC)/timer.c -c -o timer.o
kb32:
	gcc  -m32 $(CFLAGS) -I $(INCLUDES)  $(SRC)/kb.c -c -o kb.o
main32:
	gcc  -m32 $(CFLAGS) -I $(INCLUDES)  $(SRC)/main.c -c -o main.o 
ld32:
	ld -melf_i386 -T ./links/link.ld -o $(KOUTPUT) start.o scrn.o gdt.o idt.o isrs.o irq.o timer.o kb.o main.o


start64:
	@echo "Assembling, compiling, and linking kernel in 64"
nasm64:
	nasm -f elf64 -o start.o $(ASM)
scrn64:
	gcc  -m64 $(CFLAGS) -I $(INCLUDES)  $(SRC)/scrn.c -c -o scrn.o 
gdt64:
	gcc  -m64 $(CFLAGS) -I $(INCLUDES)  $(SRC)/gdt.c -c -o gdt.o 
idt64:
	gcc  -m64 $(CFLAGS) -I $(INCLUDES)  $(SRC)/idt.c -c -o idt.o 
isrs64:
	gcc  -m64 $(CFLAGS) -I $(INCLUDES)  $(SRC)/isrs.c -c -o isrs.o 
irq64:
	gcc  -m64 $(CFLAGS) -I $(INCLUDES)  $(SRC)/irq.c -c -o irq.o
timer64:
	gcc  -m64 $(CFLAGS) -I $(INCLUDES)  $(SRC)/timer.c -c -o timer.o
kb64:
	gcc  -m64 $(CFLAGS) -I $(INCLUDES)  $(SRC)/kb.c -c -o kb.o
main64:
	gcc  -m64 $(CFLAGS) -I $(INCLUDES)  $(SRC)/main.c -c -o main.o 
ld64:
	ld -melf_x86_64 -T ./links/link.ld -o $(KOUTPUT64) start.o scrn.o gdt.o idt.o isrs.o irq.o timer.o main.o
	

done:
	@echo "Done!"

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
