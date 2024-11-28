const Enrollment = require('../models/enrollments.model');

// Create a new enrollment
exports.create = (req, res) => {
    if (!req.body) {
        res.status(400).send({ message: 'Content cannot be empty!' });
        return;
    }

    const enrollment = new Enrollment({
        user_id: req.body.user_id,
        course_id: req.body.course_id
    });

    Enrollment.create(enrollment, (err, data) => {
        if (err) {
            res.status(500).send({
                message: err.message || 'Some error occurred while creating the enrollment.'
            });
        } else {
            res.send(data);
        }
    });
};

// Get all enrollments
exports.findAll = (req, res) => {
    Enrollment.getAll((err, data) => {
        if (err) {
            res.status(500).send({
                message: err.message || 'Some error occurred while retrieving enrollments.'
            });
        } else {
            res.send(data);
        }
    });
};

// Get a single enrollment by ID
exports.findOne = (req, res) => {
    Enrollment.findById(req.params.enrollmentId, (err, data) => {
        if (err) {
            if (err.kind === 'not_found') {
                res.status(404).send({
                    message: `Enrollment with ID ${req.params.enrollmentId} not found.`
                });
            } else {
                res.status(500).send({
                    message: `Error retrieving enrollment with ID ${req.params.enrollmentId}.`
                });
            }
        } else {
            res.send(data);
        }
    });
};

// Update an enrollment by ID
exports.update = (req, res) => {
    if (!req.body) {
        res.status(400).send({ message: 'Content cannot be empty!' });
        return;
    }

    Enrollment.updateById(
        req.params.enrollmentId,
        new Enrollment(req.body),
        (err, data) => {
            if (err) {
                if (err.kind === 'not_found') {
                    res.status(404).send({
                        message: `Enrollment with ID ${req.params.enrollmentId} not found.`
                    });
                } else {
                    res.status(500).send({
                        message: `Error updating enrollment with ID ${req.params.enrollmentId}.`
                    });
                }
            } else {
                res.send(data);
            }
        }
    );
};

// Delete an enrollment by ID
exports.delete = (req, res) => {
    Enrollment.remove(req.params.enrollmentId, (err, data) => {
        if (err) {
            if (err.kind === 'not_found') {
                res.status(404).send({
                    message: `Enrollment with ID ${req.params.enrollmentId} not found.`
                });
            } else {
                res.status(500).send({
                    message: `Could not delete enrollment with ID ${req.params.enrollmentId}.`
                });
            }
        } else {
            res.send({ message: 'Enrollment was deleted successfully!' });
        }
    });
};
