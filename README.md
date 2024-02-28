# aarch64-bare-metal-qemu
aarch64(Cortex-A53 Target) bare metal code on qemu

1. starting from https://balau82.wordpress.com/2010/02/28/hello-world-for-bare-metal-arm-using-qemu/ seems a good idea 
   And Also Forked from https://github.com/freedomtan/aarch64-bare-metal-qemu
   
2. Please use bare metal one from linaro (http://releases.linaro.org/14.11/components/toolchain/binaries/aarch64-none-elf/gcc-linaro-4.9-2014.11-x86_64_aarch64-elf.tar.xz)

3. One of the working aarch64 targets of qemu is virt, a look into qemu's [hw/arm/virt.c](http://git.qemu.org/?p=qemu.git;a=blob_plain;f=hw/arm/virt.c;hb=HEAD) shows that the memory mapped UART0 is located at 0x0900000. So the UART0DR in test.c should be changed to 0x09000000.

4. The address to load the program to should be changed too. '0x10000' is not valid RAM or ROM address for -M virt. According to virt.c, '0x40000000' is OK to use. So my linker script is modified and named [test64.ld](test64.ld)

5. I use 'aarch64-none-elf-ld -T test64.ld main.o startup64.o -o test64.elf' to generate test64.elf

#HOW TO RUN

qemu-system-aarch64 -M virt -cpu cortex-a53 -nographic -kernel test64.elf -L ../toolchain/gcc-arm-10.3-2021.07-x86_64-aarch64-none-elf/lib/ -S -gdb tcp::1234,ipv4


#HOW TO DEBUG by GDB

toolchain/gcc-arm-10.3-2021.07-x86_64-aarch64-none-elf/bin/aarch64-none-elf-gdb
target remote :1234


