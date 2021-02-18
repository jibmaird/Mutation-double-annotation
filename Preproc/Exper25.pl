#!/usr/bin/perl -w

use strict;

use vars qw ();

my $h = $ENV{'HOME'};

my $data_d = "$h/Data/Experiments/Mutation";

#system("cp -r $data_d/13 $data_d/25");
system("cp $data_d/14/bio/test.tsv $data_d/25/bio");
