#!/bin/bash
cd $(dirname $(realpath $0))    # change into script dir


MIN=-131072
MAX=131071
FACTOR=`dc -e "5k ${1:-1.0} 0.5 * p"`
OFFSET=`dc -e "5k ${2:-0.0} 65536 * p"`

../processing_tools/lut_conf3/lut_conf3 -N 4096 -m $MIN -M $MAX -F $FACTOR -O $OFFSET -B 0x60500000
../processing_tools/lut_conf3/lut_conf3 -N 4096 -m $MIN -M $MAX -F $FACTOR -O $OFFSET -B 0x60504000
../processing_tools/lut_conf3/lut_conf3 -N 4096 -m $MIN -M $MAX -F $FACTOR -O $OFFSET -B 0x60508000
../processing_tools/lut_conf3/lut_conf3 -N 4096 -m $MIN -M $MAX -F $FACTOR -O $OFFSET -B 0x6050C000
