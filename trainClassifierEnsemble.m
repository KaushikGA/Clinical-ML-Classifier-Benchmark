function [trainedClassifier, validationAccuracy] = trainClassifierEnsemble(trainingData,misClassificationCost)
inputTable = trainingData;
missclass_cost=[0,misClassificationCost;1,0];
predictorNames =inputTable.Properties.VariableNames;
predictorNames(end)=[];
predictors = inputTable(:, predictorNames);
response = inputTable.Metastatic;
if length(predictorNames)== 9
    isCategoricalPredictor = [true, false, false, false, false, true, false, true, true];
else
    isCategoricalPredictor = [true, false, false, false, false, true, true, false, true, true];
end

template = templateTree(...
    'MaxNumSplits', 20);
classificationEnsemble = fitcensemble(...
    predictors, ...
    response, ...
    'Method', 'RUSBoost', ...
    'NumLearningCycles', 30, ...
    'Learners', template, ...
    'LearnRate', 0.1, ...
    'ClassNames', categorical({'NO'; 'YES'}));

% Create the result struct with predict function
predictorExtractionFcn = @(t) t(:, predictorNames);
ensemblePredictFcn = @(x) predict(classificationEnsemble, x);
trainedClassifier.predictFcn = @(x) ensemblePredictFcn(predictorExtractionFcn(x));

% Add additional fields to the result struct
trainedClassifier.RequiredVariables = {'Age', 'MNplasma', 'MTYplasma', 'NMNplasma', 'PreviousHistory', 'SDHB', 'Sex', 'TumorCategory', 'TumorCategoryII', 'TumorVolume'};
trainedClassifier.ClassificationEnsemble = classificationEnsemble;
trainedClassifier.About = 'This struct is a trained model exported from Classification Learner R2019b.';
trainedClassifier.HowToPredict = sprintf('To make predictions on a new table, T, use: \n  yfit = c.predictFcn(T) \nreplacing ''c'' with the name of the variable that is this struct, e.g. ''trainedModel''. \n \nThe table, T, must contain the variables returned by: \n  c.RequiredVariables \nVariable formats (e.g. matrix/vector, datatype) must match the original training data. \nAdditional variables are ignored. \n \nFor more information, see <a href="matlab:helpview(fullfile(docroot, ''stats'', ''stats.map''), ''appclassification_exportmodeltoworkspace'')">How to predict using an exported model</a>.');

% Perform cross-validation
partitionedModel = crossval(trainedClassifier.ClassificationEnsemble, 'KFold', 5);

% Compute validation predictions
[validationPredictions, validationScores] = kfoldPredict(partitionedModel);

% Compute validation accuracy
validationAccuracy = 1 - kfoldLoss(partitionedModel, 'LossFun', 'ClassifError');
