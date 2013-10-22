/* -.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.

* File Name : main.c

* Purpose :  from the kernel

* Creation Date : 20-10-2013

* Created By :  Notsgnik

_._._._._._._._._._._._._._._._._._._._._.*/

#include "system.h"

/* These are function prototypes for all of the exception
*  handlers: The first 32 entries in the IDT are reserved
*  by Intel, and are designed to service exceptions! */
extern void nf_isr0();
extern void nf_isr1();
extern void nf_isr2();
extern void nf_isr3();
extern void nf_isr4();
extern void nf_isr5();
extern void nf_isr6();
extern void nf_isr7();
extern void nf_isr8();
extern void nf_isr9();
extern void nf_isr10();
extern void nf_isr11();
extern void nf_isr12();
extern void nf_isr13();
extern void nf_isr14();
extern void nf_isr15();
extern void nf_isr16();
extern void nf_isr17();
extern void nf_isr18();
extern void nf_isr19();
extern void nf_isr20();
extern void nf_isr21();
extern void nf_isr22();
extern void nf_isr23();
extern void nf_isr24();
extern void nf_isr25();
extern void nf_isr26();
extern void nf_isr27();
extern void nf_isr28();
extern void nf_isr29();
extern void nf_isr30();
extern void nf_isr31();

/* This is a very repetitive function... it's not hard, it's
*  just annoying. As you can see, we set the first 32 entries
*  in the IDT to the first 32 ISRs. We can't use a for loop
*  for this, because there is no way to get the function names
*  that correspond to that given entry. We set the access
*  flags to 0x8E. This means that the entry is present, is
*  running in ring 0 (kernel level), and has the lower 5 bits
*  set to the required '14', which is represented by 'E' in
*  hex. */
void nf_isrs_install()
{
    nf_idt_set_gate(0, (unsigned)nf_isr0, 0x08, 0x8E);
    nf_idt_set_gate(1, (unsigned)nf_isr1, 0x08, 0x8E);
    nf_idt_set_gate(2, (unsigned)nf_isr2, 0x08, 0x8E);
    nf_idt_set_gate(3, (unsigned)nf_isr3, 0x08, 0x8E);
    nf_idt_set_gate(4, (unsigned)nf_isr4, 0x08, 0x8E);
    nf_idt_set_gate(5, (unsigned)nf_isr5, 0x08, 0x8E);
    nf_idt_set_gate(6, (unsigned)nf_isr6, 0x08, 0x8E);
    nf_idt_set_gate(7, (unsigned)nf_isr7, 0x08, 0x8E);

    nf_idt_set_gate(8, (unsigned)nf_isr8, 0x08, 0x8E);
    nf_idt_set_gate(9, (unsigned)nf_isr9, 0x08, 0x8E);
    nf_idt_set_gate(10, (unsigned)nf_isr10, 0x08, 0x8E);
    nf_idt_set_gate(11, (unsigned)nf_isr11, 0x08, 0x8E);
    nf_idt_set_gate(12, (unsigned)nf_isr12, 0x08, 0x8E);
    nf_idt_set_gate(13, (unsigned)nf_isr13, 0x08, 0x8E);
    nf_idt_set_gate(14, (unsigned)nf_isr14, 0x08, 0x8E);
    nf_idt_set_gate(15, (unsigned)nf_isr15, 0x08, 0x8E);

    nf_idt_set_gate(16, (unsigned)nf_isr16, 0x08, 0x8E);
    nf_idt_set_gate(17, (unsigned)nf_isr17, 0x08, 0x8E);
    nf_idt_set_gate(18, (unsigned)nf_isr18, 0x08, 0x8E);
    nf_idt_set_gate(19, (unsigned)nf_isr19, 0x08, 0x8E);
    nf_idt_set_gate(20, (unsigned)nf_isr20, 0x08, 0x8E);
    nf_idt_set_gate(21, (unsigned)nf_isr21, 0x08, 0x8E);
    nf_idt_set_gate(22, (unsigned)nf_isr22, 0x08, 0x8E);
    nf_idt_set_gate(23, (unsigned)nf_isr23, 0x08, 0x8E);

    nf_idt_set_gate(24, (unsigned)nf_isr24, 0x08, 0x8E);
    nf_idt_set_gate(25, (unsigned)nf_isr25, 0x08, 0x8E);
    nf_idt_set_gate(26, (unsigned)nf_isr26, 0x08, 0x8E);
    nf_idt_set_gate(27, (unsigned)nf_isr27, 0x08, 0x8E);
    nf_idt_set_gate(28, (unsigned)nf_isr28, 0x08, 0x8E);
    nf_idt_set_gate(29, (unsigned)nf_isr29, 0x08, 0x8E);
    nf_idt_set_gate(30, (unsigned)nf_isr30, 0x08, 0x8E);
    nf_idt_set_gate(31, (unsigned)nf_isr31, 0x08, 0x8E);
}

/* This is a simple string array. It contains the message that
*  corresponds to each and every exception. We get the correct
*  message by accessing like:
*  exception_message[interrupt_number] */
char *nf_exception_messages[] =
{
    "Division By Zero",
    "Debug",
    "Non Maskable Interrupt",
    "Breakpoint",
    "Into Detected Overflow",
    "Out of Bounds",
    "Invalid Opcode",
    "No Coprocessor",

    "Double Fault",
    "Coprocessor Segment Overrun",
    "Bad TSS",
    "Segment Not Present",
    "Stack Fault",
    "General Protection Fault",
    "Page Fault",
    "Unknown Interrupt",

    "Coprocessor Fault",
    "Alignment Check",
    "Machine Check",
    "Reserved",
    "Reserved",
    "Reserved",
    "Reserved",
    "Reserved",

    "Reserved",
    "Reserved",
    "Reserved",
    "Reserved",
    "Reserved",
    "Reserved",
    "Reserved",
    "Reserved"
};

/* All of our Exception handling Interrupt Service Routines will
*  point to this function. This will tell us what exception has
*  happened! Right now, we simply halt the system by hitting an
*  endless loop. All ISRs disable interrupts while they are being
*  serviced as a 'locking' mechanism to prevent an IRQ from
*  happening and messing up kernel data structures */
void nf_fault_handler(struct regs *r)
{
    if (r->int_no < 32)
    {
    	if(csr_x != 0)
    		nf_putch((unsigned char)'\n');
        nf_puts((unsigned char *)nf_exception_messages[r->int_no]);
        nf_puts((unsigned char *)" Exception. System Halted!\n");
        for (;;);
    }
}
