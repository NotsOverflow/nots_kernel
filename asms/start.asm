; This is the kernel's entry point. We could either call main here,
; or we can use this to setup the stack or other nice stuff, like
; perhaps setting up the GDT and segments. Please note that interrupts
; are disabled at this point: More on interrupts later!
[BITS 32]
global start
start:
    mov esp, _sys_stack     ; This points the stack to our new stack area
    jmp stublet

; This part MUST be 4byte aligned, so we solve that issue using 'ALIGN 4'
ALIGN 4
mboot:
    ; Multiboot macros to make a few lines later more readable
    MULTIBOOT_PAGE_ALIGN	equ 1<<0
    MULTIBOOT_MEMORY_INFO	equ 1<<1
    MULTIBOOT_AOUT_KLUDGE	equ 1<<16
    MULTIBOOT_HEADER_MAGIC	equ 0x1BADB002
    MULTIBOOT_HEADER_FLAGS	equ MULTIBOOT_PAGE_ALIGN | MULTIBOOT_MEMORY_INFO | MULTIBOOT_AOUT_KLUDGE
    MULTIBOOT_CHECKSUM	equ -(MULTIBOOT_HEADER_MAGIC + MULTIBOOT_HEADER_FLAGS)
    EXTERN code, bss, end

    ; This is the GRUB Multiboot header. A boot signature
    dd MULTIBOOT_HEADER_MAGIC
    dd MULTIBOOT_HEADER_FLAGS
    dd MULTIBOOT_CHECKSUM
    
    ; AOUT kludge - must be physical addresses. Make a note of these:
    ; The linker script fills in the data for these ones!
    dd mboot
    dd code
    dd bss
    dd end
    dd start

; This is an endless loop here. Make a note of this: Later on, we
; will insert an 'extern _main', followed by 'call _main', right
; before the 'jmp $'.
stublet:
	extern nf_main
    call nf_main
    jmp $


; This will set up our new segment registers. We need to do
; something special in order to set CS. We do what is called a
; far jump. A jump that includes a segment as well as an offset.
; This is declared in C as 'extern void gdt_flush();'
global nf_gdt_flush     ; Allows the C code to link to this
extern gp            ; Says that '_gp' is in another file
nf_gdt_flush:
    lgdt [gp]        ; Load the GDT with our '_gp' which is a special pointer
    mov ax, 0x10      ; 0x10 is the offset in the GDT to our data segment
    mov ds, ax
    mov es, ax
    mov fs, ax
    mov gs, ax
    mov ss, ax
    jmp 0x08:flush2   ; 0x08 is the offset to our code segment: Far jump!
flush2:
    ret               ; Returns back to the C code!		


; Loads the IDT defined in '_idtp' into the processor.
; This is declared in C as 'extern void idt_load();'
global nf_idt_load
extern idtp
nf_idt_load:
    lidt [idtp]
    ret
		
; In just a few pages in this tutorial, we will add our Interrupt
; Service Routines (ISRs) right here!
global nf_isr0
global nf_isr1
global nf_isr2
global nf_isr3
global nf_isr4
global nf_isr5
global nf_isr6
global nf_isr7
global nf_isr8
global nf_isr9
global nf_isr10
global nf_isr11
global nf_isr12
global nf_isr13
global nf_isr14
global nf_isr15
global nf_isr16
global nf_isr17
global nf_isr18
global nf_isr19
global nf_isr20
global nf_isr21
global nf_isr22
global nf_isr23
global nf_isr24
global nf_isr25
global nf_isr26
global nf_isr27
global nf_isr28
global nf_isr29
global nf_isr30
global nf_isr31

;  0: Divide By Zero Exception
nf_isr0:
    cli
    push byte 0
    push byte 0
    jmp nf_isr_common_stub

;  1: Debug Exception
nf_isr1:
    cli
    push byte 0
    push byte 1
    jmp nf_isr_common_stub

