#!/bin/bash

features=features_combined.obj

if [ $1 ]
then
bcl-apps-static.exe GenerateDataset -source "ProteinMutationsDirectory(./,key file=./keys.txt,aa class=AAComplete,mutation extension=.model_data.csv,suffix=.pdb,add self mutation fraction=0.0)" -output full.whet.multimer_combined.bin -feature_labels $features -result_labels resultslqts_combined.obj -id_labels 'Combine(MutationId)'
else
bcl-apps-static.exe GenerateDataset -source "ProteinMutationsDirectory(./,key file=./keys.txt,aa class=AAComplete,mutation extension=.model_data.csv,suffix=.pdb,add self mutation fraction=0.0)" -output features_results.csv -feature_labels features_combined.obj -result_labels resultslqts_combined.obj -id_labels 'Combine(MutationId)'
fi

exit 0
