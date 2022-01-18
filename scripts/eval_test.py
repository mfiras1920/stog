import re
import argparse
import os
import subprocess

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description='Evaluate Validation Set')
    parser.add_argument('smatch_folder', help='smatch folder')
    parser.add_argument('gold', help='path to gold dataset of AMR')
    parser.add_argument('pred', help='path to predicted result of AMR')

    args = parser.parse_args()
    # print(args.accumulate(args.integers))
    gold = args.gold.split("/")[-1]
    pred = args.pred.split("/")[-1]

    if args.gold != os.path.join(args.smatch_folder, gold):
        subprocess.call(f"cp {args.gold} {args.smatch_folder}")
    if args.pred != os.path.join(args.smatch_folder, pred):
        subprocess.call(f"cp {args.pred} {args.smatch_folder}")

    os.chdir(args.smatch_folder)

    res = subprocess.check_output(
    [
        "python2", "smatch/smatch.py", "--pr", 
        "-f",gold ,pred
    ]).decode().split()
    print(" ".join([res[1], res[3], res[6][:-1]]) )
