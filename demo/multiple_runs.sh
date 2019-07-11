#!/bin/bash

alpha=(0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8)
l1=(0.1 0.2 0.3)

experiment_dir=$1
experiment_name="$(basename "$experiment_dir")"

echo "running experiment in: $experiment_dir"
echo "experiment name: $experiment_name"

# Create experiment if it doesn't already exist
if ! (mlflow experiments list | grep $experiment_name); then
	mlflow experiments create -n $experiment_name
fi

# Run the experiment a few times changing the parameters
for x in "${alpha[@]}"; do
	for y in "${l1[@]}"; do
		mlflow run --experiment-name="$experiment_name" "$experiment_dir"  -P alpha=$x -P l1_ratio=$y
	done
done
