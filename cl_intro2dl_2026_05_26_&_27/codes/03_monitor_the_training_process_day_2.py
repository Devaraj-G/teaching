# ---
# jupyter:
#   jupytext:
#     formats: ipynb,py:percent
#     text_representation:
#       extension: .py
#       format_name: percent
#       format_version: '1.3'
#       jupytext_version: 1.19.3
#   kernelspec:
#     display_name: Python 3 (ipykernel)
#     language: python
#     name: python3
# ---

# %% [markdown]
# #### 1. Formulate the problem
# > Use the weather prediction dataset
# > Aim: Predict tomorrow's sunshine hours

# %% [markdown]
# #### 2. Identify inputs and outputs

# %%
import time
import pandas as pd

data = pd.read_csv('https://zenodo.org/record/5071376/files/weather_prediction_dataset_light.csv?download=1')

# %%
data.head()

# %%
data.shape

# %%
data.columns

# %%
nr_rows = 365*3
X_data = data.loc[:nr_rows]
X_data = X_data.drop(columns = ['DATE','MONTH'])
X_data

# %%
# labels for sunshine hurs of the next day
y_data = data.loc[1:(nr_rows + 1)]['BASEL_sunshine']

# %%
y_data.shape, X_data.shape

# %% [markdown]
# #### 3. Split in train/test/validation sets

# %%
from sklearn.model_selection import train_test_split

# %%
X_train, X_holdout, y_train, y_holdout = train_test_split(
    X_data,
    y_data,
    test_size = 0.3,
    random_state = 0,
)

# %%
X_val, X_test, y_val, y_test = train_test_split(
    X_holdout,
    y_holdout,
    test_size = 0.5,
    random_state = 0,
)

# %% [markdown]
# #### 4. Build architecture

# %%
from tensorflow import keras
keras.utils.set_random_seed(2)

def create_nn(input_shape):
    # input layer
    inputs = keras.Input(shape = input_shape,name = 'input')

    # dense layer 1 & 2
    layers_dense = keras.layers.Dense(100,'relu')(inputs)
    layers_dense = keras.layers.Dense(50,'relu')(layers_dense)

    # output layer
    outputs = keras.layers.Dense(1)(layers_dense)

    return keras.Model(inputs = inputs, outputs = outputs, name = 'weather_prediction_model')


# %%
model = create_nn(input_shape = (X_data.shape[1],))
model.summary()

# %%
X_train.shape

# %%
X_data.shape[1]

# %%
model.summary()

# %%
# 89 inputs * 100 neurons + 100 biases = 9000
# 100 outputs * 50 neurons + 50 biases = 5050
# 50 outputs * 1 neuron + 1 bias = 51

# %% [markdown]
# #### 5. Choose loss and optimizer

# %%
model.compile(loss = 'mse')
model.compile(optimizer = 'adam',
              loss = 'mse')
model.compile(optimizer = 'adam',
             loss = 'mse', # loss is what drives the optimizer (weight updates)
             metrics = [keras.metrics.RootMeanSquaredError()]) # metrics are stored for viewing


# %%
def compile_model(model):
    model.compile(optimizer = 'adam',
                 loss = 'mse',
                 metrics = [keras.metrics.RootMeanSquaredError()])
    


# %%
compile_model(model)

# %% [markdown]
# #### Train the model (use Training set)

# %%
history = model.fit(X_train, y_train,
                    batch_size = 32,
                    epochs = 200,
                    verbose = 1)

# %%
X_train.shape[0]

# %%
X_train.shape[0]/32

# %%
import seaborn as sns
import matplotlib.pyplot as plt

def plot_history(history,metrics):
    plt.style.use('ggplot')
    history_df = pd.DataFrame.from_dict(history.history)
    sns.lineplot(data = history_df[metrics])
    plt.xlabel('epochs')


# %%
plot_history(history,'root_mean_squared_error')

# %%
# Oh! the training is super-perfect

# %% [markdown]
# #### 7. Perform a prediction

# %%
y_train_predicted = model.predict(X_train)
y_test_predicted = model.predict(X_test)


# %% [markdown]
# #### 8. Measure performance

# %%
# Plotting function
def plot_predictions(y_pred, y_true, title, xlab, ylab):
    plt.style.use('ggplot')
    plt.scatter(y_pred, y_true, s = 10, alpha = 0.5)
    plt.axline((0,0), slope = 1, color = 'black')
    plt.xlabel(xlab)
    plt.ylabel(ylab)
    plt.title(title)


# %%
plot_predictions(y_pred = y_train_predicted,
                y_true = y_train,
                title = 'Predictions on the training data',
                xlab = 'Predicted sunshine for tomorrow',
                ylab = 'True sunshine hours for tomorrow')
# CHECK on training data (Good to check fit/training is ok? But model has seen the training data)

# %%
plot_predictions(y_test_predicted,
                 y_test,
                 title = 'Predictions on the test set',
                 xlab = 'Predicted sunshine for tomorrow',
                 ylab = 'True sunshine hours for tomorrow')
# CHECK on test data (Important! Because the model training has not seen the test data yet) 
# Detect overfitting = memorization (Training looks good, but prediction on test is bad!)
# Detect undefitting
# Balance means the model generalizes (the boundary between under- and over-fitting)

# %%
train_metrics = model.evaluate(X_train, y_train, return_dict = True)
test_metrics = model.evaluate(X_test, y_test, return_dict = True)
print('Train RMSE: {:.2f}, Test RMSE: {:.2f}'.format(
    train_metrics['root_mean_squared_error'],
    test_metrics['root_mean_squared_error']    
))

# %%
# Baseline (what you decide is an expected performance level for your model)
y_baseline_prediction = X_test['BASEL_sunshine']
plot_predictions(y_baseline_prediction,
                y_test,
                title = 'Baseline',
                xlab = 'Sunshine for today',
                ylab = 'Sunshine for tomorrow')

# %%
from sklearn.metrics import root_mean_squared_error
rmse_baseline = root_mean_squared_error(y_test, y_baseline_prediction)
print('Baseline:', rmse_baseline)
print('Neural Network: ', test_metrics['root_mean_squared_error'])

# %% [markdown]
# #### 9. Refine the model

# %%
model = create_nn(input_shape = (X_data.shape[1],))
compile_model(model)

# %%
history = model.fit(X_train, y_train,
                   batch_size = 32,
                   epochs = 200,
                   validation_data =(X_val,y_val)) # came from splittig holdout into test/val

# %%
plot_history(history,
             ['root_mean_squared_error', 'val_root_mean_squared_error'])
# training set is seen by the model training
# validation set is not seen by the model training

# %%
# Early stopping
model = create_nn(input_shape=(X_data.shape[1],))
compile_model(model)

# %%
from tensorflow.keras.callbacks import EarlyStopping

earlystopper = EarlyStopping(
    monitor = 'val_loss',
    patience = 10
)

history = model.fit (X_train, y_train,
                     batch_size = 32,
                     epochs = 200,
                     validation_data = (X_val, y_val),
                     callbacks = [earlystopper]
                    )

# %%
plot_history(history,
            ['root_mean_squared_error', 'val_root_mean_squared_error'])

# %%
