@echo off

FOR /F "delims=." %%i in ("%3") do SET name=%%~nxi


python -u -m stog.commands.predict ^
    --archive-file %1 ^
    --weights-file %1/best.th ^
    --input-file %2/%3 ^
    --batch-size 16 ^
    --use-dataset-reader ^
    --cuda-device 0 ^
    --output-file %1/%name%.pred.txt ^
    --silent ^
    --beam-size 5 ^
    --predictor STOG
