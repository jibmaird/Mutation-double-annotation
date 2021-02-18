#!/usr/bin/perl -wd

use List::Util 'shuffle';

use strict;

use vars qw ();

my $data_d = "/home/jibmaird/Data/Corpora/mutation-corpus-master/mutation-corpus-master/main/indiv";

my $out_d = "/home/jibmaird/Data/Experiments/Mutation/2";

if (not -e $out_d) {
    system("mkdir $out_d");
}
if (not -e "$out_d/Train") {
    system("mkdir $out_d/Train");
}
if (not -e "$out_d/Test") {
    system("mkdir $out_d/Test");
}


undef my %H;

opendir(D,"$data_d")||die;
my @D1 = grep /\w/,readdir D;
closedir(D);

foreach my $d1 (@D1) {
    opendir(D,"$data_d/$d1")||die;
    my @D2 = grep /\w/,readdir D;
    closedir(D);
    foreach my $d2 (@D2) {
	next if $d2 eq "IAA";
	opendir(D,"$data_d/$d1/$d2")||die;
	my @File = grep /\w/,readdir D;
	closedir(D);

	foreach my $f (@File) {
	    $f =~s /\d\....$//;
	    $H{$f}{"$d1/$d2"} = 1;   
	}
    }
}

foreach my $f (keys %H) {
    my @F = shuffle(keys $H{$f});
    my @G = split(/\//,$F[0]);
    if ($G[1] < 6) {
	system("cp $data_d/$F[0]/$f\.txt $out_d/Train");
	system("cp $data_d/$F[0]/$f\.ann $out_d/Train");
    }
    else {
	system("cp $data_d/$F[0]/$f\.txt $out_d/Test");
	system("cp $data_d/$F[0]/$f\.ann $out_d/Test");
    }
}
