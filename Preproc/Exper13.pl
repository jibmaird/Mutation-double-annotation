#!/usr/bin/perl -w

my $pre_adj = "/home/jibmaird/Data/Experiments/Mutation/2";
my $data_d = "/home/jibmaird/Data/Experiments/Mutation/13";
my $cloud_d = "biobert/NERdata/Mutation/13";
my $yaml_f = "/home/jibmaird/Projects/biobert/Mutation-train.yaml";

#system("cp -r $pre_adj/conll $data_d");

#system("./simple_BIO.pl $data_d");
system("mv $data_d/bio/train_dev.tsv $data_d/bio/devel.tsv");
system("mv $data_d/bio/train.tsv $data_d/bio/train_dev.tsv");

#upload into aitu-server


#Upload into DLaaS
#system("./aws_move_data.pl $data_d/bio $cloud_d");
#Change yaml
#open(I,$yaml_f)||die;
#open(O,">$yaml_f~")||die;
#while(<I>) {
#    s /\-\-data_dir\=(.*?) /\-\-data_dir\=\$\{DATA_DIR\}\/$cloud_d\/ /;
#    print O;
#}
#close(I);
#close(O);
#system("mv $yaml_f~ $yaml_f");
