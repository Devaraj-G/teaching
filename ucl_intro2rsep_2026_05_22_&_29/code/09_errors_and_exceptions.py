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
# ### Errors and exceptions

# %%
# Read through some of the errors and identify 'parts' in the errors

# %%
def fav_ice_cream():
    ice_creams = [
        'chocolate',
        'vanilla',
        'strawberry'
    ]
    print(ice_creams[3])


# %%
fav_ice_cream()


# %%
def print_message(day):
    messages = [
        'Hello, world!',
        'Today is Tuesday!',
        'It is the middle of the week.',
        'Today is Donnerstag in German!',
        'Last day of the week!',
        'Hooray for the weekend!',
        'Aw, the weekend is almost over.'
    ]
    print(messages[day])

def print_sunday_message():
    print_message(7)

print_sunday_message()


# %% [raw]
# How many levels does the traceback have? 3
# What is the function name where the error occurred? 11     print(messages[day])
# On which line number in this function did the error occur? 11
# What is the type of error? IndexError
# What is the error message? list index out of range

# %%
# Another type of error: syntax
def some_func()
    msg = 'hello world'
    print(msg)
    return msg

some_func()


# %%
# Another type of error: indent
def some_func():
    msg = 'hello world'
    print(msg)
     return msg

some_func()

# %%
# Search IDE
# VS-code spyder RStudio
