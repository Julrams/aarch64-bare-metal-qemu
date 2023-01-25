.global _Reset
_Reset:

// -----------------------------------------------------------------------------
// Initialise register bank
// -----------------------------------------------------------------------------
    mov     x0, xzr
    mov     x1, xzr
    mov     x2, xzr
    mov     x3, xzr
    mov     x4, xzr
    mov     x5, xzr
    mov     x6, xzr
    mov     x7, xzr
    mov     x8, xzr
    mov     x9, xzr
    mov     x10, xzr
    mov     x11, xzr
    mov     x12, xzr
    mov     x14, xzr
    mov     x15, xzr
    mov     x16, xzr
    mov     x17, xzr
    mov     x18, xzr
    mov     x19, xzr
    mov     x20, xzr
    mov     x21, xzr
    mov     x22, xzr
    mov     x23, xzr
    mov     x24, xzr
    mov     x25, xzr
    mov     x26, xzr
    mov     x27, xzr
    mov     x28, xzr
    mov     x29, xzr
    mov     x30, xzr

// Zero the stack pointers, link registers and status registers
    mov     sp,       x0
    msr     sp_el0,   x0
/*
    msr     sp_el1,   x0
    msr     sp_el2,   x0
    msr     elr_el1,  x0
    msr     elr_el2,  x0
    msr     elr_el3,  x0
    msr     spsr_el1, x0
    msr     spsr_el2, x0
    msr     spsr_el3, x0
*/

    ldr x30, =stack_top	// setup stack
    mov sp, x30
    bl c_entry
    b .
