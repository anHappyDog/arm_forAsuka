include include.mk
TARGET_DIR 				:= target
INIT_DIR 				:= init
MODULES 				:= kern lib
INIT_FILES 				:= $(wildcard $(INIT_DIR)/*.[cS])
INIT_OBJS 				:= $(addsuffix .o, $(basename $(INIT_FILES)))
ARCHIVES 				:= $(addprefix $(ARCHIVE_DIR)/,$(addsuffix .a,$(MODULES)))
TARGET 					:= $(TARGET_DIR)/test_bin

LD_SCRIPT				:= kernel.lds


all: $(TARGET)

$(TARGET): $(ARCHIVES) $(INIT_OBJS)
	if [ ! -d $(TARGET_DIR) ]; then mkdir $(TARGET_DIR); fi 
	$(CC) -o $(TARGET) $(INIT_OBJS) $(ARCHIVES)  \
	$(CFLAGS) $(LDFLAGS) -T $(LD_SCRIPT)  -I $(INCLUDE_DIR)

$(ARCHIVES):
	for d in $(MODULES); do  \
		$(MAKE) -C $$d; 		\
	done


qemu-gdb : $(TARGET)
	$(QEMU_SYSTEM) $(QEMU_FLAGS) -kernel $(TARGET) -S -s 

qemu-run : $(TARGET)
	$(QEMU_SYSTEM) $(QEMU_FLAGS) -kernel $(TARGET)


gdb : $(TARGET)
	$(GDB) --eval-command 'target remote :1234' $(TARGET)

objdump : $(TARGET)
	$(OBJDUMP) -D -x -S $(TARGET) > $(TARGET_DIR)/1.asuka

dts : $(TARGET_DIR)
	if [ ! -d "$(TARGET_DIR)" ]; then mkdir $(TARGET_DIR); fi
	$(QEMU_SYSTEM) $(QEMU_FLAGS),dumpdtb=$(TARGET_DIR)/dump.dtb
	dtc -o $(TARGET_DIR)/dump.dts -O dts -I dtb $(TARGET_DIR)/dump.dtb


%.o : %.c 
	$(CC) -o $@ -c $< $(CFLAGS) -I $(INCLUDE_DIR)


%.o : %.S 
	$(AS) $^  -I $(INCLUDE_DIR) -o $@

	


.PHONY: clean all
clean: 
	for d in $(MODULES); do $(MAKE) -C $$d clean;done
	- rm $(ARCHIVE_DIR) $(TARGET_DIR) $(INIT_OBJS) -rf








