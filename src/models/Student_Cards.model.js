const sql = require('../config/db_config');

const StudentCard = function (card) {
    this.user_id = card.user_id;
    this.balance = card.balance;
};

StudentCard.create = (newCard, result) => {
    sql.query('INSERT INTO Student_Cards SET ?', newCard, (err, res) => {
        if (err) {
            console.log('Error creating student card:', err);
            result(err, null);
            return;
        }
        result(null, { id: res.insertId, ...newCard });
    });
};

StudentCard.getAll = (result) => {
    sql.query('SELECT * FROM Student_Cards', (err, res) => {
        if (err) {
            console.log('Error retrieving student cards:', err);
            result(null, err);
            return;
        }
        result(null, res);
    });
};

StudentCard.findById = (id, result) => {
    sql.query('SELECT * FROM Student_Cards WHERE card_id = ?', [id], (err, res) => {
        if (err) {
            console.log('Error finding student card by ID:', err);
            result(err, null);
            return;
        }
        if (res.length) {
            result(null, res[0]);
            return;
        }
        result({ kind: 'not_found' }, null);
    });
};

StudentCard.updateById = (id, card, result) => {
    sql.query(
        'UPDATE Student_Cards SET user_id = ?, balance = ? WHERE card_id = ?',
        [card.user_id, card.balance, id],
        (err, res) => {
            if (err) {
                console.log('Error updating student card:', err);
                result(err, null);
                return;
            }
            if (res.affectedRows === 0) {
                result({ kind: 'not_found' }, null);
                return;
            }
            result(null, { id: id, ...card });
        }
    );
};

StudentCard.updateBalance = (user_id, amount, result) => {
    const query = 'UPDATE Student_Cards SET balance = balance + ? WHERE user_id = ?';
    sql.query(query, [amount, user_id], (err, res) => {
        if (err) {
            console.log('Error updating balance:', err);
            result(err, null);
            return;
        }
        if (res.affectedRows === 0) {
            result({ kind: 'not_found' }, null);
            return;
        }
        result(null, { user_id, amount });
    });
};

StudentCard.remove = (id, result) => {
    sql.query('DELETE FROM Student_Cards WHERE card_id = ?', [id], (err, res) => {
        if (err) {
            console.log('Error deleting student card:', err);
            result(err, null);
            return;
        }
        if (res.affectedRows === 0) {
            result({ kind: 'not_found' }, null);
            return;
        }
        result(null, res);
    });
};

module.exports = StudentCard;
