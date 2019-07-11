# MLflow demo using project examples

This demo will use the example in the `mlflow/examples/sklearn_elasticnet_wine` directory, reacheable as `../examples/sklearn_elasticnet_wine`.

Run all the commands below from the `demo` directory.

## 1) Launch MLflow UI

```
mlflow ui
```

## 2) MLflow Tracking
### Run once logging random params & metrics values

```
python ../examples/quickstart/mlflow_tracking.py
```

### Run multiple times to show UI & graphs

```
for i in {1..100}; do python ../examples/quickstart/mlflow_tracking.py; done
```


# 3) MLflow projects - Running the training & tracking parameters

Running this command will fail if you don't have all the lis and dependencies installed:

```
python ../examples/sklearn_elasticnet_wine/train.py
```

MLflow can run it for you and install dependencies...

```
mlflow run ../examples/sklearn_elasticnet_wine  // will tell you the parameters needed to run
```

```
mlflow run ../examples/sklearn_elasticnet_wine -P alpha=0.4
```

```
mlflow run ../examples/sklearn_elasticnet_wine -P alpha=0.4 -P l1_ratio=0.12
```


## Let's run it a few times...
```
./multiple_runs.sh
```

## Run projects from a git repo

```
mlflow run https://github.com/mlflow/mlflow-example.git -P alpha=0.5
```

```
mlflow run --experiment-name=sklearn_elasticnet_wine https://github.com/mlflow/mlflow-example.git -P alpha=0.5
```

# Serving the model and making predictions

## Serving the model locally

Look for the `model_file_path` in the UI, then tun this command to serve the model on port 1234:

```
mlflow models serve -m {model_file_path} -p 1234
```

## Predict

To make a prediction using the model served on port 1234, tun:

```
curl -X POST -H "Content-Type:application/json; format=pandas-split" --data '{"columns":["alcohol", "chlorides", "citric acid", "density", "fixed acidity", "free sulfur dioxide", "pH", "residual sugar", "sulphates", "total sulfur dioxide", "volatile acidity"],"data":[[12.8, 0.029, 0.48, 0.98, 6.2, 29, 3.33, 1.2, 0.39, 75, 0.66]]}' http://127.0.0.1:1234/invocations
```
# Cleanup

```
rm -r mlruns
rm -r outputs
```

