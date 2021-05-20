import os
from shutil import copy

data_d = "/Users/david/Projects/Data/Corpora/amia-18-mutation-corpus/data";
out_d = "/Users/david/Projects/Data/Experiments/Mutation/1";

if not os.path.isdir(out_d):
    os.mkdir("/Users/david/Projects/Data/Experiments/Mutation")
    os.mkdir(out_d)
    os.mkdir(out_d+"/Train")
    os.mkdir(out_d+"/Test")
    
for i in range(0,7):
    for file in os.listdir(data_d+"/0"+str(i)):
      if i < 6:
        copy(data_d+"/0"+str(i)+"/"+file,out_d+"/Train")
      else:
        copy(data_d+"/0"+str(i)+"/"+file,out_d+"/Test")
    
