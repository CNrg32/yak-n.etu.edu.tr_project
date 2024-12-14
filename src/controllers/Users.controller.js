const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');
const User = require('../models/users.model');

// Create a new user
exports.create = async (req, res) => {
    if (!req.body.email || !req.body.password || !req.body.name) {
        return res.status(400).send({ message: "Email, password, and name are required!" });
    }

    try {
        console.log("Raw Password:", req.body.password);

        const hashedPassword = await bcrypt.hash(req.body.password, 10);

        console.log("Hashed Password:", hashedPassword);

        const user = new User({
            email: req.body.email,
            password_hash: hashedPassword,
            name: req.body.name,
            contact_details: req.body.contact_details || null,
        });

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

// Login functionality
exports.login = async (req, res) => {
    const { email, password } = req.body;

    if (!email || !password) {
        return res.status(400).send({ message: 'Email and password are required!' });
    }

    User.findByEmail(email, async (err, user) => {
        if (err || !user) {
            return res.status(404).send({ message: 'User not found!' });
        }

        const isPasswordValid = await bcrypt.compare(password, user.password_hash);
        if (!isPasswordValid) {
            return res.status(401).send({ message: 'Invalid credentials!' });
        }

        const token = jwt.sign({ id: user.user_id }, process.env.JWT_SECRET, {
            expiresIn: '1h',
        });

        res.send({ token, user });
    });
};

// Fetch all users with balance
exports.findAllWithBalance = (req, res) => {
    console.log("Fetching all users with balances...");
    User.getAllWithBalance((err, data) => {
        if (err) {
            console.error("Error fetching users with balances:", err);
            res.status(500).send({
                message: err.message || "Error occurred while retrieving users with balances.",
            });
        } else {
            console.log("Users fetched successfully:", data);
            res.send(data);
        }
    });
};

// Fetch all users
exports.findAll = (req, res) => {
    User.getAll((err, data) => {
        if (err) {
            res.status(500).send({ message: err.message || "Some error occurred while retrieving users." });
        } else {
            res.send(data);
        }
    });
};

// Fetch a single user by ID
exports.findOne = (req, res) => {
    User.findById(req.params.user_id, (err, data) => {
        if (err) {
            if (err.kind === "not_found") {
                res.status(404).send({ message: `Not found User with id ${req.params.user_id}.` });
            } else {
                res.status(500).send({ message: "Error retrieving User with id " + req.params.user_id });
            }
        } else {
            res.send(data);
        }
    });
};

// Update a user by ID
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
        } else {
            res.send(data);
        }
    });
};

// Delete a user by ID
exports.delete = (req, res) => {
    User.remove(req.params.user_id, (err, data) => {
        if (err) {
            if (err.kind === "not_found") {
                res.status(404).send({ message: `Not found User with id ${req.params.user_id}.` });
            } else {
                res.status(500).send({ message: "Could not delete User with id " + req.params.user_id });
            }
        } else {
            res.send({ message: `User was deleted successfully!` });
        }
    });
};
