function [trainedClassifier, validationAccuracy] = trainClassifierNVB(trainingData,misClassificationCost)
inputTable = trainingData;
missclass_cost=[0,misClassificationCost;1,0];
predictorNames =inputTable.Properties.VariableNames;
predictorNames(end)=[];

if length(predictorNames)== 9
    isCategoricalPredictor = [true, false, false, false, false, true, false, true, true];
else
    isCategoricalPredictor = [true, false, false, false, false, true, true, false, true, true];
end

predictors = inputTable(:, predictorNames);
response = inputTable.Metastatic;

distributionNames =  repmat({'Normal'}, 1, length(isCategoricalPredictor));
distributionNames(isCategoricalPredictor) = {'mvmn'};

if any(strcmp(distributionNames,'Kernel'))
    classificationNaiveBayes = fitcnb(...
        predictors, ...
        response, ...
        'Kernel', 'Normal', ...
        'Cost', missclass_cost, ...
        'Support', 'Unbounded', ...
        'DistributionNames', distributionNames, ...
        'ClassNames', categorical({'NO'; 'YES'}));
else
    classificationNaiveBayes = fitcnb(...
        predictors, ...
        response, ...
        'Cost', missclass_cost, ...
        'DistributionNames', distributionNames, ...
        'ClassNames', categorical({'NO'; 'YES'}),...
    'OptimizeHyperparameters','none',...
    'HyperparameterOptimizationOptions',struct('AcquisitionFunctionName','expected-improvement-plus')...
    );
end

% Create the result struct with predict function
predictorExtractionFcn = @(t) t(:, predictorNames);
naiveBayesPredictFcn = @(x) predict(classificationNaiveBayes, x);
trainedClassifier.predictFcn = @(x) naiveBayesPredictFcn(predictorExtractionFcn(x));

% Add additional fields to the result struct
trainedClassifier.RequiredVariables = {'Age', 'MNplasma', 'MTYplasma', 'NMNplasma', 'PreviousHistory', 'SDHB', 'Sex', 'TumorCategory', 'TumorCategoryII', 'TumorVolume'};
trainedClassifier.ClassificationNaiveBayes = classificationNaiveBayes;
trainedClassifier.About = 'This struct is a trained model exported from Classification Learner R2019b.';
trainedClassifier.HowToPredict = sprintf('To make predictions on a new table, T, use: \n  yfit = c.predictFcn(T) \nreplacing ''c'' with the name of the variable that is this struct, e.g. ''trainedModel''. \n \nThe table, T, must contain the variables returned by: \n  c.RequiredVariables \nVariable formats (e.g. matrix/vector, datatype) must match the original training data. \nAdditional variables are ignored. \n \nFor more information, see <a href="matlab:helpview(fullfile(docroot, ''stats'', ''stats.map''), ''appclassification_exportmodeltoworkspace'')">How to predict using an exported model</a>.');


% Perform cross-validation
partitionedModel = crossval(trainedClassifier.ClassificationNaiveBayes, 'KFold', 5);

% Compute validation predictions
[validationPredictions, validationScores] = kfoldPredict(partitionedModel);

% Compute validation accuracy
validationAccuracy = 1 - kfoldLoss(partitionedModel, 'LossFun', 'ClassifError');
