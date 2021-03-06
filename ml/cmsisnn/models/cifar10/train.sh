#!/usr/bin/env sh
set -e

DIR=models/cifar10
TOOLS=./caffe/build/tools

$TOOLS/caffe train \
    --solver=models/cifar10/cifar10_solver.prototxt $@ 2>&1 | tee $DIR/training.log

# reduce learning rate by factor of 10
$TOOLS/caffe train \
    --solver=models/cifar10/cifar10_solver_lr1.prototxt \
    --snapshot=models/cifar10/cifar10_iter_60000.solverstate.h5 $@  2>&1 | tee -a $DIR/training.log

# reduce learning rate by factor of 10
$TOOLS/caffe train \
    --solver=models/cifar10/cifar10_solver_lr2.prototxt \
    --snapshot=models/cifar10/cifar10_iter_65000.solverstate.h5 $@  2>&1 | tee -a $DIR/training.log
