import sys,glob,os,re

data_d = sys.argv[1]

os.chdir(data_d)    
Files = glob.glob("*.tsv")

for f in Files:
    in_f = open(data_d+"/"+f,'r')
    out_f = open(data_d+"/"+f+"~",'w')

    for line in in_f:
        line = line.rstrip()
        if re.search("^[BI]\-",line):
            line = re.sub(r"^([BI])\-.*?\_Mutation", r"\1-Mutation",line)
            line = re.sub(r"^([BI])\-dbSNP", r"\1-Mutation",line)
            if not re.search("^[BI]\-Mutation",line):
                line = re.sub(r"^([BI])\-.*?\t", r"O\t",line)
        out_f.write(line+"\n")

    in_f.close()
    out_f.close()
    os.rename(data_d+"/"+f+"~",data_d+"/"+f)
