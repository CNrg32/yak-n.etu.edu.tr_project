// src/config/dbConfig.js
const mysql = require('mysql');
//buraya herkes oluşturduğu database user adı,şifresi,database ismini girsin;
const db = mysql.createConnection({
    host: 'localhost',
    user: 'root',
    password: '',
    database: 'mydb'
});

db.connect((err) => {
    if (err) {
        console.error('Error connecting to the database:', err);
        return;
    }
    console.log('Connected to the database');
});

module.exports = db;
