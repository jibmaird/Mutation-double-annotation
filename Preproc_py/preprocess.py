import os

data_d = "/Users/david/Projects/Data/Experiments/Mutation/"

#os.system("create_train_test.py") #Exper 1
#os.system("create_train_test_partial.py"); #Exper 2

#os.chdir("/Users/david/Projects/brat/tools")
#for t in ["Train","Test"]:
#    for exp in range(1,3):
#        run = "python anntoconll.py "+data_d+str(exp)+"/"+t+"/*.txt"
#        os.system(run)

#os.chdir("/Users/david/Projects/Mutation-double-annotation/Preproc_py")

#run = "python create_splits.py "+data_d+"1"
#os.system(run)

for exp in range(1,3):
    d1 = data_d + "/"+str(exp)
    d2 = data_d + "/1/splits"
    run = "python create_tsv_files.py "+d1+" "+d2
    os.system(run)
    
#system("./single_class.pl $data_d/conll");
#system("./create_3_files.pl $data_d"); #for residual-lstm
#system("./simple_BIO.pl $data_d");
