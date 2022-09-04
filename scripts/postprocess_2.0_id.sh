#!/usr/bin/env bash

set -e

# Directory where intermediate utils will be saved to speed up processing.
util_dir=data/AMR/amr_id_2.0_utils

# AMR data with **features**
data_dir=data/AMR/amr_id_2.0
test_dir=$1
test_name=$2

# ========== Set the above variables correctly ==========
printf "${test_dir}/${test_name}"
printf "Expanding nodes...`date`\n"
python3 -u -m stog.data.dataset_readers.amr_parsing.postprocess.expander \
    --amr_files ${test_dir}/${test_name} \
    --util_dir ${util_dir}
printf "Done.`date`\n\n"

# python scripts/compute_smatch.py ${test_dir}/${test_name}.expand ${data_dir}/test.txt ${test_dir}