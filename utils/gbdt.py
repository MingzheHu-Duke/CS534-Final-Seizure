# explore adaboost ensemble tree depth effect on performance
import pandas as pd
import numpy as np
from numpy import mean
from numpy import std
from  sklearn.tree import DecisionTreeClassifier



class gdbt:
  def __init__(self):
    self.model == []
    self.labels = None
    self.X = None
    self.categories = None
    pass
  
  def _loss(self, pred, truth):
    pred = pred.reshape(-1)
    loss = int(truth==1)*np.log(self._pk(pred))
    return loss,0
  
  def _pk(self,y,k=1):
    y = y.reshape(-1)
    if k == 1:
      return np.exp(y) / (np.exp(y) + np.exp(1-y))
    else:
      return np.exp(1-y) / (np.exp(y) + np.exp(1-y))

  def _gradient(self, pred, truth):
    pred = pred.reshape(-1)
    return (int(truth==1) - self._pk(pred))

  def fit(self, x2f, y2f, n_estimators=100, **kwargs):
    self.categories = set(y2f)
    self.X = np.array(x2f)
    y = np.array(y2f).reshape(-1)
    tree = DecisionTreeClassifier(**kwargs).fit(X,y)
    self.model.append(tree)
    pred = tree.predict_proba(X)
    for i in range(n_estimators):
      rim = - self._gradient(int(pred>0.5))
      tree = DecisionTreeClassifier(**kwargs).fit(X,rim)
      self.model.append(tree)
      pred = pred + 0.1*tree.predict_proba(X)
  
  def predict(self, x2p):
    X = np.array(x2p)
    pred = self.model[0].predict_proba(X)
    for i in range(2,len(self.model)):
      tree = self.model[i]
      pred = pred + 0.1*tree.predict_proba(X)
    return pred