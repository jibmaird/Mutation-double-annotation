#!/usr/bin/perl -w

use strict;

use vars qw ();

#my $result_d = "/home/jibmaird/Data/Experiments/Mutation/20/bert_out";
my $result_d = $ARGV[0];
my $reps = $ARGV[1];

opendir(D,$result_d)||die;
my @File = grep /^\d+\_\d+$/,readdir D;
closedir(D);

undef my %H;
foreach my $f (@File) {
    $_ = `grep \"MISC\" $result_d/$f/eval_entity.txt`;
    my @F = split(/\_/,$f);
    $H{$F[0]}{$F[1]} = $_;
}

foreach my $t (sort keys %H) {
    my $p = 0;
    my $r = 0;
    my $f1 = 0;
    foreach my $i (keys %{$H{$t}}) {
	$H{$t}{$i} =~ /precision:  (.*?)\%\; recall:  (.*?)\%\; FB1:  (.*?) /;
	$p += $1;
	$r += $2;
	$f1 += $3;
    }
    $p = $p / $reps;
    $r = $r / $reps;
    $f1 = $f1 / $reps;

    printf("\& %d \& %1.1f \& %1.1f \& %1.1f",$t,$p,$r,$f1);

    #standard deviation
    my $f_sd = 0;
    foreach my $i (keys %{$H{$t}}) {
	$H{$t}{$i} =~ /precision:  (.*?)\%\; recall:  (.*?)\%\; FB1:  (.*?) /;
	$_ = $3 - $f1;
	$_ = $_**2;
	$f_sd += $_;
    }
    $f_sd = sqrt($f_sd / $reps);
    #print "\nF-SCORE SD: $f_sd\n";
    printf(" \(%1.1f\)\\\\\n",$f_sd);

}
