const StudentCard = require('../models/student_card.model');

exports.create = (req, res) => {
    if (!req.body) {
        res.status(400).send({ message: "Content can not be empty!" });
    }

    const studentCard = new StudentCard({
        user_id: req.body.user_id,
        balance: req.body.balance
    });

    StudentCard.create(studentCard, (err, data) => {
        if (err)
            res.status(500).send({ message: err.message || "Some error occurred while creating the StudentCard." });
        else res.send(data);
    });
};

exports.findAll = (req, res) => {
    StudentCard.getAll((err, data) => {
        if (err)
            res.status(500).send({ message: err.message || "Some error occurred while retrieving student cards." });
        else res.send(data);
    });
};

// Other functions will follow the similar CRUD pattern for other tables.
