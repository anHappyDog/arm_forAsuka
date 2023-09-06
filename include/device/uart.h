#ifndef __UART_H__
#define __UART_H__
#include <types.h>
/*
This is a simple dvr header for the arm v7 pl011
*/

//
// void uart_init(void);
// uint8_t uart_read();
// uint8_t uart_write(int8_t chr);
// void uart_close(void);

// #define uart_init \
//     do {           \
//                     \
//                     \
//     } while (0);

#define UART_BASE 0x9000000
#define UART_DR   (UART_BASE + 0)

#define uart_write(c) \
    do{                 \
        asm volatile ("strb %0, [%1]"  \
        :: "r"((uint8_t)c), "r"(UART_DR)); \
    } while(0);


#endif