const Course = require('../models/Courses.model');

exports.create = (req, res) => {
    if (!req.body) {
        return res.status(400).send({ message: "Content cannot be empty!" });
    }

    const course = new Course({
        course_name: req.body.course_name,
        course_description: req.body.course_description
    });

    Course.create(course, (err, data) => {
        if (err) {
            res.status(500).send({ message: err.message || "Some error occurred while creating the course." });
        } else {
            res.send(data);
        }
    });
};

exports.findAll = (req, res) => {
    Course.getAll((err, data) => {
        if (err) {
            res.status(500).send({ message: err.message || "Some error occurred while retrieving courses." });
        } else {
            res.send(data);
        }
    });
};

exports.findOne = (req, res) => {
    Course.findById(req.params.courseId, (err, data) => {
        if (err) {
            if (err.kind === "not_found") {
                res.status(404).send({ message: `Course with ID ${req.params.courseId} not found.` });
            } else {
                res.status(500).send({ message: `Error retrieving course with ID ${req.params.courseId}.` });
            }
        } else {
            res.send(data);
        }
    });
};

exports.update = (req, res) => {
    if (!req.body) {
        return res.status(400).send({ message: "Content cannot be empty!" });
    }

    Course.updateById(req.params.courseId, new Course(req.body), (err, data) => {
        if (err) {
            if (err.kind === "not_found") {
                res.status(404).send({ message: `Course with ID ${req.params.courseId} not found.` });
            } else {
                res.status(500).send({ message: `Error updating course with ID ${req.params.courseId}.` });
            }
        } else {
            res.send(data);
        }
    });
};

exports.delete = (req, res) => {
    Course.remove(req.params.courseId, (err, data) => {
        if (err) {
            if (err.kind === "not_found") {
                res.status(404).send({ message: `Course with ID ${req.params.courseId} not found.` });
            } else {
                res.status(500).send({ message: `Could not delete course with ID ${req.params.courseId}.` });
            }
        } else {
            res.send({ message: "Course was deleted successfully!" });
        }
    });
};
