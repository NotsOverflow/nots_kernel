/*generate 16-bit code*/
__asm__(".code16\n");
/*jump boot code entry*/
__asm__("jmpl $0x0000, $main\n");

void nf_putstr(char *str) {
	register int index;

	index = 0;
     while(str[index] != '\0') {
     	__asm__ __volatile__("mov %0, %%AL;" ::"g" (str[index]));
		__asm__ __volatile__("mov $0X0E, %AH;");
		__asm__ __volatile__("int $0x10");
		index = index + 1;
     }
}

int main() {
	char *str = "This is a boot loader booting...\0";
 
	nf_putstr(str);
	return (0);
} 
