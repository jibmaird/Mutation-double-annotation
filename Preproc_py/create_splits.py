import sys
import os,glob
import random

data_d = sys.argv[1]
#data_d = "/Users/david/Projects/Data/Experiments/Mutation/1"

if not os.path.isdir(data_d+"/splits"):
    os.mkdir(data_d+"/splits")

random.seed(30)
for t in ["train","test"]:
    T = t.capitalize()

    os.chdir(data_d+"/"+T)
    Files = glob.glob("*.conll")
    random.shuffle(Files)

    f = open(data_d+"/splits/"+t+"_dev.tsv",'w')
    i = 0
    for file in Files:
        i = i + 1
        if i > ((len(Files)-1) / 2):
            i = -100
            f.close()
            f = open(data_d+"/splits/"+t+".tsv",'w')
        f.write(file+"\n")
    f.close()

os.rename(data_d+"/splits/test_dev.tsv",data_d+"/splits/devel.tsv")

