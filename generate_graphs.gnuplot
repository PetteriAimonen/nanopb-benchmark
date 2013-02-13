set xdata time
set timefmt x "%Y-%m-%d"
set format x "%Y"
set terminal pngcairo

set xtics nomirror
set ytics nomirror

set xrange ["2011-12-01":"2013-04-01"]
set xtics 86400*365
set mxtics 12

set output 'publish/arm_time.png'
set yrange [0:100000]
set ylabel 'cycles'
set title 'Execution time (ARM Cortex-M3)'
plot 'results_nanopb_arm' using 2:3 title 'nanopb' with steps lt 1, \
    'results_nanopb_arm' using 2:3 notitle with points lt 1 pt 7, \
    'results_nanopb_arm' every 2 using 2:($3+3000):1 notitle with labels, \
    'results_pec_arm' using 2:3 title 'protobuf-embedded-c' with steps lt 2, \
    'results_pec_arm' using 2:3 notitle with points lt 2 pt 7, \
    'results_pec_arm' using 2:($3+3000):1 notitle with labels, \
    'results_pbc_arm' using 2:3 title 'protobuf-c' with steps lt 3

set output 'publish/arm_ram.png'
set yrange [0:6000]
set ylabel 'bytes'
set title 'RAM usage (ARM Cortex-M3)'
plot 'results_nanopb_arm' using 2:5 title 'nanopb' with steps lt 1, \
    'results_nanopb_arm' using 2:5 notitle with points lt 1 pt 7, \
    'results_nanopb_arm' every 2 using 2:($5+200):1 notitle with labels, \
    'results_pec_arm' using 2:5 title 'protobuf-embedded-c' with steps lt 2, \
    'results_pec_arm' using 2:5 notitle with points lt 2 pt 7, \
    'results_pec_arm' using 2:($5-200):1 notitle with labels, \
    'results_pbc_arm' using 2:($5 + $6) title 'protobuf-c (inc. heap)' with steps lt 3

set output 'publish/arm_code.png'
set yrange [0:20000]
set ylabel 'bytes'
set title 'Compiled size (ARM Cortex-M3)'
plot 'results_nanopb_arm' using 2:4 title 'nanopb' with steps lt 1, \
    'results_nanopb_arm' using 2:4 notitle with points lt 1 pt 7, \
    'results_nanopb_arm' every 2 using 2:($4-800):1 notitle with labels, \
    'results_pec_arm' using 2:4 title 'protobuf-embedded-c' with steps lt 2, \
    'results_pec_arm' using 2:4 notitle with points lt 2 pt 7, \
    'results_pec_arm' using 2:($4+800):1 notitle with labels, \
    'results_pbc_arm' using 2:4 title 'protobuf-c' with steps lt 3

set output 'publish/avr_time.png'
set yrange [0:400000]
set ylabel 'cycles'
set title 'Execution time (Atmel ATmega128)'
plot 'results_nanopb_avr' using 2:3 title 'nanopb' with steps, \
    'results_nanopb_avr' using 2:3 notitle with points lt 1 pt 7, \
    'results_nanopb_avr' every 2 using 2:($3+15000):1 notitle with labels, \
    'results_pec_avr' using 2:3 title 'protobuf-embedded-c' with steps lt 2, \
    'results_pec_avr' using 2:3 notitle with points lt 2 pt 7, \
    'results_pec_avr' using 2:($3+15000):1 notitle with labels

set output 'publish/avr_ram.png'
set yrange [0:1500]
set ylabel 'bytes'
set title 'Stack usage (Atmel ATmega128)'
plot 'results_nanopb_avr' using 2:5 title 'nanopb' with steps, \
    'results_nanopb_avr' using 2:5 notitle with points lt 1 pt 7, \
    'results_nanopb_avr' every 2 using 2:($5+50):1 notitle with labels, \
    'results_pec_avr' using 2:5 title 'protobuf-embedded-c' with steps lt 2, \
    'results_pec_avr' using 2:5 notitle with points lt 2 pt 7, \
    'results_pec_avr' using 2:($5-50):1 notitle with labels

set output 'publish/avr_code.png'
set yrange [0:20000]
set ylabel 'bytes'
set title 'Compiled size (Atmel ATmega128)'
plot 'results_nanopb_avr' using 2:4 title 'nanopb' with steps, \
    'results_nanopb_avr' using 2:4 notitle with points lt 1 pt 7, \
    'results_nanopb_avr' every 2 using 2:($4+600):1 notitle with labels, \
    'results_pec_avr' using 2:4 title 'protobuf-embedded-c' with steps lt 2, \
    'results_pec_avr' using 2:4 notitle with points lt 2 pt 7, \
    'results_pec_avr' using 2:($4+600):1 notitle with labels

