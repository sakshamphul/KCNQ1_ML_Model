#!/bin/bash

features=features_combined.obj
if [ $1 ]
then
rm -r results/$1 models/$1 log_files/$1

mkdir -p log_files/$1 results/$1 models/$1

for a in $(seq 0 25);
do
mkdir results/$1/$a models/$1/$a log_files/$1/$a
done

if [ $1 ]
then

sbatch script_chunks.sh $1

fi

rm slur*
fi

exit 0
