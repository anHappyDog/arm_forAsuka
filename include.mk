CROSS			:= arm-linux-gnueabihf-
CC				:= $(CROSS)gcc
LD 				:= $(CROSS)ld
GDB 			:= $(CROSS)gdb
AR 				:= $(CROSS)ar
AS 				:= $(CROSS)as
OBJDUMP 		:= $(CROSS)objdump
CPU_VER 		:= cortex-a7



CFLAGS 			:= -g --std=gnu99 -nostartfiles  -marm  -mabi=aapcs \
								 -mtune=$(CPU_VER) -mcpu=$(CPU_VER) --verbose
LDFLAGS 		:=  -nostdlib -N
ARCHIVE_DIR 	:=  arfiles


QEMU_SYSTEM		:= qemu-system-arm
QEMU_FLAGS 		:= -m 64M -S -s -nographic -cpu $(CPU_VER)  -machine virt

INCLUDE_DIR 			:= include
ARCHIVE_DIR 			:= arfiles