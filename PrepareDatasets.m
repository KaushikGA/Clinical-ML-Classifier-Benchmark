%% Data Preparation for 9 predictors
disp('------- Preparing data -------------')
colNames09= ["ID", "Study",  "Sex",  "Age", "NMNplasma", "MNplasma", "MTYplasma", "TumorCategory", "TumorVolume", "TumorCategoryII", "PreviousHistory","Metastatic"];
predictorNames09= [ "Sex",  "Age", "NMNplasma", "MNplasma", "MTYplasma", "TumorCategory", "TumorVolume", "TumorCategoryII", "PreviousHistory"];

fullDataOf09Predictors= removevars(fullDataOf09Predictors,{'TargetMetastaticDiseaseisNO'});
fullDataOf09Predictors= removevars(fullDataOf09Predictors,{'TargetMetastaticDiseaseisYES'});

fullDataOf09Predictors.Age = round(fullDataOf09Predictors.Age);
fullDataOf09Predictors.NMNplasma = round(fullDataOf09Predictors.NMNplasma);
fullDataOf09Predictors.MNplasma = round(fullDataOf09Predictors.MNplasma);
fullDataOf09Predictors.MTYplasma = round(fullDataOf09Predictors.MTYplasma);
fullDataOf09Predictors.TumorVolume = round(fullDataOf09Predictors.TumorVolume);

fullDataOf09Predictors_numeric=fullDataOf09Predictors;
fullDataOf09Predictors_numeric.Metastatic = findgroups(fullDataOf09Predictors.Metastatic);
fullDataOf09Predictors_numeric.Sex = findgroups(fullDataOf09Predictors.Sex);
fullDataOf09Predictors_numeric.TumorCategory = findgroups(fullDataOf09Predictors.TumorCategory);
fullDataOf09Predictors_numeric.TumorCategoryII = findgroups(fullDataOf09Predictors.TumorCategoryII);
fullDataOf09Predictors_numeric.PreviousHistory = findgroups(fullDataOf09Predictors.PreviousHistory);


mixedData09Predictors=fullDataOf09Predictors(:,colNames09);
mixedData09Predictors_numeric=fullDataOf09Predictors_numeric(:,colNames09);

retrospectiveData09Predictors=mixedData09Predictors(mixedData09Predictors.Study=='RET',:);
retrospectiveData09Predictors_numeric=mixedData09Predictors_numeric(mixedData09Predictors_numeric.Study=='RET',:);

prospectiveData09Predictors=mixedData09Predictors(mixedData09Predictors.Study=='PROS',:) ;
prospectiveData09Predictors_numeric=mixedData09Predictors_numeric(mixedData09Predictors_numeric.Study=='PROS',:) ;

mixedData09Predictors_numeric= removevars(mixedData09Predictors_numeric,{'ID','Study'});
retrospectiveData09Predictors_numeric= removevars(retrospectiveData09Predictors_numeric,{'ID','Study'});
prospectiveData09Predictors_numeric= removevars(prospectiveData09Predictors_numeric,{'ID','Study'});
mixedData09Predictors= removevars(mixedData09Predictors,{'ID','Study'});
retrospectiveData09Predictors= removevars(retrospectiveData09Predictors,{'ID','Study'});
prospectiveData09Predictors= removevars(prospectiveData09Predictors,{'ID','Study'});

%disp('------- Data preparation for 9 predictors complete-------------')

%% Data Preparation for 10 predictors

colNames10= ["ID", "Study",  "Sex",  "Age", "NMNplasma", "MNplasma", "MTYplasma", "TumorCategory", "SDHB", "TumorVolume", "TumorCategoryII", "PreviousHistory","Metastatic"];
predictorNames10= [ "Sex",  "Age", "NMNplasma", "MNplasma", "MTYplasma", "TumorCategory", "SDHB", "TumorVolume", "TumorCategoryII", "PreviousHistory"];

%disp('------- Preparing data for 10 predictors-------------')
fullDataOf10Predictors= removevars(fullDataOf10Predictors,{'TargetMetastaticDiseaseisNO'});
fullDataOf10Predictors= removevars(fullDataOf10Predictors,{'TargetMetastaticDiseaseisYES'});

fullDataOf10Predictors.Age = round(fullDataOf10Predictors.Age);
fullDataOf10Predictors.NMNplasma = round(fullDataOf10Predictors.NMNplasma);
fullDataOf10Predictors.MNplasma = round(fullDataOf10Predictors.MNplasma);
fullDataOf10Predictors.MTYplasma = round(fullDataOf10Predictors.MTYplasma);
fullDataOf10Predictors.TumorVolume = round(fullDataOf10Predictors.TumorVolume);

fullDataOf10Predictors_numeric=fullDataOf10Predictors;
fullDataOf10Predictors_numeric.Metastatic = findgroups(fullDataOf10Predictors.Metastatic);
fullDataOf10Predictors_numeric.Sex = findgroups(fullDataOf10Predictors.Sex);
fullDataOf10Predictors_numeric.TumorCategory = findgroups(fullDataOf10Predictors.TumorCategory);
fullDataOf10Predictors_numeric.TumorCategoryII = findgroups(fullDataOf10Predictors.TumorCategoryII);
fullDataOf10Predictors_numeric.PreviousHistory = findgroups(fullDataOf10Predictors.PreviousHistory);
fullDataOf10Predictors_numeric.SDHB = findgroups(fullDataOf10Predictors.SDHB);

mixedData10Predictors=fullDataOf10Predictors(:,colNames10);
mixedData10Predictors_numeric=fullDataOf10Predictors_numeric(:,colNames10);

retrospectiveData10Predictors=mixedData10Predictors(mixedData10Predictors.Study=='RET',:);
retrospectiveData10Predictors_numeric=mixedData10Predictors_numeric(mixedData10Predictors_numeric.Study=='RET',:);

prospectiveData10Predictors=mixedData10Predictors(mixedData10Predictors.Study=='PROS',:) ;
prospectiveData10Predictors_numeric=mixedData10Predictors_numeric(mixedData10Predictors_numeric.Study=='PROS',:) ;

mixedData10Predictors_numeric= removevars(mixedData10Predictors_numeric,{'ID','Study'});
retrospectiveData10Predictors_numeric= removevars(retrospectiveData10Predictors_numeric,{'ID','Study'});
prospectiveData10Predictors_numeric= removevars(prospectiveData10Predictors_numeric,{'ID','Study'});
mixedData10Predictors= removevars(mixedData10Predictors,{'ID','Study'});
retrospectiveData10Predictors= removevars(retrospectiveData10Predictors,{'ID','Study'});
prospectiveData10Predictors= removevars(prospectiveData10Predictors,{'ID','Study'});
disp('------- Data preparation complete-------------')

