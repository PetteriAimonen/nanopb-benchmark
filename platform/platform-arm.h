/* Syscalls to interface with ARM Cortex-M3 semihosted on qemu-system-arm. */

#include <stdint.h>

#define STACK_TOP 0x1000000

#define PLATFORM_INIT \
    asm("mov sp, %0" : : "r"(STACK_TOP));

#define PLATFORM_HALT \
    asm("mov r12, %0\n" "mov r0, #24\n" "bkpt 0x00ab" : : "r"(0xDEADBEEF) : "r0");

static inline void platform_write(const void *buf, int length)
{
    static uint32_t args[3];
    args[0] = 1;
    args[1] = (uint32_t)buf;
    args[2] = length;
    asm("mov r0, #5\n"
        "mov r1, %0\n"
        "bkpt 0x00ab"  : : "r"(args) : "r0", "r1");
}

static inline int platform_stack_usage()
{
    int i;
    for (i = 4096; i > 0; i -= 16)
    {
        if (*(uint32_t*)(STACK_TOP - i) != 0)
            return i;    
    }
    return -1;
}

