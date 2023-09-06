.section .boot
.global _start
    ldr sp,=0x40600000
    b arm_init