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
    for (i = 2047; i > 0; i -= 4)
    {
        /* Note that this relies on the memory being initialized to constant value.. */
        if (*(uint16_t*)(STACK_TOP - i) != *(uint16_t*)(STACK_TOP - i - 1))
            return i;    
    }
    return -1;
}

