const User = require('../models/users.model');

exports.create = (req, res) => {
    if (!req.body) {
        res.status(400).send({ message: "Content can not be empty!" });
    }

    const user = new User({
        email: req.body.email,
        password_hash: req.body.password_hash,
        name: req.body.name,
        contact_details: req.body.contact_details
    });

    User.create(user, (err, data) => {
        if (err)
            res.status(500).send({ message: err.message || "Some error occurred while creating the User." });
        else res.send(data);
    });
};

exports.findAll = (req, res) => {
    User.getAll((err, data) => {
        if (err)
            res.status(500).send({ message: err.message || "Some error occurred while retrieving users." });
        else res.send(data);
    });
};

exports.findOne = (req, res) => {
    User.findById(req.params.user_id, (err, data) => {
        if (err) {
            if (err.kind === "not_found") {
                res.status(404).send({ message: `Not found User with id ${req.params.user_id}.` });
            } else {
                res.status(500).send({ message: "Error retrieving User with id " + req.params.user_id });
            }
        } else res.send(data);
    });
};

exports.update = (req, res) => {
    if (!req.body) {
        res.status(400).send({ message: "Content can not be empty!" });
    }

    User.updateById(req.params.user_id, new User(req.body), (err, data) => {
        if (err) {
            if (err.kind === "not_found") {
                res.status(404).send({ message: `Not found User with id ${req.params.user_id}.` });
            } else {
                res.status(500).send({ message: "Error updating User with id " + req.params.user_id });
            }
        } else res.send(data);
    });
};

exports.delete = (req, res) => {
    User.remove(req.params.user_id, (err, data) => {
        if (err) {
            if (err.kind === "not_found") {
                res.status(404).send({ message: `Not found User with id ${req.params.user_id}.` });
            } else {
                res.status(500).send({ message: "Could not delete User with id " + req.params.user_id });
            }
        } else res.send({ message: `User was deleted successfully!` });
    });
};
