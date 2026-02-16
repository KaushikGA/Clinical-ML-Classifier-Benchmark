fprintf('------- Defining training and testing datasets-------------\n')

trainingDataset.R2P9=retrospectiveData09Predictors;
testingDataset.R2P9=prospectiveData09Predictors;
trainingDataset.P2R9=prospectiveData09Predictors;
testingDataset.P2R9=retrospectiveData09Predictors;

trainingDataset.R2P10=retrospectiveData10Predictors;
testingDataset.R2P10=prospectiveData10Predictors;
trainingDataset.P2R10=prospectiveData10Predictors;
testingDataset.P2R10=retrospectiveData10Predictors;

mixedData_partitioned09 = cvpartition(mixedData09Predictors.Metastatic,'KFold', 5 ,'Stratify',true);
index_training=find(mixedData_partitioned09.training(1));
index_test=find(mixedData_partitioned09.test(1));
trainingDataset.MIX9=mixedData09Predictors(index_training,: );
testingDataset.MIX9=mixedData09Predictors(index_test,: );


mixedData_partitioned10 = cvpartition(mixedData10Predictors.Metastatic,'KFold', 5 ,'Stratify',true);
index_training=find(mixedData_partitioned10.training(1));
index_test=find(mixedData_partitioned10.test(1));
trainingDataset.MIX10=mixedData10Predictors(index_training,: );
testingDataset.MIX10=mixedData10Predictors(index_test,: );

fprintf('------- Datasets ready -------------\n\n')
