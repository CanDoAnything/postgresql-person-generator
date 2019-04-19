var fs = require('fs');
var path = require('path');

const { Client } = require('pg');

var filePath = path.join(__dirname, '..', 'secrets.json');
var secrets = JSON.parse(fs.readFileSync(filePath,'utf8'));


const config = {
    host: secrets.pgHost,
    database: secrets.pgDatabase,
    user: secrets.pgUsername,
    password: secrets.pgPassword,
    port:5432
}


const client = new Client(config)


client.connect()
const res =  client.query('SELECT COUNT(*) FROM person')
console.log(res.rows[0].message)
client.end()

var filePath = path.join(__dirname, '..', 'scripts','drop_tables.sql');
var sqlString = fs.readFileSync(filePath,'utf8');
