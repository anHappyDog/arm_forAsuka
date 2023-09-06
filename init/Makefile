ARCHIVE 	:= init.a
SRCS 		:= $(wildcard *.[cS])
OBJS 		:= $(addsuffix .o,$(basename $(SRCS)))

include ../include.mk

all : $(OBJS)

%.o : %.c 
	$(CC) $^ $(CFLAGS) -I ../$(INCLUDE_DIR)  -o $@ 

%.o : %.S 
	$(AS) $^  -I ../$(INCLUDE_DIR) -o $@

.PHONY: clean
clean:
	- rm $(OBJS) -rf