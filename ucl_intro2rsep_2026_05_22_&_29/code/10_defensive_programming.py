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
# #### Defensive programming

# %%
# Reliability (Assertion Precondition/Postcondition/Invariant)
# Write code that checks itself (its functions/working)

# %%
numbers = [1.5, 2.3, 0.7, -0.001, 4.4]
total = 0.0
for num in numbers:
    assert num > 0.0, 'Data should only have +ve values'
    #total += num # total = total + num (also works for - / *)
    total = total + num
print('total = ', total)


# %%
# Normalize rectangle
def normalize_rectangle(rect):
    """Normalizes a rectangle so that:
    1) it is at the origin and 
    2) 1.0 units long on its longest axis.
    Input rect should be of the format (x0,y0,x1,y1)
    (x0,y0) and (x1,y1) define the lower left and upper right corners of the rectangle"""

    assert len(rect) == 4, 'Rectangle must contain 4 components'

    x0, y0, x1, y1 = rect # unpacking a container (list/tuple)
    
    assert x0 < x1, 'Invalid X coordinates'
    assert y0 < y1, 'Invalid y coordinates'

    dx = x1 - x0 # length (of base)
    dy = y1 - y0 # height

    if dx > dy:
        scaled = dy/dx # dx/dy
        upper_x, upper_y = 1.0, scaled # unpacking
    else: # dx <= dy
        scaled = dx/dy
        upper_x, upper_y = scaled, 1.0 # unpacking

    assert 0 < upper_x <= 1.0, 'Calculated upper X coordinate invalid'
    assert 0 < upper_y <= 1.0, 'Calculated upper Y coordinate invalid' 
    
    return (0, 0, upper_x, upper_y)
    


# %%
print(normalize_rectangle((0,1,2))) # missing the 4th coordinate

# %%
print(normalize_rectangle( (4,2,1,5) )) # X axis inverted/x coordinates not in order specified

# %%
print(normalize_rectangle( (1,5,4,2) )) # Y axis inverted/y coordinates not in order specified

# %%
print(normalize_rectangle( (0, 0, 1, 5) )) 

# %%
print(normalize_rectangle( (0, 0, 5, 1) )) 

# %%
print(normalize_rectangle( (0, 0, 5, 1) )) 

# %%
