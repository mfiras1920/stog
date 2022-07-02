#!/bin/bash

set -e
model_dir=$1
pred_name=$2
data_dir=$3
pred=${model_dir}/${pred_name}
gold=${data_dir}/test.txt.features

cp $pred $gold tools/amr-evaluation-tool-enhanced
mkdir -p ${model_dir}/test_output
printf "Computing Finegrained Smatch\n\n"
cd tools/amr-evaluation-tool-enhanced
python2 smatch/smatch.py --pr --ms -f ${pred_name}  test.txt.features > ../../${model_dir}/test_output/finegrained.txt
python2 smatch/smatch.py --raw --ms -f ${pred_name}  test.txt.features > ../../${model_dir}/test_output/finegrained_raw.txt
printf "Finished, Computing Overall Smatch\n\n"
./evaluation.sh ${pred_name}  test.txt.features | tee ../../${model_dir}/test_output/summary.txt
