from sklearn.model_selection import train_test_split
from sklearn import preprocessing


def splitter(X_data, y_data, split_ratio=0.3, scaler=True):
  # Train test split
  X = X_data
  y = y_data
  X_train, X_test, y_train, y_test = train_test_split(X, y, 
  test_size=split_ratio, shuffle=True, random_state=2021)

  if scaler:
    train_scaler = preprocessing.StandardScaler().fit(X_train)
    # mean, scale
    # print("means:", "\n", train_scaler.mean_)
    # print("scales:", "\n", train_scaler.scale_)
    # Fit
    X_train = train_scaler.transform(X_train)

    # Test Data Scaler
    test_scaler = preprocessing.StandardScaler().fit(X_test)
    # Fit
    X_test = test_scaler.transform(X_test)
  return X_train, X_test, y_train, y_test