#!/usr/bin/perl -w

use strict;
use vars qw ();

chdir("/home/dmiraola/NLP_pipelines/stanford-corenlp-python");
system("python corenlp.py");
