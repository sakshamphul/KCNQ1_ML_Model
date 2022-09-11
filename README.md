Webserver: http://carbon.structbio.vanderbilt.edu/index.php/servers/show?s_id=29

Contain files that reproduces the manuscript results

BCL exceutable is required to run this model. It is freely available for academic users.
Here is the link http://carbon.structbio.vanderbilt.edu/index.php/bclcommons/show/b_apps_id/1

Additional Requirement: 
Slurm scheduler with atleast 25 threads available

To run this machine learning model

1) Create bcl readable bin file that carry information features and results label for the model
	source create_features_results_labels.sh bin
  
2) Run the model
	source run.sh Q1PreVarBio

Protocol capture is documented in S1_Protocol_Capture.doc
