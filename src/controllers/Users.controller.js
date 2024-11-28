

const bcrypt = require('bcrypt');
const User = require('../models/users.model');

exports.create = async (req, res) => {
    if (!req.body.email || !req.body.password || !req.body.name) {
        return res.status(400).send({ message: "Email, password, and name are required!" });
    }

    try {
        // Log raw password
        console.log("Raw Password:", req.body.password);

        // Hash the password using bcrypt
        const hashedPassword = await bcrypt.hash(req.body.password, 10);

        // Log hashed password
        console.log("Hashed Password:", hashedPassword);

        // Create a new user object
        const user = new User({
            email: req.body.email,
            password_hash: hashedPassword, // Use hashed password
            name: req.body.name,
            contact_details: req.body.contact_details || null,
        });

        // Save the user to the database
        User.create(user, (err, data) => {
            if (err) {
                console.error("Error during User.create:", err);
                res.status(500).send({
                    message: err.message || "Some error occurred while creating the user.",
                });
            } else {
                res.status(201).send({ message: "User created successfully!", user: data });
            }
        });
    } catch (error) {
        console.error("Error during user creation:", error);
        res.status(500).send({ message: "Internal server error." });
    }
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
