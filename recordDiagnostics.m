function Diagnostics=recordDiagnostics(Diagnostics, ActualData,PredictedData,x_roc,y_roc,auc,configurationString )

[val_sensitivity,val_specificity,val_Accuracy,val_F1,val_MCC,val_BalancedAccuracy] = model_diagnostics(ActualData,PredictedData);
Diagnostics.Sensitivity.([configurationString])       =val_sensitivity      ;
Diagnostics.Specificity.([configurationString])       =val_specificity      ;
Diagnostics.Accuracy.([configurationString])          =val_Accuracy         ;
Diagnostics.F1.([configurationString])                =val_F1               ;
Diagnostics.MCC.([configurationString])               =val_MCC              ;
Diagnostics.BalancedAccuracy.([configurationString])  =val_BalancedAccuracy ;
Diagnostics.ROC.([configurationString])       =[x_roc y_roc ]     ;
Diagnostics.AUC.([configurationString])       =auc      ;




end