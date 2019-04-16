from os import path

import json
import psycopg2
import person_generator

basepath = path.dirname(__file__)
try:
    
    filepath = path.abspath(path.join(basepath, "..",  "secrets.json"))
    secrets = json.load( open(filepath, "r"))
except:
    print('secrets file not found')
    quit

print('Connecting to host: "' +secrets['pgHost'] + '", database: "' + secrets['pgDatabase'] + '" as user "' + secrets['pgUsername'] +'"')

connection = psycopg2.connect(host=secrets['pgHost'], database=secrets['pgDatabase'], user = secrets['pgUsername'], password= secrets['pgPassword'])
cur = connection.cursor()


print('Dropping tables if they exist')
dropSql = open(path.abspath(path.join(basepath,"..", "scripts",'drop_tables.sql')))
cur.execute(dropSql.read())
connection.commit()

print('Creating the tables')
createSql = open(path.abspath(path.join(basepath,"..","scripts",'create_tables.sql')))
cur.execute(createSql.read())
connection.commit()

#seed the tables with data

# batch insert

maleNames = open(path.abspath(path.join(basepath,"..", "data",'first_names_male.csv'))).read().splitlines()
femaleNames = open(path.abspath(path.join(basepath,"..", "data",'first_names_female.csv'))).read().splitlines()
lastNames = open(path.abspath(path.join(basepath,"..", "data",'last_names.csv'))).read().splitlines()

for p in person_generator.generateMany(femaleNames,maleNames,lastNames,1000):
    print(p)

connection.close()