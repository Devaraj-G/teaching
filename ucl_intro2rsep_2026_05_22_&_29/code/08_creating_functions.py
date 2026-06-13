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
#     display_name: dl_workshop
#     language: python
#     name: python3
# ---

# %% [markdown]
# # Creating functions

# %% [markdown]
# #### Define a new function

# %%
fahrenheit_val = 99
celsius_val = (fahrenheit_val - 32) * (5/9)
print(celsius_val)

# %%
fahrenheit_val = 43
celsius_val = (fahrenheit_val - 32) *(5/9)
print(celsius_val)


# %%
# function definition (def : return indent)
def fahr_to_celsius(temp):
    # after indent whatever comes is part of the function definition (= or what the function does)
    celsius_val = (temp - 32) * (5/9)
    return celsius_val


# %%
fahr_to_celsius(99)

# %%
fahr_to_celsius(43)


# %%
# function definition (value is retured differently)
def fahr_to_celsius_nicer(fahrenheit_val):
    # after indent whatever comes is part of the function definition (= or what the function does)
    return (fahrenheit_val - 32) * (5/9)


# %%
print(fahr_to_celsius(99))
print(fahr_to_celsius_nicer(99))


# %% [markdown]
# #### Composing functions (function using other functions, function using an output of another function)

# %%
# Convert celsius to kelvin
def celsius_to_kelvin(temp_c):
    return temp_c +273.15


# %%
print('freezing point of water in Kelvin:', celsius_to_kelvin(0))
print('freezing point of water in Kelvin: ', celsius_to_kelvin(0))

# %%
### Convert fahrenheit to Kelvin (fahrenheit to celsius to kelvin)
fahr_val = 32
cels_val = fahr_to_celsius(fahr_val)
kelv_val = celsius_to_kelvin(cels_val)
print('fahrenheit:', fahr_val)
print('celsius:', cels_val)
print('kelvin:', kelv_val)

# %%
fahr_val = 32
#cels_val = fahr_to_celsius(fahr_val)
kelv_val = celsius_to_kelvin( fahr_to_celsius(fahr_val) )
print('fahrenheit:', fahr_val)
#print('celsius:', cels_val)
print('kelvin:', kelv_val)


# %%
# Composite function
def fahr_to_kelvin(temp_f):
    temp_c = fahr_to_celsius(temp_f)
    temp_k = celsius_to_kelvin(temp_c)
    return temp_k


# %%
print('boiling point of water in Kelvin:', fahr_to_kelvin(212))


# %%
# Function with multiple outputs
def fahr_to_kelvin_multiple(temp_f):
    temp_c = fahr_to_celsius(temp_f)
    temp_k = celsius_to_kelvin(temp_c)
    return temp_k, temp_c


# %%
tem_k, tem_c = fahr_to_kelvin_multiple(212)
print('boiling point of water in Kelvin:', tem_k)
print('boiling point of water in Celsius:', tem_c)


# %% [markdown]
# #### Scope of variables in python (function or environment)

# %%
def print_temperature():
    print('temp. in Fahr was:', temp_fahr) # temp_fahr scope is inside the function
    print('temp. in Kelv was:', temp_kelvin)


# %%
temp_fahr = 212.0 # temp_fahr scope is outside the function (global)
temp_kelvin = fahr_to_kelvin(temp_fahr)

print_temperature()

# %% [markdown]
# #### Define functions with documentation and default values

# %%
import numpy
def offset_mean(data, target_mean_value):
    return (data - numpy.mean(data)) + target_mean_value


# %%
z = numpy.zeros((2,2))
print(offset_mean(z,3))


# %%
# Add documentation
def offset_mean(data, target_mean_value):
    """Return a new array containig the original 
    data with its means offset matching the desired value

    Example
    --------
    >>> offset_mean([1,2,3],0)
    array([-1, 0, 1])
    """ # docstring
    return (data - numpy.mean(data)) + target_mean_value


# %%
help(offset_mean)


# %%
# Add default values to variables/arguments/parameters
# variable is any variable inside the code e.g. data
# arguments are variable names used in a function e.g. target_mean_value
# parameter is the actual value given to the argument e.g. target_mean_value = 3

# %%
def display(a, b, c):
    print('a:', a, 'b:', b, 'c:', c)


# %%
display()

# %%
# required arguments == no of arguments in the function definition (usually)
# positional: means in the order of arguments written in the function definition
# keyword: apart from positional, there is also keyword argument

# %%
display(1,2,3)


# %%
def display(a=1.1, b=2.2, c=3.3):
    print('a:', a, 'b:', b, 'c:', c)


# %%
display()

# %%
display(1,2,3)

# %%
display(1,2)

# %%
display(a=1.2, b = 2.2, c = 3.2)

# %%
display(b=1.2, c = 2.2, a = 3.2)

# %%
# https://www.w3schools.com/python/python_arguments.asp
