:: ############### AMR v2.0 ################
:: Directory where intermediate utils will be saved to speed up processing.
set util_dir=data/AMR/amr_id_2.0_utils

:: AMR data with **features**
set data_dir=data/AMR/amr_id_2.0
set train_data=%data_dir%/train.txt.features
set dev_data=%data_dir%/dev.txt.features
set test_data=%data_dir%/test.txt.features

:: ========== Set the above variables correctly ==========

:: printf "Cleaning inputs...`date`\n"
:: python -u -m stog.data.dataset_readers.amr_parsing.preprocess.input_cleaner \
::     --amr_files ${train_data} ${dev_data} ${test_data}
:: printf "Done.`date`\n\n"

which python

echo "Recategorizing subgraphs...`date`\n"
python -u -m stog.data.dataset_readers.amr_parsing.preprocess.recategorizer ^
    --amr_train_file %train_data% ^
    --dump_dir %util_dir% ^
    --amr_files %train_data% %dev_data% ^
    --build_utils

echo "Anonymizing subgraph    \n"
python -u -m stog.data.dataset_readers.amr_parsing.preprocess.text_anonymizor ^
    --amr_file %test_data% ^
    --util_dir %util_dir%
echo "Done.`date`\n\n"

@REM printf "Removing senses...`date`\n"
@REM python -u -m stog.data.dataset_readers.amr_parsing.preprocess.sense_remover \
@REM     --util_dir ${util_dir} \
@REM     --amr_files ${train_data}.input_clean.recategorize \
@REM     ${dev_data}.input_clean.recategorize \
@REM     ${test_data}.input_clean.recategorize
@REM     #--amr_files ${dev_data}.input_clean.recategorize \
@REM     #${test_data}.input_clean.recategorize
    
@REM printf "Done.`date`\n\n"

echo "Renaming preprocessed files...`date`\n"
mv %test_data%.recategorize %test_data%.preproc
mv %train_data%.recategorize %train_data%.preproc
mv %dev_data%.recategorize %dev_data%.preproc