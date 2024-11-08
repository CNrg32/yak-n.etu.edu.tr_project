module.exports = app => {
    const classrooms = require('../controllers/Classrooms.controller');

    app.post('/classrooms', classrooms.create);                // Yeni bir sınıf oluştur
    app.get('/classrooms', classrooms.findAll);                // Tüm sınıfları getir
    app.get('/classrooms/:classroomId', classrooms.findOne);   // ID ile tek bir sınıf getir
    app.put('/classrooms/:classroomId', classrooms.update);    // ID ile sınıfı güncelle
    app.delete('/classrooms/:classroomId', classrooms.delete); // ID ile sınıfı sil
};
