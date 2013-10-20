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
CFLAGS=-Wextra -Werror -Wall -O -fstrength-reduce -fomit-frame-pointer -finline-functions -nostdinc -fno-builtin -D_FORTIFY_SOURCE=1 

all:$(NAME)

$(NAME):
	@echo "Assembling, compiling, and linking kernel"
	nasm -f elf64 -o start.o $(ASM)
	gcc  $(CFLAGS) -I $(INCLUDES)  $(C2) -c -o scrn.o 
	gcc  $(CFLAGS) -I $(INCLUDES)  $(C1) -c -o main.o 
	ld -T ./links/link.ld -o $(KOUTPUT) start.o scrn.o main.o
	@echo "Done!"

deb:
	@echo "Assembling, compiling, and linking kernel"
	nasm -f elf64 aout -o start.o $(ASM)
	cc  $(CFLAGS) -I$(INCLUDES)  $(C2) -c -o scrn.o 
	cc $(CFLAGS) -I$(INCLUDES)  $(C1) -c -o main.o 
	ld  -T ./links/link.ld -o $(KOUTPUT) start.o scrn.o main.o
	@echo "Done!"

clean:
	rm start.o
	rm main.o
	rm scrn.o

fclean: clean
	rm $(KOUTPUT)
