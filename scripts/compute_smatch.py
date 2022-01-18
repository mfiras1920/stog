import argparse
import os
import subprocess
import pandas as pd

if __name__ == "__main__":
    smatch_dir = "tools/amr-evaluation-tool-enhanced"

    parser = argparse.ArgumentParser(description='Evaluate Validation Set')
    parser.add_argument('gold', help='path to gold dataset of AMR')
    parser.add_argument('pred', help='path to predicted result of AMR')
    parser.add_argument('out_dir', help='Folder to output AMR evaluation log')
    args = parser.parse_args()
    
    out_dir = os.path.join("..","..",args.out_dir)
    gold = args.gold.split("/")[-1]
    pred = args.pred.split("/")[-1]

    if args.gold != os.path.join(smatch_dir, gold):
        subprocess.call(f"cp {args.gold} {smatch_dir}")
    if args.pred != os.path.join(smatch_dir, pred):
        subprocess.call(f"cp {args.pred} {smatch_dir}")

    os.chdir(smatch_dir)

    res_dict = {}
    
    print("Calculating Standard Smatch")
    res = subprocess.check_output([
        "python2", "smatch/smatch.py", "--pr", 
        "-f",gold ,pred
    ]).decode().split()
    res_dict["smatch"] = dict(P=res[1], R=res[3], F=res[6][:-1])

    print("\nUnlabeling AMR")
    res = subprocess.check_output(["python2", "unlabel.py", gold]).decode()
    with open("1.tmp", "w", encoding="utf-8") as f:
        f.write(res)
    res = subprocess.check_output(["python2", "unlabel.py", pred]).decode()
    with open("2.tmp", "w", encoding="utf-8") as f:
        f.write(res)

    print("\nCalculate Unlabel Smatch")
    res = subprocess.check_output([
        "python2", "smatch/smatch.py", "--pr", 
        "-f", "1.tmp", "2.tmp"
    ]).decode().split()
    res_dict["unlabeled"] = dict(P=res[1], R=res[3], F=res[6][:-1])

    print("\nCalculate Finegrained smatch")
    res = subprocess.check_output([
        "python2", "smatch/smatch.py", "--ms", "--csv", "--pr", 
        "-f",gold ,pred
    ]).decode()
    with open(os.path.join(out_dir,"fine_grained.log"), "w", encoding="utf-8") as f:
        f.write(res)

    pd.DataFrame(res_dict).T.to_csv(os.path.join(out_dir, "overall.csv"))