NAME="kernel"

all:$(NAME)

$(NAME):
	@echo "Assembling, compiling, and linking kernel"
	nasm -f aout -o start.o start.asm
	ld -melf_i386 -T link.ld -o kernel.bin start.o
	@echo "Done!"

clean:
	rm start.o

fclean: clean
	rm kernek.bin
