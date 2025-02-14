## 종결 단백질 Rho를 이용한 전사 종결 예측 프로그램
Understanding the sequence specificity of Rho-dependent termination with machine learning

## data

1. [data](https://github.com/taehojo/Rho_prediction/tree/master/data) : data for feature extracting

2. [ml-result](https://github.com/taehojo/Rho_prediction/tree/master/ml-result) : trainset, testset, models

3. [motif_search](https://github.com/taehojo/Rho_prediction/tree/master/motif_search) : motif search results 

4. [pos_neg](https://github.com/taehojo/Rho_prediction/tree/master/pos_neg) : positive and negative sets

5. [raw_output](https://github.com/taehojo/Rho_prediction/tree/master/raw_output) : output of random forest on 145 set A/B, 1160 set A/B 

6. [scripts](https://github.com/taehojo/Rho_prediction/tree/master/scripts) : scripts for extracting features

## run script
1. [01_Feature-extraction-145-set.sh](https://github.com/taehojo/Rho_prediction/blob/master/01_Feature-extraction-145-set.sh) : run feature extraction for 145 set. 

2. [02_Feature-extraction-1160-set.sh](https://github.com/taehojo/Rho_prediction/blob/master/02_Feature-extraction-1160-set.sh) : run feature extraction for 1160 set.

3. [03_random_forest_V2.R](https://github.com/taehojo/Rho_prediction/blob/master/03_random_forest_V2.R) : run R for random forest

-----

Copyright 
Taeho Jo (taehjo@gmail.com)
