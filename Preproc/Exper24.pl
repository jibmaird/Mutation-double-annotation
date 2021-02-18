#!/usr/bin/perl -w

use strict;

use vars qw ();

my $h = $ENV{'HOME'};

my $data_d = "$h/Data/Experiments/Mutation";

system("cp -r $data_d/14 $data_d/24");
