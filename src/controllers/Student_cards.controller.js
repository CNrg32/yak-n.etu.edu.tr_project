const StudentCard = require('../models/Student_Cards.model');

exports.create = (req, res) => {
    if (!req.body) {
        return res.status(400).send({ message: 'Content can not be empty!' });
    }

    const studentCard = new StudentCard({
        user_id: req.body.user_id,
        balance: req.body.balance,
    });

    StudentCard.create(studentCard, (err, data) => {
        if (err) {
            res.status(500).send({
                message: err.message || 'Error occurred while creating the StudentCard.',
            });
        } else {
            res.send(data);
        }
    });
};

exports.findAll = (req, res) => {
    StudentCard.getAll((err, data) => {
        if (err) {
            res.status(500).send({
                message: err.message || 'Error occurred while retrieving student cards.',
            });
        } else {
            res.send(data);
        }
    });
};

exports.findOne = (req, res) => {
    StudentCard.findById(req.params.cardId, (err, data) => {
        if (err) {
            if (err.kind === 'not_found') {
                res.status(404).send({
                    message: `Not found StudentCard with id ${req.params.cardId}.`,
                });
            } else {
                res.status(500).send({
                    message: 'Error retrieving StudentCard with id ' + req.params.cardId,
                });
            }
        } else {
            res.send(data);
        }
    });
};

exports.update = (req, res) => {
    if (!req.body) {
        return res.status(400).send({ message: 'Content can not be empty!' });
    }

    StudentCard.updateById(req.params.cardId, new StudentCard(req.body), (err, data) => {
        if (err) {
            if (err.kind === 'not_found') {
                res.status(404).send({
                    message: `Not found StudentCard with id ${req.params.cardId}.`,
                });
            } else {
                res.status(500).send({
                    message: 'Error updating StudentCard with id ' + req.params.cardId,
                });
            }
        } else {
            res.send(data);
        }
    });
};

exports.delete = (req, res) => {
    StudentCard.remove(req.params.cardId, (err, data) => {
        if (err) {
            if (err.kind === 'not_found') {
                res.status(404).send({
                    message: `Not found StudentCard with id ${req.params.cardId}.`,
                });
            } else {
                res.status(500).send({
                    message: 'Could not delete StudentCard with id ' + req.params.cardId,
                });
            }
        } else {
            res.send({ message: 'StudentCard was deleted successfully!' });
        }
    });
};

// Add the new balance update function
exports.updateBalance = (req, res) => {
    const { user_id, amount } = req.body;

    if (!user_id || !amount || amount <= 0) {
        return res.status(400).send({ message: 'Invalid user ID or amount' });
    }

    StudentCard.updateBalance(user_id, amount, (err, data) => {
        if (err) {
            if (err.kind === 'not_found') {
                res.status(404).send({
                    message: `Not found StudentCard with user ID ${user_id}.`,
                });
            } else {
                res.status(500).send({
                    message: 'Error updating balance for user ID ' + user_id,
                });
            }
        } else {
            res.send({ message: 'Balance updated successfully!', data });
        }
    });
};
