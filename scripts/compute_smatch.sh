#!/bin/bash

set -e

pred=$1
gold=$2
out_dir="../../${3:-""}"

pred_name="${pred##*/}"
gold_name="${gold##*/}"

cp $pred $gold tools/amr-evaluation-tool-enhanced
cd tools/amr-evaluation-tool-enhanced && ./evaluation.sh $pred_name $gold_name > "${out_dir}overall.log"
cp fine_grained.log $out_dir