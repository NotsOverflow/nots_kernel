/* -.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.

* File Name : main.c

* Purpose :  from the kernel

* Creation Date : 20-10-2013

* Created By :  Notsgnik

_._._._._._._._._._._._._._._._._._._._._.*/

#include "system.h"


/* Handles the timer. In this case, it's very simple: We
*  increment the 'timer_ticks' variable every time the
*  timer fires. By default, the timer fires 18.222 times
*  per second. Why 18.222Hz? Some engineer at IBM must've
*  been smoking something funky */
void nf_timer_handler(struct regs *r)
{
    /* Increment our 'tick count' */
    r = r;
    nf_timer_ticks++;

    /* Every 18 clocks (approximately 1 second), we will
    *  display a message on the screen /
    if (nf_timer_ticks % 18 == 0)
    {
        nf_puts((unsigned char*)"One second has passed\n");
    }
    */
}

/* This will continuously loop until the given time has
*  been reached */
void nf_timer_wait(int ticks)
{
    unsigned long eticks;

    eticks = nf_timer_ticks + ticks;
    while(nf_timer_ticks < eticks);
}

/* Sets up the system clock by installing the timer handler
*  into IRQ0 */
void nf_timer_install()
{
	nf_timer_ticks = 0;
    /* Installs 'timer_handler' to IRQ0 */
    nf_irq_install_handler(0, nf_timer_handler);
}
