const Course = require('../models/courses.model');

exports.create = (req, res) => {
    if (!req.body) {
        res.status(400).send({ message: "Content can not be empty!" });
    }

    const course = new Course({
        course_name: req.body.course_name,
        course_description: req.body.course_description
    });

    Course.create(course, (err, data) => {
        if (err)
            res.status(500).send({ message: err.message || "Some error occurred while creating the Course." });
        else res.send(data);
    });
};

exports.findAll = (req, res) => {
    Course.getAll((err, data) => {
        if (err)
            res.status(500).send({ message: err.message || "Some error occurred while retrieving courses." });
        else res.send(data);
    });
};

exports.findOne = (req, res) => {
    Course.findById(req.params.course_id, (err, data) => {
        if (err) {
            if (err.kind === "not_found") {
                res.status(404).send({ message: `Not found Course with id ${req.params.course_id}.` });
            } else {
                res.status(500).send({ message: "Error retrieving Course with id " + req.params.course_id });
            }
        } else res.send(data);
    });
};

exports.update = (req, res) => {
    if (!req.body) {
        res.status(400).send({ message: "Content can not be empty!" });
    }

    Course.updateById(req.params.course_id, new Course(req.body), (err, data) => {
        if (err) {
            if (err.kind === "not_found") {
                res.status(404).send({ message: `Not found Course with id ${req.params.course_id}.` });
            } else {
                res.status(500).send({ message: "Error updating Course with id " + req.params.course_id });
            }
        } else res.send(data);
    });
};

exports.delete = (req, res) => {
    Course.remove(req.params.course_id, (err, data) => {
        if (err) {
            if (err.kind === "not_found") {
                res.status(404).send({ message: `Not found Course with id ${req.params.course_id}.` });
            } else {
                res.status(500).send({ message: "Could not delete Course with id " + req.params.course_id });
            }
        } else res.send({ message: `Course was deleted successfully!` });
    });
};
