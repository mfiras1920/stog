@echo off

set util_dir=data/AMR/amr_2.0_utils

set data_dir=data/AMR/amr_id_2.0
set test_dir=%1
set test_name=%2

echo "Expanding nodes..."
python -u -m stog.data.dataset_readers.amr_parsing.postprocess.expander ^
    --amr_files %test_dir%/%test_name% ^
    --util_dir %util_dir%
echo "Done."

python scripts/compute_smatch.py %test_dir%/%test_name%.expand %data_dir%/test.txt %test_dir%