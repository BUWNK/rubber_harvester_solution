import os
import pickle
import tempfile
import pandas as pd
import autosklearn.regression
from sklearn.metrics import mean_squared_error
pd.pandas.set_option('display.max_columns',None)
from sklearn.model_selection import train_test_split

import database

def train():

    df = database.get_new_data()

    y = df['Total(latex)(dry Milk)']

    # Select the features (all columns except the target variable)
    X = df.drop('Total(latex)(dry Milk)', axis=1)

    # Split the data into training and testing sets (e.g., 80% training, 20% testing)
    X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)

    temp_dir = tempfile.mkdtemp()
    os.environ["AUTOSKLEARN_HOME"] = temp_dir

    automl = autosklearn.regression.AutoSklearnRegressor(
        time_left_for_this_task=150,
        per_run_time_limit=60,
        tmp_folder=os.environ["AUTOSKLEARN_HOME"],
        n_jobs = 5,
        memory_limit = 2500
    )
    automl.fit(X_train, y_train, dataset_name="latex_percision")

    with open('latex_model.pickle', 'wb') as file:
        pickle.dump(automl, file, protocol=pickle.HIGHEST_PROTOCOL)
        