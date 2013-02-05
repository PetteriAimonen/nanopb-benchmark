This is a bunch of scripts for comparing three implementations of Google's
Protocol Buffers format:

- nanopb
- protobuf-embedded-c
- protobuf-c

This is targeted towards embedded platforms, and therefore the tests are
run in simulators. The platforms currently tested are AVR (atmega128) and
ARM (Cortex-M3).

To run the tests you need to have the following installed:
- arm-none-eabi-gcc toolchain, for example https://launchpad.net/gcc-arm-embedded
- qemu-system-arm simulator
- avr-gcc
- simulavrxx 1.0rc0 or newer (recommend newest git master)
- protobuf-compiler, python-protobuf, libprotobuf-dev

--

The tests are based on alltypes.proto, included in template folder. This message
contains all the field types available in Protocol Buffers. The success status
of the tests is encoded in the message given in results.proto. Number of instruction
required for the complete test program is computed, as is the used stack and heap
memory. The compiled code size includes library parts and generated protocol definitions,
but not the test program nor platform libraries.

Because the received message is much larger, more weight is given to decoding speed than
encoding speed. The appropriateness of this depends on application.

--

All included protobuf libraries are under their respective licenses.

Any scripts and data files used for simulations are in public domain.



