#!/usr/bin/perl -w

#my $data_d = "/home/jibmaird/Data/Experiments/Mutation/1/bio";
#my $data_d = "/home/jibmaird/Data/Experiments/Mutation/2/bio";

my $data_d = "/home/jibmaird/Data/Experiments/Mutation/1";
my $data_d_exp2 = "/home/jibmaird/Data/Experiments/Mutation/2";

my $cloud_d = "biobert/NERdata/Mutation/1";

#system("./create_train_test.pl"); #Exper 1
#system("./create_train_test_partial.pl"); #Exper 2

#Convert into CONLL format
chdir("/home/jibmaird/Projects/ADE/EntityExtraction/brat/tools");
system("python anntoconll.py $data_d/Train/*.txt");
#system("python anntoconll.py $data_d/Test/*.txt");

#chdir("/home/jibmaird/Projects/Mutations/Preproc");
#system("./create_splits.pl $data_d");
#system("./create_tsv_files.pl $data_d_exp2 $data_d/splits $data_d_exp2/conll");
#system("./single_class.pl $data_d/conll");
#system("./create_3_files.pl $data_d"); #for residual-lstm
#system("./simple_BIO.pl $data_d");

#Upload into DLaaS
#system("./aws_move_data.pl $data_d $cloud_d");
