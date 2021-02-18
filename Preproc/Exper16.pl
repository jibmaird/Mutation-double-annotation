#!/usr/bin/perl -w

use strict;

use vars qw ();

my $h = $ENV{'HOME'};

my $data_d = "$h/Data/Experiments/Mutation";
my $alignment_exp = 15;
my $target_exp = 16;

if (not -e "$data_d/$target_exp") {
    system("mkdir $data_d/$target_exp");
}
if (not -e "$data_d/$target_exp/bio") {
    system("mkdir $data_d/$target_exp/bio");
}


#DEBUG
#system("./create_modified_train_stats.pl $data_d/$alignment_exp/top_matches_ists.10.txt $data_d/16");

my @F = ("5","10","20");
foreach my $t (@F) {
    if (not -e "$data_d/$target_exp/bio/$t") {
	system("mkdir $data_d/$target_exp/bio/$t");
    }

    system("./create_modified_train_bio.pl $data_d/$alignment_exp/top_matches_ists.$t.txt $data_d/$target_exp/bio/$t");
    system("cp $data_d/14/bio/devel.tsv $data_d/$target_exp/bio/$t");
    system("cp $data_d/14/bio/test.tsv $data_d/$target_exp/bio/$t");
    system("./filter_embeddings.pl $data_d/$target_exp/bio/$t");
}



#upload into aitu
system("scp -r $data_d/$target_exp dmiraola\@aitu.sl.cloud9.ibm.com:/home/dmiraola/Data/Experiments/Mutation");
