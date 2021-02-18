* Initial experiments

- preprocess.pl: main script for experiments 1 (adjudicated data) and 2 (pre-adjudicated)
- Exper3.pl: experiment 3 (train on test for active learning)
- Exper4.pl: train on adjudicated (from exper1), use devel as test-1 (to have held-out data)
- Exper5.pl: train on adjudicated (from exper1), use test as test-2
- Exper6.pl: train on pre-adjudicated (from exper2), use devel as test-1
- Exper7.pl: train on pre-adjudicated (from exper2), use test as test-2

* Using embeddings for bilstm-crf

- Exper8.pl: with embeddings, train on adjudicated for bilstm-crf, test on test-1 (devel)

- Exper10.pl: train on pre-adjudicated for bilstm-crf, test on test-1
- Exper11.pl: blstm_residual on mutation (pre-adjudicated->test2)
- Exper12.pl: train on automatically fixed errors, test on test-2
- Exper13.pl: BioBERT, train on pre-adjudicated test on test-2
- Exper14.pl: BioBERT, train on adjudicated, test on test-2
- Exper15.pl: BioBERT, train on pre-adjudicated, test on test-1
- Exper16.pl: BioBERT, train on automatically fixed errors, test on test-2
- Exper17.pl: bilstm, train on development set, test on train
- Exper18.pl: BioBERT, train on development set (devel=test1), test on train
- Exper19.pl: BioBERT, train on automatically fixed errors (with bilstm-ists), test on test-2 with BioBERT
- Exper20.pl: BioBERT, train on randomly fixed errors, test on test-2 with BioBERT
- Exper21.pl: BioBERT, train on automatically fixed errors (bilstm confidence), test on test-2 with BioBERT
- Exper22.pl: Same as Exper21 with multi-run. Results for Table 8 in the paper.
- Exper23.pl: Same as Exper19 with multi-run
- Exper24.pl: Same as Exper14 with multi-run
- Exper25.pl: Same as Exper13 with multi-run
- Exper26.pl: Same as Exper15 with multi-run
- Exper27.pl: BioBERT, train on adjudicated, test on test-1. Table 4 in the paper.
- create_modified_train_bio_thr.pl: create modified train for BioBERT using ranking threshold
- create_modified_train_bio_thr_random.pl: create modified train for BioBERT using threshold with random ranking
