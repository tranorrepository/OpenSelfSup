#!/usr/bin/env bash
set -x

PYTHON=${PYTHON:-"python"}
CFG=$1
GPUS=$2
PY_ARGS=${@:3} # "--checkpoint $CHECKPOINT --pretrained $PRETRAINED"
PORT=${PORT:-29500}

WORK_DIR=$(echo ${CFG%.*} | sed -e "s/configs/work_dirs/g")/
$PYTHON -m torch.distributed.launch --nproc_per_node=$GPUS --master_port=$PORT \
    tools/extract.py $CFG --layer-ind "0,1,2,3,4" --work_dir $WORK_DIR \
    --launcher pytorch ${PY_ARGS}
