function [sensitivity,specificity,Accuracy,F1,MCC,BalancedAccuracy] = model_diagnostics(actual_Y,predicted_Y)

tp = sum((actual_Y == predicted_Y) & (actual_Y == 'YES'));
fn = sum((actual_Y ~= predicted_Y) & (actual_Y == 'YES'));
tn = sum((actual_Y == predicted_Y) & (actual_Y == 'NO'));
fp = sum((actual_Y ~= predicted_Y) & (actual_Y == 'NO'));
    
    
sensitivity = tp/(tp + fn) ; %TPR
specificity = tn/(tn + fp) ; %TNR
precision = tp / (tp + fp) ;
FPR = fp/(tn+fp);
FNR = fn/(fn+tp);
Accuracy = (tp+tn)./(tp+fp+tn+fn);
recall = tp / (tp + fn) ;
F1 = (2 * precision * recall) / (precision + recall);

MCC= ((tp*tn)-(fp*fn))/sqrt((tp+fp) *(tp+fn) *(tn+fp) *(tn+fn));
TPR=1-FNR;
TNR=1-FPR;
BalancedAccuracy=(TPR+TNR)/2;

end

