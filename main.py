import numpy as np
import pandas as pd
import tensorflow as tf

if __name__ == '__main__':
    print("Hello world")
    x = np.array([1, 2, 3])
    print(f"array is: {x}")
    print(f"array is: {x ** 2}")
    k = pd.DataFrame({"x": x})
    print("\n",k.head())
    print(tf.__version__)