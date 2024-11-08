const Classroom = require('../models/classroom.model');

exports.create = (req, res) => {
    if (!req.body) {
        res.status(400).send({ message: "Content can not be empty!" });
    }

    const classroom = new Classroom({
        room_name: req.body.room_name,
        is_empty: req.body.is_empty
    });

    Classroom.create(classroom, (err, data) => {
        if (err)
            res.status(500).send({ message: err.message || "Some error occurred while creating the Classroom." });
        else res.send(data);
    });
};

exports.findAll = (req, res) => {
    Classroom.getAll((err, data) => {
        if (err)
            res.status(500).send({ message: err.message || "Some error occurred while retrieving classrooms." });
        else res.send(data);
    });
};

exports.findOne = (req, res) => {
    Classroom.findById(req.params.classroom_id, (err, data) => {
        if (err) {
            if (err.kind === "not_found") {
                res.status(404).send({ message: `Not found Classroom with id ${req.params.classroom_id}.` });
            } else {
                res.status(500).send({ message: "Error retrieving Classroom with id " + req.params.classroom_id });
            }
        } else res.send(data);
    });
};

exports.update = (req, res) => {
    if (!req.body) {
        res.status(400).send({ message: "Content can not be empty!" });
    }

    Classroom.updateById(req.params.classroom_id, new Classroom(req.body), (err, data) => {
        if (err) {
            if (err.kind === "not_found") {
                res.status(404).send({ message: `Not found Classroom with id ${req.params.classroom_id}.` });
            } else {
                res.status(500).send({ message: "Error updating Classroom with id " + req.params.classroom_id });
            }
        } else res.send(data);
    });
};

exports.delete = (req, res) => {
    Classroom.remove(req.params.classroom_id, (err, data) => {
        if (err) {
            if (err.kind === "not_found") {
                res.status(404).send({ message: `Not found Classroom with id ${req.params.classroom_id}.` });
            } else {
                res.status(500).send({ message: "Could not delete Classroom with id " + req.params.classroom_id });
            }
        } else res.send({ message: `Classroom was deleted successfully!` });
    });
};
