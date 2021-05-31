import os

#os.system("create_train_test.py") #Exper 1
#os.system("create_train_test_partial.py"); #Exper 2

#os.chdir("/Users/david/Projects/brat/tools")
#for t in ["Train","Test"]:
#    for exp in range(1,2):
#        run = "python anntoconll.py /Users/david/Projects/Data/Experiments/Mutation/"+str(exp)+"/"+t+"/*.txt"
#        os.system(run)

os.chdir("/Users/david/Projects/Mutation-double-annotation/Preproc_py")

#system("./create_splits.pl $data_d");
#system("./create_tsv_files.pl $data_d_exp2 $data_d/splits $data_d_exp2/conll");
#system("./single_class.pl $data_d/conll");
#system("./create_3_files.pl $data_d"); #for residual-lstm
#system("./simple_BIO.pl $data_d");
