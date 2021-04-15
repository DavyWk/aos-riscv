CHIPYARD_PATH=/tools/reconfig/chisel/chipyard

BINARY=test.riscv
EXE=./simulator-chipyard-SmallBoomConfig
OUTPUT=test.out

set -o pipefail && $EXE +max-cycles=10000000 +verbose $BINARY 3>&1 1>&2 2>&3 | spike-dasm > $OUTPUT
