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
from sklearn import preprocessing
from sklearn.metrics import roc_curve, auc
import imblearn
import warnings
warnings.filterwarnings("ignore")

def feature_selection(file_path, verbose=False, further=True):
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
  X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, shuffle = True)
  oversample = imblearn.over_sampling.SMOTE()
  X_train, y_train = oversample.fit_resample(X_train, y_train)
  train_scaler = preprocessing.StandardScaler().fit(X_train)
  X_train = train_scaler.transform(X_train)
  X_test = train_scaler.transform(X_test)
  clf=RandomForestClassifier(max_features = "sqrt")
  param_grid = {
                 'n_estimators': [50,100,150,200],
                 'max_depth': [1,2,3,4,5]
             }
  grid_clf = GridSearchCV(clf, param_grid, cv=5)
  grid_clf.fit(X_train,y_train)
  train_predict = grid_clf.predict(X_train)
  test_predict = grid_clf.predict(X_test)
  print("Training Performance Patient_2")
  print(classification_report(y_train, train_predict, target_names=["Normal", "Siezure"]))
  print("\n")
  print("Test Performance Patient_2")
  print(classification_report(y_test, test_predict, target_names=["Normal", "Siezure"]))


  y_hat = grid_clf.predict_proba(X_test)[:, 1]
  # Calculate the ROC Curves
  fpr, tpr, thresholds = roc_curve(y_test, y_hat)
  # Get the g-mean for each threshold
  gmeans = np.sqrt(tpr * (1-fpr))
  # Locate the index
  ix = np.argmax(gmeans)

  fig, ax = plt.subplots(figsize=(8, 8))
  metrics.plot_roc_curve(grid_clf, X_test, y_test, ax=ax)
  ax.plot([0,1], [0,1], linestyle='--', label='No Skill')
  ax.scatter(fpr[ix], tpr[ix], marker='o', color='red', label='Best')
  ax.set_title("Test ROC Curve\nRandom Forest")
  plt.savefig('prediction_Patient_2_roc.png')

  print("Test Performance Patient_2")
  print(classification_report(y_test, (grid_clf.predict_proba(X_test)[:,1] >= thresholds[ix]).astype(bool), target_names=["Normal", "Siezure"]))


