# KCNQ1_ML_Model
Contains files that reproduce the manuscript results

Requirement 
BCL exceutable is required to run this model. It is freely avaibable for academic users
Here is the link http://meilerlab.org/index.php/bclcommons/show/b_apps_id/1

Additional Requirement
Slurm scheduler with atleast 25 threads

To run this machine learning model

1) Create bcl readable bin file that carry information features and results label for the model
	source create_features_results_labels.sh bin
  
2) Run the model
	source run.sh Q1PreVarBio
