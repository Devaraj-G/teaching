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
# #### Advanced layer types

# %%
# Download data
# !mkdir -p /home/jovyan/data/dataset_dollarstreet
# !wget -nc -P /home/jovyan/data/dataset_dollarstreet https://zenodo.org/records/10970014/files/test_images.npy
# !wget -nc -P /home/jovyan/data/dataset_dollarstreet https://zenodo.org/records/10970014/files/test_labels.npy
# !wget -nc -P /home/jovyan/data/dataset_dollarstreet https://zenodo.org/records/10970014/files/train_images.npy
# !wget -nc -P /home/jovyan/data/dataset_dollarstreet https://zenodo.org/records/10970014/files/train_labels.npy

# %%
# import libraries
import pathlib
import numpy as np
import tensorflow
from tensorflow import keras
import sklearn
import keras_tuner
import matplotlib.pyplot as plt
import time

# %%
# Setup path and variables
DATA_FOLDER = pathlib.Path('/home/jovyan/data/dataset_dollarstreet') # change to location where you stored the data
train_images = np.load(DATA_FOLDER / 'train_images.npy')
val_images = np.load(DATA_FOLDER / 'test_images.npy')
train_labels = np.load(DATA_FOLDER / 'train_labels.npy')
val_labels = np.load(DATA_FOLDER / 'test_labels.npy')

# %%
train_images.shape, val_images.shape, train_labels.shape, val_labels.shape

# %%
train_images.shape

# %%
train_images.min(),train_images.max()

# %%
label_to_categories = {
    0: "day bed",
    1: "dishrag",
    2: "plate",
    3: "running shoe",
    4: "soap dispenser",
    5: "street sign",
    6: "table lamp",
    7: "tile roof",
    8: "toilet seat",
    9: "washing machine"
}

# %%
# plot class distribution
unique_classes, counts = np.unique(train_labels, return_counts = True)
class_names = [label_to_categories[i] for i in unique_classes]

plt.figure(figsize = (12,5))
plt.bar(class_names, counts)
plt.xticks(rotation = 50)
plt.xlabel('Category')
plt.ylabel('Number of images')
plt.title('Training class distribution')

# %%
sample_number = 820
label_sample = label_to_categories[train_labels[sample_number]]
train_labels[sample_number],label_sample

# %%
plt.imshow(train_images[sample_number])
plt.title(f"{label_sample}")
plt.show()

# %%
train_images = train_images/255.0
val_images = val_images/255.0

# %%
width, height = (64,64)
n_channels = 3
n_hidden_neurons = 100
n_input_items = width * height * n_channels
n_parameters = (n_input_items + 1) * n_hidden_neurons

# %%
n_parameters

# %%
keras.utils.set_random_seed(2)
inputs = keras.Input(shape = (n_input_items,))
outputs = keras.layers.Dense(n_hidden_neurons)(inputs)
model = keras.models.Model(inputs = inputs, outputs = outputs)
model.summary()


# %%
def create_nn(input_shape):
    inputs = keras.Input(shape = input_shape)
    x = keras.layers.Conv2D(50, (3,3), activation = 'relu')(inputs)
    x = keras.layers.MaxPooling2D((2,2))(x) # a new type of layer
    x = keras.layers.Conv2D(50, (3,3), activation = 'relu')(x)
    x = keras.layers.MaxPooling2D(2,2)(x)
    x = keras.layers.Flatten()(x)
    x = keras.layers.Dense(50,activation= 'relu')(x)
    outputs = keras.layers.Dense(10)(x)

    model = keras.Model(inputs = inputs, outputs = outputs, name = 'dollar_street_model')
    return model


# %%
model = create_nn(input_shape = train_images.shape[1:])
model.summary()

# %%
train_images.shape[1:]


# %%
def compile_model(model):
    model.compile(optimizer = 'adam',
                 loss = keras.losses.SparseCategoricalCrossentropy(from_logits = True),
                 metrics = ['accuracy'])


# %%
compile_model(model)

# %%
history = model.fit(train_images,
                   train_labels,
                   epochs = 10,
                   validation_data = (val_images,val_labels))

# %%
import seaborn as sns
import matplotlib.pyplot as plt
import pandas as pd

def plot_history(history, metrics):
    history_df = pd.DataFrame.from_dict(history.history)
    sns.lineplot(data = history_df[metrics])
    plt.xlabel('epochs')
    plt.ylabel('metric')

plot_history(history, ['accuracy','val_accuracy'])

# %%
plot_history(history,
            ['loss','val_loss'])


# %%
def create_nn(input_shape):
    inputs = keras.Input(shape = input_shape)
    x = keras.layers.Conv2D(50, (3,3), activation = 'relu')(inputs)
    x = keras.layers.MaxPooling2D((2,2))(x) # a new type of layer
    x = keras.layers.Conv2D(50, (3,3), activation = 'relu')(x)
    x = keras.layers.MaxPooling2D(2,2)(x)
    x = keras.layers.Conv2D(50, (3,3), activation = 'relu')(x)
    x = keras.layers.MaxPooling2D(2,2)(x)
    x = keras.layers.Flatten()(x)
    x = keras.layers.Dense(50,activation= 'relu')(x)
    outputs = keras.layers.Dense(10)(x)

    model = keras.Model(inputs = inputs, outputs = outputs, name = 'dollar_street_model')
    return model


# %%
model = create_nn(input_shape = train_images.shape[1:])
model.summary()

# %%
compile_model(model)
history = model.fit(train_images,
                   train_labels,
                   epochs = 10,
                   validation_data = (val_images,val_labels))

# %%
plot_history(history, ['accuracy','val_accuracy'])


# %%
plot_history(history,
            ['loss','val_loss'])

# %%
# Drop-out
keras.utils.set_random_seed(2)
def create_nn_with_dropout():
    inputs = keras.Input(shape=train_images.shape[1:])
    x = keras.layers.Conv2D(50, (3, 3), activation='relu')(inputs)
    x = keras.layers.MaxPooling2D((2, 2))(x)
    x = keras.layers.Dropout(0.8, seed = 1)(x) # This is new!

    x = keras.layers.Conv2D(50, (3, 3), activation='relu')(x)
    x = keras.layers.MaxPooling2D((2, 2))(x)
    x = keras.layers.Dropout(0.8, seed = 1)(x) # This is new!

    x = keras.layers.Conv2D(50, (3, 3), activation='relu')(x)
    x = keras.layers.MaxPooling2D((2, 2))(x)
    x = keras.layers.Dropout(0.8, seed = 1)(x) # This is new!

    x = keras.layers.Flatten()(x)
    x = keras.layers.Dense(50, activation='relu')(x)
    outputs = keras.layers.Dense(10)(x)
    model = keras.Model(inputs=inputs, outputs=outputs, name="dropout_model")
    return model

model_dropout = create_nn_with_dropout()
model_dropout.summary()

# %%
compile_model(model_dropout)
history = model_dropout.fit(train_images,train_labels,
                        epochs = 20,
                        validation_data = (val_images, val_labels),
                        )

# %%
plot_history(history, ['accuracy','val_accuracy'])

# %%
