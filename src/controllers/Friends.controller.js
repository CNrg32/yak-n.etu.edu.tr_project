const Friend = require('../models/friend.model');

exports.create = (req, res) => {
    if (!req.body) {
        res.status(400).send({ message: "Content can not be empty!" });
    }

    const friend = new Friend({
        user_id: req.body.user_id,
        friend_user_id: req.body.friend_user_id
    });

    Friend.create(friend, (err, data) => {
        if (err)
            res.status(500).send({ message: err.message || "Some error occurred while creating the Friend relationship." });
        else res.send(data);
    });
};

exports.findAll = (req, res) => {
    Friend.getAll((err, data) => {
        if (err)
            res.status(500).send({ message: err.message || "Some error occurred while retrieving friends." });
        else res.send(data);
    });
};

exports.findOne = (req, res) => {
    Friend.findById(req.params.friend_id, (err, data) => {
        if (err) {
            if (err.kind === "not_found") {
                res.status(404).send({ message: `Not found Friend relationship with id ${req.params.friend_id}.` });
            } else {
                res.status(500).send({ message: "Error retrieving Friend relationship with id " + req.params.friend_id });
            }
        } else res.send(data);
    });
};

exports.update = (req, res) => {
    if (!req.body) {
        res.status(400).send({ message: "Content can not be empty!" });
    }

    Friend.updateById(req.params.friend_id, new Friend(req.body), (err, data) => {
        if (err) {
            if (err.kind === "not_found") {
                res.status(404).send({ message: `Not found Friend relationship with id ${req.params.friend_id}.` });
            } else {
                res.status(500).send({ message: "Error updating Friend relationship with id " + req.params.friend_id });
            }
        } else res.send(data);
    });
};

exports.delete = (req, res) => {
    Friend.remove(req.params.friend_id, (err, data) => {
        if (err) {
            if (err.kind === "not_found") {
                res.status(404).send({ message: `Not found Friend relationship with id ${req.params.friend_id}.` });
            } else {
                res.status(500).send({ message: "Could not delete Friend relationship with id " + req.params.friend_id });
            }
        } else res.send({ message: `Friend relationship was deleted successfully!` });
    });
};
