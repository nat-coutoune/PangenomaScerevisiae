import csv
import pandas as pd
import numpy as np

#certifique-se que o arquivo csv esteja no mesmo diretorio
df = pd.read_csv("MOs_clean.csv")

spots = df["Spots"].tolist()

i = 0
for spot in spots:
    if ("M" in spot):
        print(df['RUN'][i])
        i = i + 1
        continue
    if ("," in spot[:3]):
        i = i + 1
        continue
    if (int(spot[:3]) >= 800):
        print(df['RUN'][i])
        i = i +1
        continue
    i = i+1
