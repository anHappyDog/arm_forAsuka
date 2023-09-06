ARCHIVE 	:= lib.a
SRCS 		:= $(wildcard *.[cS])
OBJS 		:= $(addsuffix .o,$(basename $(SRCS)))

include ../include.mk


all : $(ARCHIVE)

$(ARCHIVE) : $(OBJS)
	if [ ! -d ../$(ARCHIVE_DIR) ]; then mkdir ../$(ARCHIVE_DIR); fi	
	$(AR) rcs ../$(ARCHIVE_DIR)/$(ARCHIVE) $(OBJS)

%.o : %.c 
	$(CC) -c $<  $(CFLAGS) -I ../$(INCLUDE_DIR) 

%.o : %.S 
	$(AS) -c $<  -I ../$(INCLUDE_DIR)

.PHONY: clean
clean:
	- rm $(OBJS) -rf




