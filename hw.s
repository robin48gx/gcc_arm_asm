    .syntax unified

    @ --------------------------------
.global asm_main
asm_main:
    @ Stack the return address (lr) in addition to a dummy register (ip) to
    @ keep the stack 8-byte aligned.
    push    {ip, lr}

    @ Load the argument and perform the call. This is like 'printf("...")' in C.
    ldr     r0, =message
    bl      printf
    ldr     r0, =message2
    push    {r0, r1}
    bl      printf
    pop     {r0, r1}

    @ Exit from 'main'. This is like 'return 0' in C.
    mov     r0, #0    @ Return 0.

    @ Pop the dummy ip to reverse our alignment fix, and pop the original lr
    @ value directly into pc — the Program Counter — to return.
    pop     {ip, pc}

    @ --------------------------------
    @ Data for the printf calls. The GNU assembler's ".asciz" directive
    @ automatically adds a NULL character termination.
message:
    .asciz "Hello, world.\n"
message2:
    .asciz "arg 1 0x%X arg 2 0x%X.\n"

