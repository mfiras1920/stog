#!/usr/bin/env bash

set -e

# echo "Downloading Bert Base Cased"
# mkdir -p data/bert-base-cased
# curl -O https://s3.amazonaws.com/models.huggingface.co/bert/bert-base-cased.tar.gz
# tar -xzvf bert-base-cased.tar.gz -C data/bert-base-cased
# curl -o data/bert-base-cased/bert-base-cased-vocab.txt \
#     https://s3.amazonaws.com/models.huggingface.co/bert/bert-base-cased-vocab.txt
# rm bert-base-cased.tar.gz

# echo "Downloading Bert Base Multilingual Cased"
# mkdir -p data/bert-base-multilingual-cased
# curl -L -o data/bert-base-multilingual-cased/pytorch_model.bin \
#     https://huggingface.co/bert-base-multilingual-cased/resolve/main/pytorch_model.bin
# curl -L -o data/bert-base-multilingual-cased/bert_config.json \
#     https://huggingface.co/bert-base-multilingual-cased/resolve/main/config.json
# curl -L -o data/bert-base-multilingual-cased/vocab.txt \
#     https://huggingface.co/bert-base-multilingual-cased/resolve/main/vocab.txt

# echo "Downloading Bert Large Cased"
# mkdir -p data/bert-large-cased
# curl -O https://s3.amazonaws.com/models.huggingface.co/bert/bert-large-cased.tar.gz
# tar -xzvf bert-large-cased.tar.gz -C data/bert-large-cased
# curl -o data/bert-large-cased/bert-large-cased-vocab.txt \
#     https://s3.amazonaws.com/models.huggingface.co/bert/bert-large-cased-vocab.txt
# rm bert-large-cased.tar.gz

# echo "Downloading IndoBert Base Uncased."
# mkdir -p data/indobert-base-uncased
# curl -L -o data/indobert-base-uncased/pytorch_model.bin \
#     https://huggingface.co/indobenchmark/indobert-base-p2/resolve/main/pytorch_model.bin 
# curl -L -o data/indobert-base-uncased/bert_config.json \
#     https://huggingface.co/indobenchmark/indobert-base-p2/resolve/main/config.json
# curl -L -o data/indobert-base-uncased/vocab.txt \
#     https://huggingface.co/indobenchmark/indobert-base-p2/resolve/main/vocab.txt

# echo "Downloading IndoBert Large Uncased.P1"
# mkdir -p data/indobert-large-uncased-p1
# curl -L -o data/indobert-large-uncased-p1/pytorch_model.bin \
#     https://huggingface.co/indobenchmark/indobert-large-p1/resolve/main/pytorch_model.bin 
# curl -L -o data/indobert-large-uncased-p1/bert_config.json \
#     https://huggingface.co/indobenchmark/indobert-large-p1/resolve/main/config.json
# curl -L -o data/indobert-large-uncased-p1/vocab.txt \
#     https://huggingface.co/indobenchmark/indobert-large-p1/resolve/main/vocab.txt

# echo "Downloading IndoBert Large Uncased.P2"
# mkdir -p data/indobert-large-uncased
# curl -L -o data/indobert-large-uncased/pytorch_model.bin \
#     https://huggingface.co/indobenchmark/indobert-large-p2/resolve/main/pytorch_model.bin 
# curl -L -o data/indobert-large-uncased/bert_config.json \
#     https://huggingface.co/indobenchmark/indobert-large-p2/resolve/main/config.json
# curl -L -o data/indobert-large-uncased/vocab.txt \
#     https://huggingface.co/indobenchmark/indobert-large-p2/resolve/main/vocab.txt

echo "Downloading IndoT5 small"
mkdir -p data/indot5-small
curl -L -o data/indot5-small/pytorch_model.bin \
    https://huggingface.co/Wikidepia/IndoT5-small/resolve/main/pytorch_model.bin 
curl -L -o data/indot5-small/config.json \
    https://huggingface.co/Wikidepia/IndoT5-small/resolve/main/config.json
curl -L -o data/indot5-small/spiece.model \
    https://huggingface.co/Wikidepia/IndoT5-small/resolve/main/spiece.model

# echo "Downloading IndoT5 base"
# mkdir -p data/indot5-base
# curl -L -o data/indot5-base/pytorch_model.bin \
#     https://huggingface.co/Wikidepia/IndoT5-base/resolve/main/pytorch_model.bin 
# curl -L -o data/indot5-base/config.json \
#     https://huggingface.co/Wikidepia/IndoT5-base/resolve/main/config.json
# curl -L -o data/indot5-base/spiece.model \
#     https://huggingface.co/Wikidepia/IndoT5-base/resolve/main/spiece.model

echo "Downloading IndoT5 large"
mkdir -p data/indot5-large
curl -L -o data/indot5-large/pytorch_model.bin \
    https://huggingface.co/Wikidepia/IndoT5-large/resolve/main/pytorch_model.bin 
curl -L -o data/indot5-large/config.json \
    https://huggingface.co/Wikidepia/IndoT5-large/resolve/main/config.json
curl -L -o data/indot5-large/spiece.model \
    https://huggingface.co/Wikidepia/IndoT5-large/resolve/main/spiece.model

echo "Downloading mT5 large"
mkdir -p data/mt5-large
curl -L -o data/mt5-large/pytorch_model.bin \
    https://huggingface.co/google/mt5-large/resolve/main/pytorch_model.bin 
curl -L -o data/mt5-large/config.json \
    https://huggingface.co/google/mt5-large/resolve/main/config.json
curl -L -o data/mt5-large/spiece.model \
    https://huggingface.co/google/mt5-large/resolve/main/spiece.model

echo "Downloading glove 840B"
mkdir -p data/glove
curl -L -o data/glove/glove.840B.300d.zip \
    http://nlp.stanford.edu/data/wordvecs/glove.840B.300d.zip

# echo "Downloading glove Indo 4B"
# mkdir -p data/glove
# curl -L -o data/glove/glove.id.4B.300d.zip \
#     https://storage.googleapis.com/riset_amr/pretrained_model/word_embedding/glove-indo4B/glove.id.4B.300d.zip

echo "Downloading evaluation tools."
mkdir -p tools
# Using banditelol's fork to accomodate raw match output (instead of calculated P, R, F output)
git clone https://github.com/banditelol/amr-evaluation-tool-enhanced.git tools/amr-evaluation-tool-enhanced

echo "Download Utility Folder for Datasets."
mkdir -p data/AMR

echo "Downloading Utility For AMR 2.0."
curl -o data/AMR/amr_2.0_utils.tar.gz https://www.cs.jhu.edu/~s.zhang/data/AMR/amr_2.0_utils.tar.gz
# echo "Downloading Utility For AMR 1.0."
# curl -o data/AMR/amr_1.0_utils.tar.gz https://www.cs.jhu.edu/~s.zhang/data/AMR/amr_1.0_utils.tar.gz
echo "Downloading Utility For AMR Indonesia 2.0."
curl -o data/AMR/amr_id_2.0_utils.tar.gz https://storage.googleapis.com/riset_amr/stog_id/amr_id_2.0_utils.tar.gz

pushd data/AMR
tar -xzvf amr_2.0_utils.tar.gz
# tar -xzvf amr_1.0_utils.tar.gz
tar -xzvf amr_id_2.0_utils.tar.gz
rm amr_2.0_utils.tar.gz amr_id_2.0_utils.tar.gz
popd

