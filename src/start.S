.global _start


.section .boot
.type _start,%function

_start:
    ldr sp ,=0x40600000
    b arm_init
