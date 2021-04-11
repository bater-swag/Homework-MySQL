from xeger import Xeger
import pandas as pd
import csv

# генерация номеров по регресионному выражению
r=[]
x = Xeger(limit=100)
for i in range(100):
    r.append(x.xeger("^[АВЕКМНОРСТУХ]\d{3}(?<!000)[АВЕКМНОРСТУХ]{2}\d{2,3}$"))

# сохранение данных в csv
wtr = csv.writer(open('data.csv', 'w'), delimiter=',', lineterminator='\n')
wtr = pd.DataFrame({'numbers': r})
wtr.to_csv('my.csv', index=False)


