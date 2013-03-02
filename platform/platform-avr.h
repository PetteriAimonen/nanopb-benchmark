/* Syscalls to interface with simulavr. */

#include <stdint.h>

#define STACK_TOP 0x1100

#define special_output_port (*((volatile char *)0x20))

static inline void platform_write(const void *buf, int length)
{
    const char *p = buf;
    while (length--)
    {
        special_output_port = *p++;
    }
}

static inline int platform_stack_usage()
{
    int i;
    for (i = 2048; i > 0; i -= 4)
    {
        if (*(uint16_t*)(STACK_TOP - i) != 0)
            return i;    
    }
    return -1;
}

