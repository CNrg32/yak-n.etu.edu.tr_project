module.exports = app => {
    const studentCards = require('../controllers/Student_Cards.controller');

    app.post('/student_cards', studentCards.create);               // Yeni bir öğrenci kartı oluştur
    app.get('/student_cards', studentCards.findAll);               // Tüm öğrenci kartlarını getir
    app.get('/student_cards/:cardId', studentCards.findOne);       // ID ile tek bir öğrenci kartını getir
    app.put('/student_cards/:cardId', studentCards.update);        // ID ile öğrenci kartını güncelle
    app.delete('/student_cards/:cardId', studentCards.delete);     // ID ile öğrenci kartını sil
};
