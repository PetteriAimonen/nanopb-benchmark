CSRC = alltypes.pb-c.c results.pb-c.c test-protobuf-c.c

SIZEOBJS = alltypes.pb-c.o results.pb-c.o

ifneq ($(wildcard protobuf-c/src/google/protobuf-c/protobuf-c.c),)
    CFLAGS = -I protobuf-c/src
    CSRC += protobuf-c/src/google/protobuf-c/protobuf-c.c
    SIZEOBJS += protobuf-c/src/google/protobuf-c/protobuf-c.o
else
    CFLAGS = -I protobuf-c
    CSRC += protobuf-c/protobuf-c/protobuf-c.c
    SIZEOBJS += protobuf-c/protobuf-c/protobuf-c.o
endif

all: results_all

include ../platform/Makefile

%.pb-c.c %.pb-c.h: %.proto
	protobuf-c/*/protoc-c --c_out=. $<

simulation_size: $(SIZEOBJS)
	size -t $^ | grep TOTALS | grep -o '[0-9]*' | head -n 1 > $@

results_all: results_0.15 results_1.0.1
	cat $^ > $@

results_0.15:
	echo 0.15 > simulation_version
	echo 2011-03-10 > simulation_date
	rm -rf protobuf-c
	tar xzf protobuf-c-0.15.tar.gz
	mv protobuf-c-0.15 protobuf-c
	( cd protobuf-c && ./configure )
	make -C protobuf-c
	make -B simulation_combined
	cp simulation_combined $@

results_1.0.1:
	echo 1.0.1 > simulation_version
	echo 2014-08-05 > simulation_date
	rm -rf protobuf-c
	tar xzf protobuf-c-1.0.1.tar.gz
	mv protobuf-c-1.0.1 protobuf-c
	( cd protobuf-c && ./configure )
	make -C protobuf-c
	make -B simulation_combined
	cp simulation_combined $@

