#ifndef __UART_H__
#define __UART_H__
/*
This is a simple dvr header for the arm v7 pl011
*/

//
void uart_init(void);
uint8_t uart_read();
uint8_t uart_write(int8_t  chr);
void uart_close(void);



#endif