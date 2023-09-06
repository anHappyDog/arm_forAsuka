#ifndef __PRINT_H__
#define __PRINT_H__



#include <device/uart.h>
#include <stdarg.h>
#include <types.h>


typedef void (*fmt_callback_t)(void* data,const char* buf, size_t len);
void printk(const char* fmt,...);
void vprintfmt(fmt_callback_t out, void* data, const char* fmt, va_list ap);

#endif



