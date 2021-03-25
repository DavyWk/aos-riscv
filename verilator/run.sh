CHIPYARD_PATH=$SETME

BINARY=$CHIPYARD_PATH/toolchains/riscv-tools/riscv-tests/build/benchmarks/test.riscv
EXE=$CHIPYARD_PATH/sims/verilator/simulator-chipyard-SmallBoomConfig
OUTPUT=test.out

set -o pipefail && $EXE +max-cycles=10000000 +verbose $BINARY 3>&1 1>&2 2>&3 | spike-dasm > $OUTPUT
