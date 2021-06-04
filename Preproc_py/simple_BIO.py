import os,sys,glob
import re

data_d = sys.argv[1]
in_d = data_d + "/conll/"
out_d = data_d + "/bio/"

if not os.path.isdir(out_d):
    os.mkdir(out_d)

os.chdir(in_d)
Files = glob.glob("*")

for f in Files:
    in_f = open(in_d + f,'r')
    out_f = open(out_d + f,'w')
    for line in in_f:
        line = line.rstrip()
        L = line.split("\t")
        m = re.search("^([BI])-Mutation",line)
        if m:
            out_f.write(L[3]+"\t"+m.group(1)+"\n")
        elif not line == "":
            out_f.write(L[3]+"\tO\n")
        else:
            out_f.write(line+"\n")
    in_f.close()
    out_f.close()

