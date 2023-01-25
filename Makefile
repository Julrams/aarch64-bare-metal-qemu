osname := $(shell uname -s)
ROOT   := $(shell pwd)
INCLUDE_PATH := $(ROOT)/include
SRC := $(ROOT)/src
EXE	:= test64
CROSS_COMPILE_PATH=$(ROOT)/toolchain/gcc-arm-10.3-2021.07-x86_64-aarch64-none-elf/bin/
CROSS_PREFIX=${CROSS_COMPILE_PATH}aarch64-none-elf-
CC=$(CROSS_PREFIX)gcc
AS=$(CROSS_PREFIX)as

CFLGAS += -g

HEADERS		:= $(notdir $(wildcard $(INCLUDE_PATH)/*.h))
SOURCES_GCC	:= $(notdir $(wildcard $(SRC)/*.c))
SOURCES_AS	:= $(notdir $(wildcard $(SRC)/*.s))
OBJECTS_GCC	:= $(SOURCES_GCC:.c=.o)
OBJECTS_AS	:= $(SOURCES_AS:.s=.o)
LDSCRIPT	:= $(ROOT)/etc/test64.ld
VPATH	:= ${SRC}:${INCLUDE}

all: $(EXE).elf

%.o: %.c 
	$(CC) -c $< -o $@ -I$(INCLUDE_PATH) $(CFLGAS)

%.o: %.s 
	$(AS) -c $< -o $@ -I$(INCLUDE_PATH) $(CFLGAS)

$(EXE).elf: $(OBJECTS_GCC) $(OBJECTS_AS)
	$(CROSS_PREFIX)ld -T$(LDSCRIPT) $^ -o $@ $(CFLGAS)

$(EXE).bin: $(EXE).elf
	$(CROSS_PREFIX)objcopy -O binary $< $@

.PHONY : clean
clean:
	rm -f $(EXE).elf $(EXE).bin *.o
