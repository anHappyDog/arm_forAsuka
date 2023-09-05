#include <init.h>


void arm_init() {

    asm volatile("mov r0,#0");
    asm volatile("mov r7,#1");
    asm volatile("svc #0");
    for (int i = 0; i < 10; ++i);
}