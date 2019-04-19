var fs = require('fs');
var path = require('path');

const pgp = require('pg-promise');

var filePath = path.join(__dirname, '..', 'secrets.json');
var secrets = JSON.parse(fs.readFileSync(filePath,'utf8'));


// const cn = {
//     host: secrets.pgHost,
//     database: secrets.pgDatabase,
//     user: secrets.pgUsername,
//     password: secrets.pgPassword,
//     port:5432
// }


const db = pgp('postgres://127.0.0.1:5432/demo_db');

db.any('SELECT COUNT(*) FROM person')
.then(data=> {
    console.log('Data:',data);
})
.catch(error => {
    console.log("oopsie:",error);
})
.finally(db.$pool.end);


client.connect()
// client.query('SELECT COUNT(*) FROM person')
//     .then(res => console.log(res.rows[0]))
//     .catch(e => console.error(e.stack))



var filePath = path.join(__dirname, '..', 'scripts','drop_tables.sql');
var sqlString = fs.readFileSync(filePath,'utf8');
