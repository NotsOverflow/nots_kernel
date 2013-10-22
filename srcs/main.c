/* -.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.

* File Name : main.c

* Purpose :  from the kernel

* Creation Date : 20-10-2013

* Created By :  Notsgnik

_._._._._._._._._._._._._._._._._._._._._.*/

#include "system.h"

/* You will need to code these up yourself!  */
unsigned char *nf_memcpy(unsigned char *dest, const unsigned char *src, int count)
{
	register int index;
	
	if((int)sizeof(dest) <= count)
	{
		index = 0;
		while (index <= count)
		{
			dest[index] = src[index];
			index = index + 1;
		}
    }
    return (dest);
}

unsigned char *nf_memset(unsigned char *dest, unsigned char val, int count)
{
	register int index;
	
	if((int)sizeof(dest) <= count)
	{
		index = 0;
		while (index < count)
		{
			dest[index] = val;
			index = index + 1;
    	}
    }
    return (dest);
}

unsigned short *nf_memsetw(unsigned short *dest, unsigned short val, int count)
{
	register int index;
	
	if((int)sizeof(dest) <= count)
	{
		index = 0;
		while (index < count)
		{
			dest[index] = val;
			index = index + 1;
    	}
    }
    return (dest);
}

int nf_strlen(const char *str)
{
    register int index;
    
    index = 0;
    while (str[index] != 0)
    	index = index + 1;
    return index;
}

/* We will use this later on for reading from the I/O ports to get data
*  from devices such as the keyboard. We are using what is called
*  'inline assembly' in these routines to actually do the work */
unsigned char nf_inportb (unsigned short _port)
{
    unsigned char rv;
    __asm__ __volatile__ ("inb %1, %0" : "=a" (rv) : "dN" (_port));
    return rv;
}

/* We will use this to write to I/O ports to send bytes to devices. This
*  will be used in the next tutorial for changing the textmode cursor
*  position. Again, we use some inline assembly for the stuff that simply
*  cannot be done in C */
void nf_outportb (unsigned short _port, unsigned char _data)
{
    __asm__ __volatile__ ("outb %1, %0" : : "dN" (_port), "a" (_data));
}

/* This is a very simple main() function. All it does is sit in an
*  infinite loop. This will be like our 'idle' loop */
int nf_main()
{
	nf_gdt_install();
	nf_idt_install();
	nf_isrs_install();
	nf_irq_install();
	__asm__ __volatile__ ("sti");
	nf_timer_install();
	nf_keyboard_install();
    nf_init_video();
    nf_puts((unsigned char *)"Hello World!\nFirst Kernel here! :\n");

    /* ...and leave this loop in. There is an endless loop in
    *  'start.asm' also, if you accidentally delete this next line */
    for (;;);
    
    return (0);
}
