disp('------- Importing Data -------------')
%% Source excel file location
mainDirname = string(fullfile( pwd,"data\"));
dataFilename= "PatientData" ;
sourceDataExcelFileFullPath=mainDirname+dataFilename+'.xlsx';
fprintf("------- Importing from %s",sourceDataExcelFileFullPath)
%--------------------------------------------------------------------------%
%% Constants for importing data for 9 predictors
optsFor09Predictors = spreadsheetImportOptions("NumVariables", 14);
optsFor09Predictors.VariableNames = ["ID", "Study", "Metastatic", "Sex",      "Age", "NMNplasma", "MNplasma", "MTYplasma", "TumorCategory", "TumorVolume", "TumorCategoryII", "PreviousHistory", "TargetMetastaticDiseaseisYES", "TargetMetastaticDiseaseisNO"];
optsFor09Predictors.VariableTypes = ["double",   "categorical",         "categorical",       "categorical", "double",       "double",    "double",   "double",    "categorical",     "double",       "categorical",     "categorical",       "double",      "double"];
optsFor09Predictors.Sheet = "Table_09_predictors";  
optsFor09Predictors.DataRange = "A2:N744"; 
optsFor09Predictors.PreserveVariableNames=true;
%% Constants for importing data for 10 predictors
optsFor10Predictors = spreadsheetImportOptions("NumVariables", 15); 
optsFor10Predictors.VariableNames = ["ID", "Study", "Metastatic","Sex",  "Age", "NMNplasma","MNplasma", "MTYplasma", "TumorCategory", "SDHB", "TumorVolume", "TumorCategoryII", "PreviousHistory", "TargetMetastaticDiseaseisYES", "TargetMetastaticDiseaseisNO"];
optsFor10Predictors.VariableTypes = ["double","categorical", "categorical","categorical", "double", "double", "double", "double",      "categorical",   "categorical",    "double",       "categorical",     "categorical",     "double",                       "double"];
optsFor10Predictors.Sheet = "Table_10_predictors";  
optsFor10Predictors.DataRange = "A2:O674" ; 
optsFor10Predictors.PreserveVariableNames=true;
%% Data import
fullDataOf10Predictors = readtable(sourceDataExcelFileFullPath , optsFor10Predictors, "UseExcel", false );
fullDataOf09Predictors = readtable(sourceDataExcelFileFullPath , optsFor09Predictors, "UseExcel", false );
fprintf('\n------- Finished Importing Data -------------\n')