;  2: Non Maskable Interrupt Exception
nf_isr2:
    cli
    push byte 0
    push byte 2
    jmp nf_isr_common_stub

;  3: Int 3 Exception
nf_isr3:
    cli
    push byte 0
    push byte 3
    jmp nf_isr_common_stub

;  4: INTO Exception
nf_isr4:
    cli
    push byte 0
    push byte 4
    jmp nf_isr_common_stub

;  5: Out of Bounds Exception
nf_isr5:
    cli
    push byte 0
    push byte 5
    jmp nf_isr_common_stub

;  6: Invalid Opcode Exception
nf_isr6:
    cli
    push byte 0
    push byte 6
    jmp nf_isr_common_stub

;  7: Coprocessor Not Available Exception
nf_isr7:
    cli
    push byte 0
    push byte 7
    jmp nf_isr_common_stub

;  8: Double Fault Exception (With Error Code!)
nf_isr8:
    cli
    push byte 8
    jmp nf_isr_common_stub

;  9: Coprocessor Segment Overrun Exception
nf_isr9:
    cli
    push byte 0
    push byte 9
    jmp nf_isr_common_stub

; 10: Bad TSS Exception (With Error Code!)
nf_isr10:
    cli
    push byte 10
    jmp nf_isr_common_stub

; 11: Segment Not Present Exception (With Error Code!)
nf_isr11:
    cli
    push byte 11
    jmp nf_isr_common_stub

; 12: Stack Fault Exception (With Error Code!)
nf_isr12:
    cli
    push byte 12
    jmp nf_isr_common_stub

; 13: General Protection Fault Exception (With Error Code!)
nf_isr13:
    cli
    push byte 13
    jmp nf_isr_common_stub

; 14: Page Fault Exception (With Error Code!)
nf_isr14:
    cli
    push byte 14
    jmp nf_isr_common_stub

; 15: Reserved Exception
nf_isr15:
    cli
    push byte 0
    push byte 15
    jmp nf_isr_common_stub

; 16: Floating Point Exception
nf_isr16:
    cli
    push byte 0
    push byte 16
    jmp nf_isr_common_stub

; 17: Alignment Check Exception
nf_isr17:
    cli
    push byte 0
    push byte 17
    jmp nf_isr_common_stub

; 18: Machine Check Exception
nf_isr18:
    cli
    push byte 0
    push byte 18
    jmp nf_isr_common_stub

; 19: Reserved
nf_isr19:
    cli
    push byte 0
    push byte 19
    jmp nf_isr_common_stub

; 20: Reserved
nf_isr20:
    cli
    push byte 0
    push byte 20
    jmp nf_isr_common_stub

; 21: Reserved
nf_isr21:
    cli
    push byte 0
    push byte 21
    jmp nf_isr_common_stub

; 22: Reserved
nf_isr22:
    cli
    push byte 0
    push byte 22
    jmp nf_isr_common_stub

; 23: Reserved
nf_isr23:
    cli
    push byte 0
    push byte 23
    jmp nf_isr_common_stub

; 24: Reserved
nf_isr24:
    cli
    push byte 0
    push byte 24
    jmp nf_isr_common_stub

; 25: Reserved
nf_isr25:
    cli
    push byte 0
    push byte 25
    jmp nf_isr_common_stub

; 26: Reserved
nf_isr26:
    cli
    push byte 0
    push byte 26
    jmp nf_isr_common_stub

; 27: Reserved
nf_isr27:
    cli
    push byte 0
    push byte 27
    jmp nf_isr_common_stub

; 28: Reserved
nf_isr28:
    cli
    push byte 0
    push byte 28
    jmp nf_isr_common_stub

; 29: Reserved
nf_isr29:
    cli
    push byte 0
    push byte 29
    jmp nf_isr_common_stub

; 30: Reserved
nf_isr30:
    cli
    push byte 0
    push byte 30
    jmp nf_isr_common_stub

