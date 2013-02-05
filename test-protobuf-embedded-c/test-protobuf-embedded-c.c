#include <platform.h>
#include "alltypes.h"
#include "input_data.h"

int main()
{
    struct TestResults results = {};
    struct AllTypes message;
    char resultbuf[16];

    AllTypes_read_delimited_from((void*)input_data, &message, 0);
    
    results._success = (message._end == 1099);
    
    results._stack_usage = platform_stack_usage();
    
    int len = TestResults_write_delimited_to(&results, resultbuf, 0);
    platform_write(resultbuf + 1, len - 1);
    
    return 0;
}


