module.exports = app => {
    const enrollments = require('../controllers/Enrollments.controller');

    app.post('/enrollments', enrollments.create);                // Yeni bir kayıt oluştur
    app.get('/enrollments', enrollments.findAll);                // Tüm kayıtları getir
    app.get('/enrollments/:enrollmentId', enrollments.findOne);  // ID ile tek bir kaydı getir
    app.put('/enrollments/:enrollmentId', enrollments.update);   // ID ile kaydı güncelle
    app.delete('/enrollments/:enrollmentId', enrollments.delete); // ID ile kaydı sil
};
