#!/usr/bin/perl -w

use strict;

use vars qw ();

my $data_d = "/home/jibmaird/Data/Corpora/mutation-corpus-master/mutation-corpus-master/main/merged-corr";

my $out_d = "/home/jibmaird/Data/Experiments/Mutation/1";

for(my $i=0;$i<=7;$i++) {

    opendir(D,"$data_d/0$i")||die;
    my @File = grep /\d/,readdir D;
    closedir(D);

    foreach my $f (@File) {
	if ($i < 6) {
	    system("cp $data_d/0$i/$f $out_d/Train");
	}
	else {
	    system("cp $data_d/0$i/$f $out_d/Test");
	}
    }
}
