#!/usr/bin/env python
# coding: utf-8

import pandas as pd
from sqlalchemy import create_engine

nov_green_data = pd.read_parquet('green_tripdata_2025-11.parquet')
zone = pd.read_csv('taxi_zone_lookup.csv')

engine= create_engine(f'postgresql://root:root@localhost:5433/ny_taxi')

nov_green_data.to_sql(name='green_taxi_data', con=engine, if_exists='replace')

zone.to_sql(name='taxi_zone', con=engine, if_exists='replace')

