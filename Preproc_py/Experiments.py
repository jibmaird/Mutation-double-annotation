import os
from shutil import copy

## Exper 1: adjudicated -> test2

data_d = "/Users/david/Projects/Data/Experiments/Mutation/"

if not os.path.isdir(data_d+"1/in"):
    os.mkdir(data_d+"1/in")

copy(data_d+"2/bio/train_dev.tsv",data_d+"1/in/devel.tsv")
copy(data_d+"2/bio/train.tsv",data_d+"1/in/train_dev.tsv")
copy(data_d+"1/bio/test.tsv",data_d+"1/in/test.tsv")

## Exper 2: pre-adjudicated -> test2

if not os.path.isdir(data_d+"2/in"):
    os.mkdir(data_d+"2/in")

copy(data_d+"2/bio/train_dev.tsv",data_d+"2/in/devel.tsv")
copy(data_d+"2/bio/train.tsv",data_d+"2/in/train_dev.tsv")
copy(data_d+"1/bio/test.tsv",data_d+"2/in/test.tsv")

