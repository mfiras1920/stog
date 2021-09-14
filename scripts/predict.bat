python -u -m stog.commands.predict ^
    --archive-file ckpt-amr-id-2.0-gpu ^
    --weights-file ckpt-amr-id-2.0-gpu/best.th ^
    --input-file data/AMR/amr_id_2.0/test.txt.features.preproc ^
    --batch-size 1 ^
    --use-dataset-reader ^
    --cuda-device 0 ^
    --output-file test.pred.txt ^
    --silent ^
    --beam-size 5 ^
    --predictor STOG