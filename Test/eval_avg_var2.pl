#!/usr/bin/perl -w

use strict;

use vars qw ();

#my $result_d = "/home/jibmaird/Data/Experiments/Mutation/20/bert_out";
my $result_d = $ARGV[0];
my $reps = $ARGV[1];

opendir(D,$result_d)||die;
my @File = grep /^\d+$/,readdir D;
closedir(D);

undef my %H;
foreach my $f (@File) {
    $_ = `grep \"MISC\" $result_d/$f/eval_entity.txt`;
    $H{$f} = $_;
}

my $p = 0;
my $r = 0;
my $f1 = 0;
foreach my $i (sort keys %H) {
    $H{$i} =~ /precision:  (.*?)\%\; recall:  (.*?)\%\; FB1:  (.*?) /;
    $p += $1;
    $r += $2;
    $f1 += $3;
}
$p = $p / $reps;
$r = $r / $reps;
$f1 = $f1 / $reps;

printf("\& %1.1f \& %1.1f \& %1.1f",$p,$r,$f1);

#standard deviation
my $f_sd = 0;
foreach my $i (keys %H) {
    $H{$i} =~ /precision:  (.*?)\%\; recall:  (.*?)\%\; FB1:  (.*?) /;

    $_ = $3 - $f1;
    $_ = $_**2;
    $f_sd += $_;
}
$f_sd = sqrt($f_sd / $reps);
#print "\nF-SCORE SD: $f_sd\n";
printf(" \(%1.1f\)\\\\\n",$f_sd);
