include include.mk
TARGET_DIR 				:= target
INIT_DIR 				= init
MODULES 				:= kern
INIT_FILES 				= $(wildcard $(INIT_DIR)/*.o)
ARCHIVES 				:= $(addprefix $(ARCHIVE_DIR)/,$(addsuffix .a,$(MODULES)))
TARGET 					:= $(TARGET_DIR)/test_bin

LD_SCRIPT				:= kernel.lds


all: $(TARGET)

$(TARGET): $(ARCHIVES)
	$(MAKE) -C $(INIT_DIR)
	if [ ! -d $(TARGET_DIR) ]; then mkdir $(TARGET_DIR); fi 
	$(CC) -o $(TARGET) $(INIT_FILES) $(ARCHIVES) \
	$(CFLAGS) $(LDFLAGS) -T $(LD_SCRIPT) 

$(ARCHIVES):
	for d in $(MODULES); do  \
		$(MAKE) -C $$d $$d.a; 		\
	done


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
	$(CC) $^ $(CFLAGS) -I $(INCLUDE_DIR)  -o $@ 

%.o : %.S 
	$(AS) $^  -I $(INCLUDE_DIR) -o $@

	


.PHONY: clean all
clean: 
	for d in $(MODULES); do $(MAKE) -C $$d clean;done
	- rm $(ARCHIVE_DIR) $(TARGET_DIR) -rf







