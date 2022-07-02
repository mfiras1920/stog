# AMR Parsing as Sequence-to-Graph Transduction

Code for the AMR Parser 
in our ACL 2019 paper "[AMR Parsing as Sequence-to-Graph Transduction](https://arxiv.org/pdf/1905.08704.pdf)".   

If you find our code is useful, please cite:
```
@inproceedings{zhang-etal-2018-stog,
    title = "{AMR Parsing as Sequence-to-Graph Transduction}",
    author = "Zhang, Sheng and
      Ma, Xutai and
      Duh, Kevin and
      Van Durme, Benjamin",
    booktitle = "Proceedings of the 57th Annual Meeting of the Association for Computational Linguistics (Volume 1: Long Papers)",
    month = jul,
    year = "2019",
    address = "Florence, Italy",
    publisher = "Association for Computational Linguistics"
}
```

## 1. Environment Setup

The code has been tested on **Python 3.6** and **PyTorch 1.9**. And requires python 2.7 for evaluation (aliased as python2)
All other dependencies are listed in [requirements.txt](requirements.txt).

Via conda:
```bash
conda create -n stog python=3.6
conda activate stog
# Install pytorch first
conda install pytorch cudatoolkit=11.1 -c pytorch -c conda-forge
pip install -r requirements.txt
```

> Do not install Apex for NVIDIA as it will introduce problems casued by fused_layer_norm_cuda (which is not supported for `pytorch < 1.0.0`>)

## 2. Data Preparation

Before downloading artifact, consider choosing which language model to use and data version to use to reduce the download time, after that run the script. If you want to experiments, it is advisable to uncomment all of the lines in `scripts/download_artifacts.sh` to download all artifacts and models. But if you have models in mind, you can uncomment specific part of the script.
```bash
./scripts/download_artifacts.sh
```
### 2a. English AMR
Assuming that you're working on AMR 2.0 ([LDC2017T10](https://catalog.ldc.upenn.edu/LDC2017T10)),
unzip the corpus to `data/AMR/LDC2017T10`, and make sure it has the following structure:
```bash
(stog)$ tree data/AMR/LDC2017T10 -L 2
data/AMR/LDC2017T10
├── data
│   ├── alignments
│   ├── amrs
│   └── frames
├── docs
│   ├── AMR-alignment-format.txt
│   ├── amr-guidelines-v1.2.pdf
│   ├── file.tbl
│   ├── frameset.dtd
│   ├── PropBank-unification-notes.txt
│   └── README.txt
└── index.html
```

Prepare training/dev/test data:
```bash
./scripts/prepare_data.sh -v 2 -p data/AMR/LDC2017T10
```
### 2b. Indonesian AMR
If you're working with Indonesian AMR instead, either use the [pre-annotated AMR dataset](https://storage.googleapis.com/riset_amr/dataset/amr_id_2.0_preannot.tar.gz) from our repo. This file is annotated following Ilmy's method (using Anago for NER, CRFTagger for POS). If you're using preannotated dataset, skup the feature annotation part and go straight to preprocessing.

