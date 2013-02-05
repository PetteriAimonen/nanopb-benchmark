#include <platform.h>
#include <pb_encode.h>
#include <pb_decode.h>
#include "alltypes.pb.h"
#include "results.pb.h"
#include "input_data.h"

bool streamcallback(pb_ostream_t *stream, const uint8_t *buf, size_t count)
{
    platform_write(buf, count);
    return true;
}

int main()
{
    TestResults results = {};
    AllTypes message = {};

    pb_istream_t istream = pb_istream_from_buffer((uint8_t*)input_data, sizeof(input_data));
    results.success = pb_decode(&istream, AllTypes_fields, &message);
    results.success &= (message.end == 1099);

    results.has_stack_usage = true;
    results.stack_usage = platform_stack_usage();

    pb_ostream_t ostream = {&streamcallback, 0, 512, 0};
    pb_encode(&ostream, TestResults_fields, &results);
    
    return 0;
}


