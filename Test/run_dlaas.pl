#!/usr/bin/perl -w

use strict;

use vars qw ();

chdir("/home/jibmaird/Projects/biobert");

my @F = ("Mutation-train");
foreach (@F) {
    my @G = split(/\-/,$_);
    system("zip biobert.zip *.py $_\.yaml");
    system("bx ml $G[1] biobert.zip $_\.yaml");
}
system("bx ml list training-runs");
