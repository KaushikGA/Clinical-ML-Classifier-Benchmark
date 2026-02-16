clc
clear all
close all
rng default
ImportData
PrepareDatasets
PartitionDatasets

allDatasets= [ "P2R10"; "P2R9"; "R2P10"; "R2P9"; "MIX10"; "MIX9" ]    ;
allMisclassificationCosts= [ 1; 5 ; 10 ; 15 ; 25 ]                     ;
allModels=["Tree";"SVM"; "NVB"; "Ensemble" ]                          ;
Diagnostics=[];
for datasetCounter=1:length(allDatasets)
    for misclassificationCost=1:length(allMisclassificationCosts)
        configurationString=allDatasets(datasetCounter)+'_'+'MC'+int2str(allMisclassificationCosts(misclassificationCost))+'_Tree';
        [trainedClassifier,validationAccuracy]=trainClassifierTree(trainingDataset.([allDatasets(datasetCounter)]),allMisclassificationCosts(misclassificationCost));
        PredictedData=trainedClassifier.predictFcn (testingDataset.([allDatasets(datasetCounter)]));
        ActualData=testingDataset.([allDatasets(datasetCounter)]).Metastatic;
        [~,score] = resubPredict(trainedClassifier.ClassificationTree);
        [x_roc,y_roc,~,auc,OPTROCPT_res] = perfcurve(trainingDataset.([allDatasets(datasetCounter)]).Metastatic,score(:,2),'YES');
        Diagnostics=recordDiagnostics(Diagnostics, ActualData,PredictedData,x_roc,y_roc,auc,configurationString ) ;
        fprintf('----------- Model- %s | Balanced Accuracy = %f --------\n',configurationString,Diagnostics.BalancedAccuracy.([configurationString]))
               
    end
end

for datasetCounter=1:length(allDatasets)
    for misclassificationCost=1:length(allMisclassificationCosts)
        configurationString=allDatasets(datasetCounter)+'_'+'MC'+int2str(allMisclassificationCosts(misclassificationCost))+'_NVB';
        [trainedClassifier,validationAccuracy]=trainClassifierNVB(trainingDataset.([allDatasets(datasetCounter)]),allMisclassificationCosts(misclassificationCost));
        PredictedData=trainedClassifier.predictFcn (testingDataset.([allDatasets(datasetCounter)]));
        ActualData=testingDataset.([allDatasets(datasetCounter)]).Metastatic;
        [~,score] = resubPredict(trainedClassifier.ClassificationNaiveBayes);
        [x_roc,y_roc,~,auc,OPTROCPT_res] = perfcurve(trainingDataset.([allDatasets(datasetCounter)]).Metastatic,score(:,2),'YES');
        Diagnostics=recordDiagnostics(Diagnostics, ActualData,PredictedData,x_roc,y_roc,auc,configurationString ) ;
        fprintf('----------- Model- %s | Balanced Accuracy = %f --------\n',configurationString,Diagnostics.BalancedAccuracy.([configurationString]))
               
    end
end

for datasetCounter=1:length(allDatasets)
    for misclassificationCost=1:length(allMisclassificationCosts)
        configurationString=allDatasets(datasetCounter)+'_'+'MC'+int2str(allMisclassificationCosts(misclassificationCost))+'_SVM';
        [trainedClassifier,validationAccuracy]=trainClassifierSVM(trainingDataset.([allDatasets(datasetCounter)]),allMisclassificationCosts(misclassificationCost));
        PredictedData=trainedClassifier.predictFcn (testingDataset.([allDatasets(datasetCounter)]));
        ActualData=testingDataset.([allDatasets(datasetCounter)]).Metastatic;
        [~,score] = resubPredict(trainedClassifier.ClassificationSVM);
        [x_roc,y_roc,~,auc,OPTROCPT_res] = perfcurve(trainingDataset.([allDatasets(datasetCounter)]).Metastatic,score(:,2),'YES');
        Diagnostics=recordDiagnostics(Diagnostics, ActualData,PredictedData,x_roc,y_roc,auc,configurationString ) ;
        fprintf('----------- Model- %s | Balanced Accuracy = %f --------\n',configurationString,Diagnostics.BalancedAccuracy.([configurationString]))
               
    end
end

for datasetCounter=1:length(allDatasets)
    for misclassificationCost=1:length(allMisclassificationCosts)
        configurationString=allDatasets(datasetCounter)+'_'+'MC'+int2str(allMisclassificationCosts(misclassificationCost))+'_Ensemble';
        [trainedClassifier,validationAccuracy]=trainClassifierEnsemble(trainingDataset.([allDatasets(datasetCounter)]),allMisclassificationCosts(misclassificationCost));
        PredictedData=trainedClassifier.predictFcn (testingDataset.([allDatasets(datasetCounter)]));
        ActualData=testingDataset.([allDatasets(datasetCounter)]).Metastatic;
        [~,score] = resubPredict(trainedClassifier.ClassificationEnsemble);
        [x_roc,y_roc,~,auc,OPTROCPT_res] = perfcurve(trainingDataset.([allDatasets(datasetCounter)]).Metastatic,score(:,2),'YES');
        Diagnostics=recordDiagnostics(Diagnostics, ActualData,PredictedData,x_roc,y_roc,auc,configurationString ) ;
        fprintf('----------- Model- %s | Balanced Accuracy = %f --------\n',configurationString,Diagnostics.BalancedAccuracy.([configurationString]))
               
    end
end

plotResults (Diagnostics,allDatasets,allMisclassificationCosts,allModels)

