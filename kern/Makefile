ARCHIVE 	:= kern.a
SRCS 		:= $(wildcard *.[cS])
OBJS 		:= $(addsuffix .o,$(basename $(SRCS)))

include ../include.mk


all : $(ARCHIVE)

$(ARCHIVE) : $(OBJS)
	if [ ! -d ../$(ARCHIVE_DIR) ]; then mkdir ../$(ARCHIVE_DIR); fi	
	$(AR) rcs ../$(ARCHIVE_DIR)/$(ARCHIVE) $(OBJS)

%.o : %.c 
	$(CC) $^ $(CFLAGS) -I ../$(INCLUDE_DIR)  -o $@ 

%.o : %.S 
	$(AS) $^  -I ../$(INCLUDE_DIR) -o $@

.PHONY: clean
clean:
	- rm $(OBJS) -rf




