module.exports = app => {
    const courses = require('../controllers/Courses.controller');

    app.post('/courses', courses.create);              // Yeni bir ders oluştur
    app.get('/courses', courses.findAll);              // Tüm dersleri getir
    app.get('/courses/:courseId', courses.findOne);    // ID ile tek bir dersi getir
    app.put('/courses/:courseId', courses.update);     // ID ile dersi güncelle
    app.delete('/courses/:courseId', courses.delete);  // ID ile dersi sil
};
