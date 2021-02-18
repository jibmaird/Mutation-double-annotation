#!/usr/bin/perl -w

use strict;

use vars qw ();

my $h = $ENV{'HOME'};

my $data_d = "$h/Data/Experiments/Mutation";
my $alignment_exp = 17;
my $target_exp = 20;

if (not -e "$data_d/$target_exp") {
    system("mkdir $data_d/$target_exp");
}
if (not -e "$data_d/$target_exp/bio") {
    system("mkdir $data_d/$target_exp/bio");
}


#DEBUG
#system("./create_modified_train_stats.pl $data_d/$alignment_exp/top_matches_ists.10.txt $data_d/16");
#my @F = ("0");

my @F = ("100","200","500");

for(my $i=1;$i<=20;$i++) {
    foreach my $t (@F) {
	if (not -e "$data_d/$target_exp/bio/$t") {
	    system("mkdir $data_d/$target_exp/bio/$t");
	}
	if (not -e "$data_d/$target_exp/bio/$t/$i") {
	    system("mkdir $data_d/$target_exp/bio/$t/$i");
	}
	
	system("./create_modified_train_bio_thr_random.pl $data_d/$target_exp/bio/$t/$i $t");
	system("cp $data_d/14/bio/test.tsv $data_d/$target_exp/bio/$t/$i");
    }
}


#upload into aitu
#system("scp -r $data_d/$target_exp dmiraola\@aitu.sl.cloud9.ibm.com:/home/dmiraola/Data/Experiments/Mutation");