; 31: Reserved
nf_isr31:
    cli
    push byte 0
    push byte 31
    jmp nf_isr_common_stub

; We call a C function in here. We need to let the assembler know
; that '_fault_handler' exists in another file
extern nf_fault_handler

; This is our common ISR stub. It saves the processor state, sets
; up for kernel mode segments, calls the C-level fault handler,
; and finally restores the stack frame.
nf_isr_common_stub:
    pusha
    push ds
    push es
    push fs
    push gs
    mov ax, 0x10
    mov ds, ax
    mov es, ax
    mov fs, ax
    mov gs, ax
    mov eax, esp
    push eax
    mov eax, nf_fault_handler
    call eax
    pop eax
    pop gs
    pop fs
    pop es
    pop ds
    popa
    add esp, 8
    iret

global nf_irq0
global nf_irq1
global nf_irq2
global nf_irq3
global nf_irq4
global nf_irq5
global nf_irq6
global nf_irq7
global nf_irq8
global nf_irq9
global nf_irq10
global nf_irq11
global nf_irq12
global nf_irq13
global nf_irq14
global nf_irq15

; 32: IRQ0
nf_irq0:
    cli
    push byte 0
    push byte 32
    jmp nf_irq_common_stub

; 33: IRQ1
nf_irq1:
    cli
    push byte 0
    push byte 33
    jmp nf_irq_common_stub

; 34: IRQ2
nf_irq2:
    cli
    push byte 0
    push byte 34
    jmp nf_irq_common_stub

; 35: IRQ3
nf_irq3:
    cli
    push byte 0
    push byte 35
    jmp nf_irq_common_stub

; 36: IRQ4
nf_irq4:
    cli
    push byte 0
    push byte 36
    jmp nf_irq_common_stub

; 37: IRQ5
nf_irq5:
    cli
    push byte 0
    push byte 37
    jmp nf_irq_common_stub

; 38: IRQ6
nf_irq6:
    cli
    push byte 0
    push byte 38
    jmp nf_irq_common_stub

; 39: IRQ7
nf_irq7:
    cli
    push byte 0
    push byte 39
    jmp nf_irq_common_stub

; 40: IRQ8
nf_irq8:
    cli
    push byte 0
    push byte 40
    jmp nf_irq_common_stub

; 41: IRQ9
nf_irq9:
    cli
    push byte 0
    push byte 41
    jmp nf_irq_common_stub

; 42: IRQ10
nf_irq10:
    cli
    push byte 0
    push byte 42
    jmp nf_irq_common_stub

; 43: IRQ11
nf_irq11:
    cli
    push byte 0
    push byte 43
    jmp nf_irq_common_stub

; 44: IRQ12
nf_irq12:
    cli
    push byte 0
    push byte 44
    jmp nf_irq_common_stub

; 45: IRQ13
nf_irq13:
    cli
    push byte 0
    push byte 45
    jmp nf_irq_common_stub

; 46: IRQ14
nf_irq14:
    cli
    push byte 0
    push byte 46
    jmp nf_irq_common_stub

; 47: IRQ15
nf_irq15:
    cli
    push byte 0
    push byte 47
    jmp nf_irq_common_stub

extern nf_irq_handler

nf_irq_common_stub:
    pusha
    push ds
    push es
    push fs
    push gs

    mov ax, 0x10
    mov ds, ax
    mov es, ax
    mov fs, ax
    mov gs, ax
    mov eax, esp

    push eax
    mov eax, nf_irq_handler
    call eax
    pop eax

    pop gs
    pop fs
    pop es
    pop ds
    popa
    add esp, 8
    iret

; Here is the definition of our BSS section. Right now, we'll use
; it just to store the stack. Remember that a stack actually grows
; downwards, so we declare the size of the data before declaring
; the identifier '_sys_stack'
SECTION .bss
    resb 8192               ; This reserves 8KBytes of memory here
_sys_stack:


