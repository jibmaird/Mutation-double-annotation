#!/usr/bin/perl -w

use strict;
use vars qw ();

use List::Util qw/shuffle/;

my $data_d = $ARGV[0];

if (not -e "$data_d/splits") {
    system("mkdir $data_d/splits");}

my @T = ("train","test");

foreach my $t (@T) {

    my $T = ucfirst($t);

    opendir(D,"$data_d/$T")||die;
    my @File = grep /\.conll/,readdir D;
    closedir(D);
    
    @File = shuffle @File;

    my $out_f = "$data_d/splits/$t\_dev.tsv";
    open(O,">$out_f")||die;
    my $i = 0;
    foreach my $f (@File) {
	$i++;
	if ($i > $#File / 2) {
	    $i = -100;
	    close(O);
	    open(O,">$data_d/splits/$t.tsv")||die;
	}
	print O "$f\n";
    }
    close(O);
}
system("mv $data_d/splits/test_dev.tsv $data_d/splits/devel.tsv");
