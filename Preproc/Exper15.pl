#!/usr/bin/perl -w

my $h = $ENV{'HOME'};

my $adj = "$h/Data/Experiments/Mutation/1";
my $preadj = "$h/Data/Experiments/Mutation/2";
my $data_d = "$h/Data/Experiments/Mutation/15";
my $cloud_d = "biobert/NERdata/Mutation/15";
my $yaml_f = "/home/jibmaird/Projects/biobert/Mutation-train.yaml";

if (not -e $data_d) {
    system("mkdir $data_d");
}

#system("cp -r $preadj/conll $data_d/conll");
#system("./simple_BIO.pl $data_d");
#system("mv $data_d/bio/train_dev.tsv $data_d/bio/devel.tsv");
#system("mv $data_d/bio/train.tsv $data_d/bio/train_dev.tsv");

system("mkdir $data_d/adj");
system("cp -r $adj/conll $data_d/adj/conll");
system("./simple_BIO.pl $data_d/adj");
system("mv $data_d/adj/bio/devel.tsv $data_d/bio/test.tsv");

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
