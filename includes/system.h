#ifndef __SYSTEM_H
#define __SYSTEM_H

/* MAIN.C */
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

#endif
