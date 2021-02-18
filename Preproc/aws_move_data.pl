#!/usr/bin/perl -w

use strict;

my $endpoint = "http://s3.us-south.cloud-object-storage.appdomain.cloud";

#Upload NERdata 
my $data_d = $ARGV[0];
my $cloud_d = $ARGV[1];
#my $cloud_d = "biobert/NERdata/Mutation";

opendir(D,"$data_d")||die;
my @File = grep /^[^\.]/,readdir D;
closedir(D);
foreach my $f (@File) {
    print "$f\n";
    system("aws --endpoint-url=$endpoint s3 cp $data_d\/$f s3://cos-standard-28k\/$cloud_d/$f");
}

# Upload pretrained models
#my $data_d = "/home/jibmaird/Projects";
#my $pretrain_d = "biobert-pretrained/biobert_v1.0_pubmed";
#my $pretrain_d = "biobert-pretrained/biobert_v1.0_pubmed_pmc";
#opendir(D,"$data_d\/$pretrain_d")||die;
#my @File = grep /\w/,readdir D;
#closedir(D);
#foreach my $f (@File) {
#    system("aws --endpoint-url=$endpoint s3 cp $data_d\/$pretrain_d\/$f s3://cos-standard-28k\/$pretrain_d/$f");
#}
