ARM_COMPILER_VERSION=$(shell arm-none-eabi-gcc --version | head -n 1)
ARM_SIMULATOR_VERSION=$(shell qemu-system-arm --version)
AVR_COMPILER_VERSION=$(shell avr-gcc --version | head -n 1)
AVR_SIMULATOR_VERSION=$(shell simulavr --version | head -n 1)

all: make_images publish/index.html

publish/index.html: report_template.html
	mkdir -p publish
	cat $< | \
		sed "s@{arm_compiler_info}@$(ARM_COMPILER_VERSION)@" | \
		sed "s@{arm_simulator_info}@$(ARM_SIMULATOR_VERSION)@" | \
		sed "s@{avr_compiler_info}@$(AVR_COMPILER_VERSION)@" | \
		sed "s@{avr_simulator_info}@$(AVR_SIMULATOR_VERSION)@" \
	> $@

make_images: generate_graphs.gnuplot results_nanopb_arm results_pec_arm results_pbc_arm \
		results_nanopb_avr results_pec_avr results_pbc_avr
	gnuplot generate_graphs.gnuplot

results_nanopb_avr:
	ln -sf Makefile.avr platform/Makefile
	ln -sf platform-avr.h platform/platform.h
	rm -f test-nanopb/results_*
	make -C test-nanopb
	cp test-nanopb/results_all $@
	echo xxxx 2099-01-01 `tail -n 1 $@ | cut -d ' ' -f 3-` >> $@

results_pec_avr:
	ln -sf Makefile.avr platform/Makefile
	ln -sf platform-avr.h platform/platform.h
	rm -f test-protobuf-embedded-c/results_*
	make -C test-protobuf-embedded-c
	cp test-protobuf-embedded-c/results_all $@
	echo xxxx 2099-01-01 `tail -n 1 $@ | cut -d ' ' -f 3-` >> $@

results_nanopb_arm:
	ln -sf Makefile.arm platform/Makefile
	ln -sf platform-arm.h platform/platform.h
	rm -f test-nanopb/results_*
	make -C test-nanopb
	cp test-nanopb/results_all $@
	echo xxxx 2099-01-01 `tail -n 1 $@ | cut -d ' ' -f 3-` >> $@

results_pec_arm:
	ln -sf Makefile.arm platform/Makefile
	ln -sf platform-arm.h platform/platform.h
	rm -f test-protobuf-embedded-c/results_*
	make -C test-protobuf-embedded-c
	cp test-protobuf-embedded-c/results_all $@
	echo xxxx 2099-01-01 `tail -n 1 $@ | cut -d ' ' -f 3-` >> $@

results_pbc_arm:
	ln -sf Makefile.arm platform/Makefile
	ln -sf platform-arm.h platform/platform.h
	rm -f test-protobuf-c/results_*
	make -C test-protobuf-c
	cp test-protobuf-c/results_all $@
	echo xxxx 2012-01-01 `tail -n 1 $@ | cut -d ' ' -f 3-` >> $@
	echo xxxx 2099-01-01 `tail -n 1 $@ | cut -d ' ' -f 3-` >> $@

