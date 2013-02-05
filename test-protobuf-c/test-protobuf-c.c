#include <stdbool.h>
#include <platform.h>
#include "alltypes.pb-c.h"
#include "results.pb-c.h"
#include "input_data.h"

extern int max_heap_usage;

int main()
{
    TestResults results = TEST_RESULTS__INIT;
    uint8_t resultbuf[16];
    
    AllTypes *msg = all_types__unpack(NULL, sizeof(input_data), input_data);
    results.success = (msg != NULL) && (msg->end == 1099);

    results.has_heap_usage = true;
    results.heap_usage = max_heap_usage;
    
    results.has_stack_usage = true;
    results.stack_usage = platform_stack_usage();

    int len = test_results__pack(&results, resultbuf);
    platform_write(resultbuf, len);
    
    return 0;
}


