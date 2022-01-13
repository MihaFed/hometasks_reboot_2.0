import requests
import numpy as np
import pandas as pd
from sqlalchemy import create_engine

limit_=100
def finite_sequence():
    offset_=0
    while True:
        yield offset_
        offset_ +=limit_

if __name__ == '__main__':
    res=[]
    for i in finite_sequence():
        url = f'https://xn--80az8a.xn--d1aqf.xn--p1ai/%D1%81%D0%B5%D1%80%D0%B2%D0%B8%D1%81%D1%8B/api/kn/object?offset={i}&limit={limit_}&sortField=devId.devShortCleanNm&sortType=asc&objStatus=0'
        objects_data = requests.get(url).json()
        objects_list = objects_data.get('data').get('list')
        if len(objects_list)>0:
            res.extend(objects_list)
        else:
            break

    #сохранение информации о новостройках в pandas dataframe
    extracted = pd.json_normalize(res)
    print('Количество новостроек = ',len(extracted))

    #Cохранение pandas dataframe в excel
    extracted.to_excel("FED_output.xlsx")

    #Cохранение pandas dataframe в pickle
    extracted.to_pickle("FED_output_pkl.pkl")

    #Cохранение pandas dataframe в БД
    from sqlalchemy import create_engine
    buildings = create_engine('sqlite://', echo=False)
    extracted.to_sql('new_build', con=buildings,if_exists='replace')
