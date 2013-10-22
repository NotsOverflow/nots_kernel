/* -.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.

* File Name : main.c

* Purpose :  from the kernel

* Creation Date : 20-10-2013

* Created By :  Notsgnik

_._._._._._._._._._._._._._._._._._._._._.*/

#ifndef __SYSTEM_H__
#define __SYSTEM_H__

int csr_x;
int csr_y;
unsigned long nf_timer_ticks;
/* This defines what the stack looks like after an ISR was running */
struct regs
{
    unsigned int gs, fs, es, ds;      /* pushed the segs last */
    unsigned int edi, esi, ebp, esp, ebx, edx, ecx, eax;  /* pushed by 'pusha' */
    unsigned int int_no, err_code;    /* our 'push byte #' and ecodes do this */
    unsigned int eip, cs, eflags, useresp, ss;   /* pushed by the processor automatically */ 
};

void nf_fault_handler(struct regs *r);
void nf_isrs_install();

extern unsigned char *nf_memcpy(unsigned char *dest, const unsigned char *src, int count);
extern unsigned char *nf_memset(unsigned char *dest, unsigned char val, int count);
extern unsigned short *nf_memsetw(unsigned short *dest, unsigned short val, int count);
extern int nf_strlen(const char *str);
extern unsigned char nf_inportb (unsigned short _port);
extern void nf_outportb (unsigned short _port, unsigned char _data);

extern void nf_cls();
extern void nf_putch(unsigned char c);
extern void nf_puts(unsigned char *str);
extern void nf_settextcolor(unsigned char forecolor, unsigned char backcolor);
extern void nf_init_video();

void nf_gdt_install();
void nf_gdt_set_gate(int num, unsigned long base, unsigned long limit, unsigned char access, unsigned char gran);
extern void nf_gdt_flush();

void nf_idt_set_gate(unsigned char num, unsigned long base, unsigned short sel, unsigned char flags);
extern void nf_idt_load();
void nf_idt_install();

void nf_irq_install_handler(int irq, void (*handler)(struct regs *r));
void nf_irq_uninstall_handler(int irq);
void nf_irq_remap(void);
void nf_irq_install();

void nf_timer_install();
void nf_timer_wait(int ticks);
void nf_timer_handler(struct regs *r);

void nf_keyboard_install();
void nf_keyboard_handler(struct regs *r);

#endif
