# -*- coding: utf-8 -*-


import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns
from sklearn.svm import LinearSVC
from sklearn.feature_selection import SelectFromModel, VarianceThreshold
from sklearn.model_selection import GridSearchCV
from sklearn.ensemble import RandomForestClassifier
from sklearn.datasets import make_classification
from sklearn.model_selection import train_test_split
from sklearn.metrics import classification_report
from sklearn import metrics
import warnings
warnings.filterwarnings("ignore")

def feature_selection(file_path, verbose=False, further=False):
  """
  file_path: The path of the data for feature selection
  verbose: 1 if print the outputs
  further: 1 if need further feature reduction
  """
  # Use Dog_1.csv as an example
  data = np.genfromtxt(file_path, delimiter=",", invalid_raise = False)
  # View the shape of the data
  print("Number of Observation(raw): {}\nNumber of features(raw): {}".format(data.shape[0], data.shape[1]-2))
  # Peek the sub data to make sure that the import succed
  if verbose:
    print(data[0:5, 0:5])

  # We need to concatenate the features every 3 rows
  # First separate the features and labels
  X_data_raw = data[:, 2:-1]
  y_data_raw = data[:, 0]
  # Reshape
  X_data = np.reshape(X_data_raw, (int(X_data_raw.shape[0]/3), -1))
  y_data = y_data_raw[[i for i in range(0, y_data_raw.shape[0], 3)]]
  # Shape
  if verbose:
    print("Number of Observation(Concat): {}\nNumber of features(Concat): {}".format(X_data.shape[0], X_data.shape[1]))
    print("\nLength of the Label(Concat): {}".format(y_data.shape[0]))

  # Now for feature selection
  # Find of the best regularization degree
  parameters = {"C": np.logspace(-2, 1, num=20)}
  lsvc_op = LinearSVC(penalty="l1", dual=False)
  if verbose:
    v = 2
  else:
    v = 1
  clf = GridSearchCV(lsvc_op, parameters, verbose=v)
  clf.fit(X_data, y_data)

  # Get the best parameter
  best_c = clf.best_params_
  lsvc_fs = LinearSVC(C=best_c["C"], penalty="l1", dual=False, random_state=2021).fit(X_data, y_data)
  # Select from model
  model = SelectFromModel(lsvc_fs, prefit=True)
  X_data_reduced = model.transform(X_data)
  # Print the new shape
  if verbose:
    print("Number of Observation: {}\nNumber of features(Reduced): {}\
      ".format(X_data_reduced.shape[0], X_data_reduced.shape[1]))

  # If need further feature selection
  if further:
    sel = VarianceThreshold(threshold=(.8 * (1 - .8)))
    X_data_reduced = sel.fit_transform(X_data_reduced)
    if verbose:
      print("Number of Observation: {}\nNumber of features(Furter Reduced): {}\
        ".format(X_data_reduced.shape[0], X_data_reduced.shape[1]))

  # # Plot something
  # if verbose:
  #   # Covariance matrix
  #   df = pd.DataFrame(np.concatenate((X_data_reduced,
  #             np.reshape(y_data, (-1, 1))), axis=1))
  #   plt.figure(figsize=(15, 15))
  #   sns.heatmap(df.corr())
  #   plt.show()

  #   df_y = pd.Series(y_data).value_counts().plot.bar()
  #   plt.title("Class Distribution")
  #   plt.show()

  return X_data_reduced, y_data


if __name__ == "__main__":
  X, y = feature_selection("/home/mhuan98/ml-project/Patient_2/Patient_2.csv")
  X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.3)
  clf=RandomForestClassifier(n_estimators=100)
  clf.fit(X_train,y_train)
  y_pred=clf.predict(X_test)
  print('prediction, Patient_2')
  print(classification_report(y_test, y_pred))
  metrics.plot_roc_curve(clf, X_test, y_test)
  plt.savefig('prediction_Patient_2_roc.png')




