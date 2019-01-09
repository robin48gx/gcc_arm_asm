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


.global bit_reverse
bit_reverse:
    push    {r4, r5, ip, lr }

    @ r0 holds pointer to array to reverse
    @ r1 contains size of array

    lsl r1, r1, 1            @ half words so want index * 2 (because its in bytes)

    @ works as expected loads 0x5555AAAB into r2 ldr r2,=0x5555AAAB
    ldrsh r3,[r0,#10]        @  5th entry
    @revsh r3,r3
    ldr r3,[r0,#30]           @ 15th entry
    @revsh r3,r3

bit_rev_loop:
    sub r1,r1,#32
    @ r1 is the index. So store the temp value to be swapped in r4
    add r1,r1,#2
    ldrsh r4, [r0,r1]
    @rbit  instruction not supported on this ARM, but its a 32 bit rev  r2,r1 @ bit reverse the index
    str   r4,[r0,r1] @ change something
    add r1,r1,#2
    str   r4,[r0,r1] @ change something
    add r1,r1,#2
    str   r4,[r0,r1] @ change something

    mov     r0, #0    @ Return 0.
    pop     {r4, r5, ip, pc}


    @ --------------------------------
    @ Data for the printf calls. The GNU assembler's ".asciz" directive
    @ automatically adds a NULL character termination.
message:
    .asciz "Hello, world.\n"
message2:
    .asciz "arg 1 0x%X arg 2 0x%X.\n"

