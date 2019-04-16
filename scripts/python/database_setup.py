from os import path

import json
import psycopg2

try:
    basepath = path.dirname(__file__)
    filepath = path.abspath(path.join(basepath, "..", "..", "secrets.json"))
    secrets = json.load( open(filepath, "r"))
except:
    print('secrets file not found')
    quit

print('Connecting to database using ' + secrets['pgUsername'])


connection = psycopg2.connect(host=secrets['pgHost'], database=secrets['pgDatabase'], user = secrets['pgUsername'], password= secrets['pgPassword'])
cur = connection.cursor()


cur.execute("SELECT version()")
db_version = cur.fetchone()
print(db_version)