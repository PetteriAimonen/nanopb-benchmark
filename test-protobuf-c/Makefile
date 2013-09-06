CSRC = alltypes.pb-c.c results.pb-c.c test-protobuf-c.c
CSRC += protobuf-c/src/google/protobuf-c/protobuf-c.c
CFLAGS = -I protobuf-c/src

all: results_all

include ../platform/Makefile

%.pb-c.c %.pb-c.h: %.proto
	protobuf-c/src/protoc-c --c_out=. $<

simulation_size: protobuf-c/src/google/protobuf-c/protobuf-c.o alltypes.pb-c.o results.pb-c.o
	size -t $^ | grep TOTALS | grep -o '[0-9]*' | head -n 1 > $@

results_all: results_0.15
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

