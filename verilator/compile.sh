CHIPYARD_PATH=/tools/reconfig/chisel/chipyard

riscv64-unknown-elf-gcc \
  -I$CHIPYARD_PATH/toolchains/riscv-tools/riscv-tests/env \
  -I$CHIPYARD_PATH/toolchains/riscv-tools/riscv-tests/benchmarks/common \
  -DPREALLOCATE=1 -mcmodel=medany -static -O0 -std=gnu99 -ffast-math -fno-common -fno-builtin-printf \
  -o test.riscv \
  ../test/PA.c \
  $CHIPYARD_PATH/toolchains/riscv-tools/riscv-tests/build/../benchmarks/common/syscalls.c \
  $CHIPYARD_PATH/toolchains/riscv-tools/riscv-tests/build/../benchmarks/common/crt.S \
  -static -nostdlib -nostartfiles -lm -lgcc -T \
  $CHIPYARD_PATH/toolchains/riscv-tools/riscv-tests/build/../benchmarks/common/test.ld


