include include.mk
TARGET_DIR 				:= ./target
SRC_DIR	 				:= ./src
INCLUDE_DIR 			:= ./include
TARGET 					:= $(TARGET_DIR)/test_bin
SRCS					:= $(wildcard $(SRC_DIR)/*.c) $(wildcard $(SRC_DIR)/*.S)
OBJS 					:= $(addsuffix .o,$(basename $(SRCS)))

LD_SCRIPT				:= kernel.lds


all: $(TARGET)

$(TARGET): $(OBJS)
	if [ ! -d "$(TARGET_DIR)" ]; then mkdir $(TARGET_DIR); else rm $(TARGET_DIR)/* -rf; fi
	$(LD) $^ -T $(LD_SCRIPT) $(LDFLAGS) -o $@

$(TARGET_DIR):
	if [ ! -d "$(TARGET_DIR)" ]; then mkdir $(TARGET_DIR); fi



qemu-run : $(TARGET)
	$(QEMU_SYSTEM) $(QEMU_FLAGS) -kernel $(TARGET)

gdb : $(TARGET)
	$(GDB) --eval-command 'target remote :1234' $(TARGET)

objdump : $(TARGET)
	$(OBJDUMP) -D -x -S $(TARGET) > $(TARGET_DIR)/1.asuka

dts : $(TARGET_DIR)
	$(QEMU_SYSTEM) $(QEMU_FLAGS),dumpdtb=$(TARGET_DIR)/dump.dtb
	dtc -o $(TARGET_DIR)/dump.dts -O dts -I dtb $(TARGET_DIR)/dump.dtb


%.o : %.c 
	$(CC) $^ $(CFLAGS) -I $(INCLUDE_DIR)  -o $@ 

%.o : %.S 
	$(CROSS)as $^  -I $(INCLUDE_DIR) -o $@




.PHONY: clean mktest
clean: 
	- rm $(OBJS) $(TARGET_DIR) -rf

mktest:
	@echo $(SRCS)
	@echo $(OBJS)
	@echo $(TARGET)





