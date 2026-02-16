function [trainedClassifier, validationAccuracy] = trainClassifierTree(trainingData,misClassificationCost)

inputTable = trainingData;
predictorNames =inputTable.Properties.VariableNames;
predictorNames(end)=[];
predictors = inputTable(:, predictorNames);
response = inputTable.Metastatic;
%isCategoricalPredictor = [true, false, false, false, false, true, true, false, true, true];
missclass_cost=[0,misClassificationCost;1,0];
% Train a classifier
% This code specifies all the classifier options and trains the classifier.
classificationTree = fitctree(...
    predictors, ...
    response, ...
    'SplitCriterion', 'gdi', ...
    'MaxNumSplits', 100, ...
    'Surrogate', 'off', ...
    'Cost', missclass_cost, ...
    'ClassNames', categorical({'NO'; 'YES'}),...
    'OptimizeHyperparameters','none',...
    'HyperparameterOptimizationOptions',struct('AcquisitionFunctionName','expected-improvement-plus')...
    );
%close all
% Create the result struct with predict function
predictorExtractionFcn = @(t) t(:, predictorNames);
treePredictFcn = @(x) predict(classificationTree, x);
trainedClassifier.predictFcn = @(x) treePredictFcn(predictorExtractionFcn(x));

% Add additional fields to the result struct
trainedClassifier.RequiredVariables = {'Age', 'MNplasma', 'MTYplasma', 'NMNplasma', 'PreviousHistory', 'SDHB', 'Sex', 'TumorCategory', 'TumorCategoryII', 'TumorVolume'};
trainedClassifier.ClassificationTree = classificationTree;
trainedClassifier.About = 'This struct is a trained model exported from Classification Learner R2019b.';
trainedClassifier.HowToPredict = sprintf('To make predictions on a new table, T, use: \n  yfit = c.predictFcn(T) \nreplacing ''c'' with the name of the variable that is this struct, e.g. ''trainedModel''. \n \nThe table, T, must contain the variables returned by: \n  c.RequiredVariables \nVariable formats (e.g. matrix/vector, datatype) must match the original training data. \nAdditional variables are ignored. \n \nFor more information, see <a href="matlab:helpview(fullfile(docroot, ''stats'', ''stats.map''), ''appclassification_exportmodeltoworkspace'')">How to predict using an exported model</a>.');

% Perform cross-validation
partitionedModel = crossval(trainedClassifier.ClassificationTree, 'KFold', 5);

% Compute validation predictions
[validationPredictions, validationScores] = kfoldPredict(partitionedModel);

% Compute validation accuracy
validationAccuracy = 1 - kfoldLoss(partitionedModel, 'LossFun', 'ClassifError');
