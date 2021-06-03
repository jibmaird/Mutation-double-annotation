import sys
import glob
import os

data_d = sys.argv[1]
split_d = sys.argv[2]
out_d = data_d + "/conll"

if not os.path.isdir(out_d):
    os.mkdir(out_d)

os.chdir(split_d)
Files = glob.glob("*")

for file in Files:
    dir_f = open(split_d+"/"+file,'r')
    out_f = open(out_d+"/"+file,'w')

    for l in dir_f:
        l = l.rstrip()

        if 'train' in file:
            in_f = open(data_d+"/Train/"+l,'r')
        else:
            in_f = open(data_d+"/Test/"+l,'r')

        for line in in_f:
            out_f.write(line)
        in_f.close()

    dir_f.close()
    out_f.close()
