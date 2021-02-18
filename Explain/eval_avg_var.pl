#!/usr/bin/perl -w

use strict;

use vars qw ();

#my $result_d = "/home/jibmaird/Data/Experiments/Mutation/20/bert_out";
my $result_d = $ARGV[0];
my $thr = $ARGV[1];

opendir(D,$result_d)||die;
my @File = grep /global$thr\.\d\./,readdir D;
closedir(D);

undef my %H;
foreach my $f (@File) {
    $_ = `grep \"&\" $result_d/$f`;
    $H{$f} = $_;
}

my $p = 0;
my $r = 0;
my $f1 = 0;
foreach my $i (sort keys %H) {
    $H{$i} =~ /^\& (.*?) \& (.*?) \& (.*?)\\\\/;
    $p += $1;
    $r += $2;
    $f1 += $3;
}
$p = $p / 5;
$r = $r / 5;
$f1 = $f1 / 5;

printf("\& %1.1f \& %1.1f \& %1.1f",$p,$r,$f1);

#standard deviation
my $f_sd = 0;
foreach my $i (keys %H) {
    $H{$i} =~ /^\& (.*?) \& (.*?) \& (.*?)\\\\/;

    $_ = $3 - $f1;
    $_ = $_**2;
    $f_sd += $_;
}
$f_sd = sqrt($f_sd / 5);
#print "\nF-SCORE SD: $f_sd\n";
printf(" \(%1.1f\)\\\\\n",$f_sd);
