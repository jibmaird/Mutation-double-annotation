#!/usr/bin/perl -w

use strict;

use vars qw ();

#my $log_f = "/home/jibmaird/Projects/biobert-pretrained/biobert_v1.0_pubmed/training-rZBJalxZg/top_matches.txt";
my $log_f = $ARGV[0];
my $single_ann = "/home/jibmaird/Data/Experiments/Mutation/1/Train-sent-ann";
my $gold_ann = "/home/jibmaird/Data/Experiments/Mutation/2/Train-sent-ann";

#Measure total differences
opendir(D,$single_ann)||die;
my @File = grep /\.txt/,readdir D;
closedir(D);

my $diff = 0;
my $tot = 0;
undef my %Diff;
foreach my $f (@File) {
    $_ = `diff $single_ann/$f $gold_ann/$f`;
    if ($_ ne "") {
#	print "$f\n";
	$diff++;
	$Diff{$f} = 1;
    }
    $tot++;
}
print "* FULL TRAINING CORPUS\n";
print "TOTAL SENTENCES: $tot\n";
print "DIFFERENT LABEL IN GOLD: $diff\n";
$_ = $diff / $tot;
print "$_\n\n";

#Measure differences in found similar sentences

$tot = 0;
$diff = 0;
open(I,$log_f)||die;
while(<I>) {
    chomp;
    if (/Similar sentence \d: (.*?) Score/) {
	$tot++;
	if (defined $Diff{$1}) {
#	    print "$1\n";
	    $diff++;
	}
    } 
}
close(I);

print "* SIMILAR SENTENCES TO ANNOTATOR ERRORS:\n";
print "TOTAL SIMILAR SENTENCES IN TRAIN: $tot\n";
print "DIFFERENT LABEL IN GOLD: $diff\n";
my $prec = $diff / $tot;
print "PREC: $prec\n";
my $rec = $diff / 210;
print "REC: $rec\n\n";
$_ = 2 * ($prec * $rec) / ($prec + $rec);
print "F-SC: $_\n";
