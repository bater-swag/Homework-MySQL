import pandas as pd
import csv

# выбрать из csv ток интересующие поля
r = pd.read_csv('csv.csv', delimiter=';')
r['model'] = r['Acura'].astype(str).str.zfill(2) + r['CL'].astype(str).str.zfill(3)

# сохранить как новый csv
with open('data.csv', 'w') as fp:
    csvw = csv.writer(fp)
    csvw = pd.DataFrame(r, columns=['model'])
    csvw.to_csv('my_csv_export.csv', index=False)