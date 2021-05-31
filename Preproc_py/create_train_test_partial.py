import os,glob
from shutil import copy
import re
import random

data_d = "/Users/david/Projects/Data/Corpora/amia-18-mutation-corpus/data-preadjudicated/";
out_d = "/Users/david/Projects/Data/Experiments/Mutation/2/";

if not os.path.isdir(out_d):
    os.mkdir(out_d)
    os.mkdir(out_d+"/Train")
    os.mkdir(out_d+"/Test")

os.chdir(data_d)
D1 = glob.glob("*")

D = {}

for d1 in D1:
    os.chdir(data_d+d1)
    D2 = glob.glob("*")
    for d2 in D2:
        if d2 == "IAA":
            continue
        os.chdir(data_d+d1+"/"+d2)
        Files = glob.glob("*")
        for f in Files:
            f = re.sub(r"\....","",f)
            if not f in D.keys():
                D[f] = {}
            D[f][d1+"/"+d2] = 1

random.seed(30)
for f in D:
    L = list(D[f].keys())
    random.shuffle(L)
    L2 = L[0].split("/")
    if (int(L2[1]) < 6):
        copy(data_d+L[0]+"/"+f+".txt",out_d+"/Train")
        copy(data_d+L[0]+"/"+f+".ann",out_d+"/Train")
    else:
        copy(data_d+L[0]+"/"+f+".txt",out_d+"/Test")
        copy(data_d+L[0]+"/"+f+".ann",out_d+"/Test")

