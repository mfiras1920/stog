#!/usr/bin/env bash

set -e

echo "Downloading artifacts."
# echo "Downloading bert base cased."
# mkdir -p data/bert-base-cased
# curl -O https://s3.amazonaws.com/models.huggingface.co/bert/bert-base-cased.tar.gz
# tar -xzvf bert-base-cased.tar.gz -C data/bert-base-cased
# curl -o data/bert-base-cased/bert-base-cased-vocab.txt \
#     https://s3.amazonaws.com/models.huggingface.co/bert/bert-base-cased-vocab.txt
# rm bert-base-cased.tar.gz

echo "Downloading indobert base uncased."
mkdir -p data/indobert-base-uncased
curl -L -o data/indobert-base-uncased/pytorch_model.bin \
    https://huggingface.co/indobenchmark/indobert-base-p1/resolve/main/pytorch_model.bin 
curl -L -o data/indobert-base-uncased/bert_config.json \
    https://huggingface.co/indobenchmark/indobert-base-p1/resolve/main/config.json
curl -L -o data/indobert-base-uncased/vocab.txt \
    https://huggingface.co/indobenchmark/indobert-base-p1/resolve/main/vocab.txt

echo "Downloading glove."
mkdir -p data/glove
curl -L -o data/glove/glove.840B.300d.zip \
    http://nlp.stanford.edu/data/wordvecs/glove.840B.300d.zip
curl -L -o data/glove/glove.id.4B.300d.zip \
    https://storage.googleapis.com/riset_amr/pretrained_model/word_embedding/glove-indo4B/glove.id.4B.300d.zip

echo "Downloading evaluation tools."
mkdir -p tools
git clone https://github.com/ChunchuanLv/amr-evaluation-tool-enhanced.git tools/amr-evaluation-tool-enhanced

echo "Download Utility Folder for Datasets."
mkdir -p data/AMR
curl -o data/AMR/amr_2.0_utils.tar.gz https://www.cs.jhu.edu/~s.zhang/data/AMR/amr_2.0_utils.tar.gz
curl -o data/AMR/amr_1.0_utils.tar.gz https://www.cs.jhu.edu/~s.zhang/data/AMR/amr_1.0_utils.tar.gz
curl -o data/AMR/amr_id_2.0_utils.tar.gz https://storage.googleapis.com/riset_amr/stog_id/amr_id_2.0_utils.tar.gz
pushd data/AMR
tar -xzvf amr_2.0_utils.tar.gz
tar -xzvf amr_1.0_utils.tar.gz
tar -xzvf amr_id_2.0_utils.tar.gz
rm amr_2.0_utils.tar.gz amr_1.0_utils.tar.gz amr_id_2.0_utils.tar.gz
popd

