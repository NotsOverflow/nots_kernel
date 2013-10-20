# -.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.

# File Name : Makefile

# Purpose :  build the kernel

# Creation Date : 20-10-2013

# Created By :  Notsgnik

#._._._._._._._._._._._._._._._._._._._._.*/

NAME="kernel"
INCLUDES="./includes"
ASM="./asms/start.asm"
CFILES="main.c"
KOUTPUT="kernel.bin"


all:$(NAME)

$(NAME):
	@echo "Assembling, compiling, and linking kernel"
	nasm -f aout -o start.o $(ASM)
	ld -melf_i386 -T ./links/link.ld -o $(KOUTPUT) start.o
	@echo "Done!"

clean:
	rm start.o

fclean: clean
	rm $(KOUTPUT)
