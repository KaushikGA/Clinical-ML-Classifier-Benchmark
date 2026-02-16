function plotResults (Diagnostics,allDatasets,allMisclassificationCosts,allModels)

for modelCounter=1:length(allModels)
    figure
    title(allModels(modelCounter)) 
for datasetCounter=1:length(allDatasets)
    for misclassificationCost=1:length(allMisclassificationCosts)

       configurationString=allDatasets(datasetCounter)+'_'+'MC'+int2str(allMisclassificationCosts(misclassificationCost))+'_'+allModels(modelCounter);
       %disp(configurationString)
       legendString=configurationString+': '+num2str(Diagnostics.AUC.([configurationString]));
       hold on
       plot(Diagnostics.ROC.([configurationString])(:,1),Diagnostics.ROC.([configurationString])(:,2),...
           'DisplayName',legendString)
       
    end
end
hold off
legend('Interpreter', 'none','Location','SE')
 xlabel('False positive rate')
 ylabel('True positive rate')
end


















end