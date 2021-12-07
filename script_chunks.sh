#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --mem-per-cpu=2G
#SBATCH --time=0:50:00
#SBATCH --array=0-24
#SBATCH --job-name="Q1PredVarBio"

no_monitoring_set=24
divide=25
# first hidden layer size
netsize="32"
# second hidden layer size
netsize2="12"
# input layer dropout
visdrop="05"
# first hidden layer dropout
hdrop="33"
hdrop2="33"
iteration=1200
learning=0.002
momem=0.5

input_file=a1q1.model_data.csv
features=features_combined.obj
results=resultslqts_combined.obj


MODEL_ID=${SLURM_ARRAY_TASK_ID}
#this loop runs the monitoring set and model ID runs independent sets
for a in $(seq 0 $no_monitoring_set);
do
if [ $a -ne $MODEL_ID ];
then
MONIND="Subset(filename=full.whet.multimer_combined.bin,number chunks=$divide,chunks=[$a])"
TRAIN="Subset(filename=full.whet.multimer_combined.bin,number chunks=$divide,chunks=[0]+[1]+[2]+[3]+[4]+[5]+[6]+[7]+[8]+[9]+[10]+[11]+[12]+[13]+[14]+[15]+[16]+[17]+[18]+[19]+[20]+[21]+[22]+[23]+[24]-[$a]-[$MODEL_ID])"

else   #boundary cases
if [ ${a} == 0 ]; 
then
MONIND="Subset(filename=full.whet.multimer_combined.bin,number chunks=$divide,chunks=[1])"
TRAIN="Subset(filename=full.whet.multimer_combined.bin,number chunks=$divide,chunks=[0]+[1]+[2]+[3]+[4]+[5]+[6]+[7]+[8]+[9]+[10]+[11]+[12]+[13]+[14]+[15]+[16]+[17]+[18]+[19]+[20]+[21]+[22]+[23]+[24]-[1]-[$MODEL_ID])"

else
b=$(($a-1))
MONIND="Subset(filename=full.whet.multimer_combined.bin,number chunks=$divide,chunks=[$b])"
TRAIN="Subset(filename=full.whet.multimer_combined.bin,number chunks=$divide,chunks=[0]+[1]+[2]+[3]+[4]+[5]+[6]+[7]+[8]+[9]+[10]+[11]+[12]+[13]+[14]+[15]+[16]+[17]+[18]+[19]+[20]+[21]+[22]+[23]+[24]-[$b]-[$MODEL_ID])"

fi
fi

IND="Subset(filename=full.whet.multimer_combined.bin,number chunks=$divide,chunks=[$MODEL_ID])"

IDN=$1

rm -f models/$IDN/model`printf %06d $MODEL_ID`.* 

bcl-apps-static.exe model:Train "NeuralNetwork(balance=True,balance target ratio=1,balance max repeats=100,transfer function = Rectifier(0.05),weight update = Simple(alpha=$momem,eta=$learning),input dropout type=Zero,objective function =Accuracy(cutoff=0.5),input noise=0.0,iteration weight update=Attenuate(0.0,0.0,0.0,0.001),shuffle=True,steps per update=1,dropout(0.$visdrop,0.$hdrop,0.$hdrop2),hidden architecture($netsize,$netsize2),rescale output dynamic range=True,rmsd report frequency=1,scaling=AveStd)" -max_minutes 300 -max_iterations $iteration -opencl Disable --result_averaging_window 0 -final_objective_function 'Accuracy(cutoff=0.5)' -feature_labels $features -result_labels $results -id_labels 'Combine(MutationId)' -training "$TRAIN" -monitoring "$MONIND" -independent "$IND" -print_independent_predictions ./results/$IDN/${a}/independent${a}_${MODEL_ID}_monitoring${MODEL_ID}_number${a}.gz -storage_model "File(directory=models/$IDN/${a}/,prefix=model,key=$MODEL_ID)" > ./log_files/$IDN/${a}/independent${MODEL_ID}_monitoring${MODEL_ID}_number${a}.txt

done


exit 0

