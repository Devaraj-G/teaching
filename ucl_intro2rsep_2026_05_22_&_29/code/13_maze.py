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
# ### Data structures
# #### Nested lists and dictionaries

# %%
# Dictionary

chapman = {
    'name' : 'Graham',
    'age' : 48,
    'jobs' : ['Comedian', 'writer']
}

# %%
print(chapman)

# %%
print(chapman['age'])

# %%
print(type(chapman))

# %%
# keys and vallues
print(chapman.keys())
print(chapman.values())

# %%
'jobs' in chapman

# %%
'Hobbies' in chapman

# %%
'jobs' in chapman.keys()

# %%
'Graham' in chapman

# %%
'Graham' in chapman.values()

# %%
# Nested dictionary

UCL = {
    'city' : 'london',
    'street' : 'gower street',
    'postcode' : 'wce1 6bt'
}

# %%
Chapman_house = {
    'city' : 'london',
    'street' : 'southwood ln',
    'postcode' : 'n6 5tb'
}

# %%
print(UCL, Chapman_house)

# %%
addresses = [UCL, Chapman_house]

# %%
print(addresses)

# %%
UCL['people'] = ['jeremy', 'james']
Chapman_house['people'] = ['graham', 'amanda']

# %%
print(UCL, Chapman_house)

# %%
### Containers

# %%
[1,3,7]

# %%
type([1,3,7])

# %%
various_things = [1, 2, 'banana', 3.4, [1,2]]

# %%
various_things

# %%
print(various_things[2])

# %%
names = ['grace', 'brewster', 'murray', 'hopper']

# %%
print(" ".join(names))

# %%
# sequence - strings lists
print('james'[2])

# %%
print('hello world'[4:8])

# %%
# Unpacking
mylist = ['goodbye', 'cruel']
a,b = mylist
print(a,b)

# %%
# check for containment
'dog' in ['cat', 'dog', 'horse']

# %%
2 in range(5)

# %%
list(range(5))

# %%
'a' in 'cat'

# %%
# mutability
# a list can be modified
name = 'grace webster murray hopper'.split(' ')

# %%
name

# %%
name[0:3] = ['Admiral']
name

# %%
name.append('phd')
name

# %%
print(' '.join(name))

# %%
# tuple cannot be changed (immutable)
my_tuple = ('hello','world', 1)

# %%
my_tuple[0] = 'goodbye'

# %%
my_set = {'hello','world', 1}

# %%
my_set.update('b')

# %%
my_set

# %%
# memory
x = list(range(3))
print(x)

# %%
y = x
print(y)

# %%
z = x[0:3]
print(z)

# %%
y[1] = 'gotcha'

# %%
print(x)
print(y)
print(z)

# %%
yy = x[:]
yy[0] = 'gotcha'

# %%
print(x)
print(yy)

# %%