Or start from scratch using this [AMR ID 2.0](https://storage.googleapis.com/riset_amr/dataset/amr_id_v2.zip) dataset. If you're starting from scratch, refer to [amr_parser repo](https://github.com/banditelol/amr_parser) on how to annotate the features
## 3. Feature Annotation

We use [Stanford CoreNLP](https://stanfordnlp.github.io/CoreNLP/index.html) (version **3.9.2**) for lemmatizing, POS tagging, etc.

First, start a CoreNLP server following the [API documentation](https://stanfordnlp.github.io/CoreNLP/corenlp-server.html#api-documentation).

or you can also use docker to start a corenlp server using this script:
```bash
docker run -p 9000:9000 banditelol/corenlp
```

Then, annotate AMR sentences:
```bash
./scripts/annotate_features.sh data/AMR/amr_2.0
```

## 4. Data Preprocessing

Make sure the variables inside this script matches with what you have in your machine. Seriously, look inside the script to understand it before running the script. At least check if the variables match your environment.
```bash
# English AMR
./scripts/preprocess_2.0.sh

# Indonesian AMR
./scripts/preprocess_2.0_id.sh

# Indonesian AMR (Windows)
./scripts/preprocess_2.0_id.bat
```

## 5. Training

Make sure that you have at least two GeForce GTX TITAN X GPUs to train the full model using AMR 2.0. But if you're training for AMR ID, GT 950M with 4GB of memory can do decent works. To train with specific configuration, you can look inside `params/` folder to see the kind of configurations possible.

```bash
# python -u -m stog.commands.train params/[PARAMS_FILE]
python -u -m stog.commands.train params/stog_amr_2.0.yaml
# or training the best configuration for AMR ID
python -u -m stog.commands.train params/stog_amr_id_2.0_best.yaml
```

> If you get error parsing yaml, try installing `pyyaml==5.4.1`

## 6. Prediction

```bash
# python -u -m stog.commands.predict \
#     --archive-file [CHECKPOINT_FOLDER_] \
#     --weights-file [CHECKPOINT_FOLDER_]/best.th \
#     --input-file [PREPROCESSED_FILE] \
#     --batch-size 16 \
#     --use-dataset-reader \
#     --cuda-device 0 \
#     --output-file [CHECKPOINT_FOLDER]/test_id_trans.pred.txt \
#     --silent \
#     --beam-size 5 \
#     --predictor STOG
# For example:

python -u -m stog.commands.predict \
    --archive-file ckpt-amr-id-2.0-large-best-rerun/model.tar.gz \
    --weights-file ckpt-amr-id-2.0-large-best-rerun/best.th \
    --input-file data/AMR/amr_id_2.0/test.txt.features.preproc \
    --batch-size 16 \
    --use-dataset-reader \
    --cuda-device 0 \
    --output-file ckpt-amr-id-2.0-large-best-rerun/test.pred.txt \
    --silent \
    --beam-size 5 \
    --predictor STOG
```

## 7. Data Postprocessing    
```bash
./scripts/postprocess_2.0.sh test.pred.txt
```

For AMR ID use this instead:

```bash
./scripts/postprocess_2.0_id.sh {test_dir} {test_name}
```

## 8. Evaluation
Note that the evaluation tool works on `python2`, so please make sure `python2` is visible in your `$PATH`.
```bash
# ./scripts/compute_smatch.sh {checkpoint_dir} {pred_filename} {amr_data_dir}
./scripts/compute_smatch.sh ckpt-amr-id-2.0-large-best-rerun test.pred.txt data/AMR/amr_id_2.0
```

## Pre-trained Models
Here are pre-trained models: 
[ckpt-amr-2.0.tar.gz](https://www.cs.jhu.edu/~s.zhang/data/AMR/ckpt-amr-2.0.tar.gz) 
and [ckpt-amr-1.0.tar.gz](https://www.cs.jhu.edu/~s.zhang/data/AMR/ckpt-amr-1.0.tar.gz).
To use them for prediction, simply download & unzip them, and then run **Step 6-8**.

### Indonesian Language
For models trained on Indonesian Language, you could download the pretrained model [here](https://storage.googleapis.com/riset_amr/stog_id/ckpt-amr-id-2.0-large-best-rerun.zip). With the requirement of having the following models:
- IndoBert
- IndoGlove 4B

In case that you only need the pre-trained model prediction (i.e., `test.pred.txt`), you can find it in the download.

## Acknowledgements

We adopted some modules or code snippets from [AllenNLP](https://github.com/allenai/allennlp), 
[OpenNMT-py](https://github.com/OpenNMT/OpenNMT-py)
 and [NeuroNLP2](https://github.com/XuezheMax/NeuroNLP2).
Thanks to these open-source projects!

## License
[MIT](LICENSE)
