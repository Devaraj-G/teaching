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
# # DenseNet-121

# %%
import tensorflow as tf
import seaborn as sns
import numpy as np
import sklearn
import pathlib

# %%
DATA_FOLDER = pathlib.Path('/home/jovyan/data/dataset_dollarstreet') # change to location where you stored the data
train_images = np.load(DATA_FOLDER / 'train_images.npy')
val_images = np.load(DATA_FOLDER / 'test_images.npy')
train_labels = np.load(DATA_FOLDER / 'train_labels.npy')
val_labels = np.load(DATA_FOLDER / 'test_labels.npy')

# %%
train_images.min(), train_images.max()

# %%
train_images = train_images/255.0
val_images = val_images/255.0

# %%
train_images.shape
# but pretrained model images 160x160
# our data is 64 x 64

# %%
from tensorflow import keras
keras.utils.set_random_seed(2)

inputs = keras.Input(train_images.shape[1:])

# %%
method = tf.image.ResizeMethod.BILINEAR
upscale = keras.layers.Lambda(
    lambda x: tf.image.resize_with_pad(x,160,160,method=method)
)(inputs)

# %%
base_model = keras.applications.DenseNet121(
    include_top = False,
    pooling = 'max',
    weights = 'imagenet',
    input_tensor = upscale,
    input_shape = (160,160,3)
)

# %%
base_model.trainable = False

# %%
# head network
out = base_model.output
out = keras.layers.Flatten()(out)
out = keras.layers.BatchNormalization()(out)
out = keras.layers.Dense(50,activation = 'relu')(out)
out = keras.layers.Dropout(0.5)(out)
out = keras.layers.Dense(10)(out)

# %%
model = keras.models.Model(inputs = inputs, outputs = out)

# %% [markdown]
# model.summary()

# %%
model.compile(optimizer = 'adam',
             loss = keras.losses.SparseCategoricalCrossentropy(from_logits = True),
             metrics = ['accuracy'])

# %%
early_stopper = keras.callbacks.EarlyStopping(monitor = 'val_accuracy',
                                             patience = 5)

# %%
history = model.fit(x = train_images,
                   y = train_labels,
                   batch_size = 32,
                   epochs = 30,
                   callbacks = [early_stopper],
                   validation_data = (val_images,val_labels))

# %%
import pandas as pd
import matplotlib.pyplot as plt
def plot_history(history,metrics):
    history_df = pd.DataFrame.from_dict(history.history)
    sns.lineplot(data = history_df[metrics])
    plt.xlabel('epochs')
    plt.ylabel('metric')

plot_history(history,['accuracy','val_accuracy'])

# %%
