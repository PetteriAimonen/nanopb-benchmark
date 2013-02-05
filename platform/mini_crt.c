/* Minimal implementations of libc functions.
 * These are designed to be only used in simulation.
 */

#include "platform.h"
#include <stdlib.h>
#include <stdio.h>
#include <string.h>

extern int main();

void _start()
{
    PLATFORM_INIT;
    main();
    PLATFORM_HALT;
}

static uint32_t *heap_ptr = (uint32_t*)0x2000000;
static int heap_usage;
int max_heap_usage = 0;

void *malloc(size_t size)
{
    heap_ptr += 0x1000;
    *heap_ptr++ = size;
    heap_usage += size;
    
    if (heap_usage > max_heap_usage)
        max_heap_usage = heap_usage;
    
    return heap_ptr;
}

void free(void *p)
{
    heap_usage -= *((uint32_t*)p - 1);
}

int fprintf(FILE *stream, const char *format, ...)
{
    platform_write(format, strlen(format));
    return 0;
}

int printf(const char *format, ...)
{
    platform_write(format, strlen(format));
    return 0;
}

int fputs(const char *s, FILE *stream)
{
    platform_write(s, strlen(s));
    return 0;
}

#undef putchar
int putchar(int c)
{
    platform_write(&c, 1);
    return 0;
}

void abort()
{
    PLATFORM_HALT;
    while(1);
}

void __assert_func(const char *s, int i, const char *p, const char *q)
{
    platform_write(s, strlen(s));
    abort();
}

