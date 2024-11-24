const express = require('express');
const app = express();
const PORT = 3001;
const bodyParser = require('body-parser');
const cors = require('cors');
const db = require('./config/db_config'); // Veritabanı bağlantısını içe aktarın

// Middleware'ler
app.use(cors());
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));

// Loglama middleware'i
app.use((req, res, next) => {
    console.log(`${req.method}:${req.url}`);
    next();
});

// Ana sayfa rotası
app.get('/', (req, res) => {
    res.send('Welcome to the API homepage!');
});

// Veritabanı bağlantısını istek nesnesine ekleyin
app.use((req, res, next) => {
    req.db = db;
    next();
});

// Rota tanımlamaları
require('./routes/Cafeteria_Menu.routes')(app);
require('./routes/Classrooms.routes')(app);
require('./routes/Courses.routes')(app);
require('./routes/Enrollments.routes')(app);
require('./routes/Friends.routes')(app);
require('./routes/Student_Cards.routes')(app);
require('./routes/Users.routes')(app);

// Sunucuyu başlatma
app.listen(PORT, () => {
    console.log(`Server running at http://localhost:${PORT}`);
});
const studentCardRoutes = require('./routes/Student_Cards.routes');
studentCardRoutes(app);

