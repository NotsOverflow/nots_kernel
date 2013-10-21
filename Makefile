# -.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.

# File Name : Makefile

# Purpose :  build the kernel

# Creation Date : 20-10-2013

# Created By :  Notsgnik

#._._._._._._._._._._._._._._._._._._._._.*/

NAME="kernel"
INCLUDES=./includes
ASM=./asms/start.asm
C1=./srcs/main.c
C2=./srcs/scrn.c
KOUTPUT=kernel.bin
KOUTPUT64=kernel64.bin
CFLAGS= -Wextra -Werror -Wall -O -fstrength-reduce -fomit-frame-pointer -finline-functions -nostdinc -fno-builtin -D_FORTIFY_SOURCE=2 

all:$(NAME)

$(NAME):
	@echo "Assembling, compiling, and linking kernel"
	nasm -f elf32 -o start.o $(ASM)
	gcc  -m32 $(CFLAGS) -I $(INCLUDES)  $(C2) -c -o scrn.o 
	gcc  -m32 $(CFLAGS) -I $(INCLUDES)  $(C1) -c -o main.o 
	ld -melf_i386 -T ./links/link.ld -o $(KOUTPUT) start.o scrn.o main.o
	@echo "Done!"

64:
	@echo "Assembling, compiling, and linking kernel"
	nasm -f elf64 -o start.o ./asms/start_64.asm
	gcc  -m64 $(CFLAGS) -I $(INCLUDES)  $(C2) -c -o scrn.o 
	gcc  -m64 $(CFLAGS) -I $(INCLUDES)  $(C1) -c -o main.o 
	ld -melf_x86_64 -T ./links/link.ld -o $(KOUTPUT64) start.o scrn.o main.o
	@echo "Done!"

clean:
	rm start.o
	rm main.o
	rm scrn.o

fclean: clean
	rm $(KOUTPUT)
