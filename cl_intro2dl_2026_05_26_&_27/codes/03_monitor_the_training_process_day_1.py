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

    # dense layer
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
# #### Choose loss and optimizer

# %%
model.compile(loss = 'mse')
model.compile(optimizer = 'adam',
              loss = 'mse')
model.compile(optimizer = 'adam',
             loss = 'mse',
             metrics = [keras.metrics.RootMeanSquaredError()])


# %%
def compile_model(model):
    model.compile(optimizer = 'adam',
                 loss = 'mse',
                 metrics = [keras.metrics.RootMeanSquaredError()])
    


# %%
compile_model(model)

# %% [markdown]
# #### Train the model

# %%
history = model.fit(X_train, y_train,
                    batch_size = 32,
                    epochs = 200,
                    verbose = 0)

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
