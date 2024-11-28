module.exports = (app) => {
    const studentCards = require('../controllers/Student_cards.controller');

    if (!studentCards) {
        console.error('Student_cards.controller.js could not be found or is undefined.');
        return;
    }

    // Define routes
    app.post('/student_cards', studentCards.create);
    app.get('/student_cards', studentCards.findAll);
    app.get('/student_cards/:cardId', studentCards.findOne);
    app.put('/student_cards/:cardId', studentCards.update);
    app.delete('/student_cards/:cardId', studentCards.delete);

    // Add new route for updating balance
    app.post('/student_cards/update_balance', studentCards.updateBalance);
};
