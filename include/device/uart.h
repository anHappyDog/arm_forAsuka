#ifndef __UART_H__
#define __UART_H__
#include <types.h>


#define UART_BASE 0x9000000
#define UART_DR   (UART_BASE + 0)

#define uart_write(c) \
    do{                 \
        asm volatile ("strb %0, [%1]"  \
        :: "r"((uint8_t)c), "r"(UART_DR)); \
    } while(0);

#define uart_read()    \
    ({})






#endif