const CafeteriaMenu = require('../models/Cafeteria_Menu.model');

exports.create = (req, res) => {
    if (!req.body) {
        res.status(400).send({ message: "Content can not be empty!" });
    }

    const menu = new CafeteriaMenu({
        date: req.body.date,
        menu_description: req.body.menu_description
    });

    CafeteriaMenu.create(menu, (err, data) => {
        if (err)
            res.status(500).send({ message: err.message || "Some error occurred while creating the Cafeteria menu." });
        else res.send(data);
    });
};

exports.findAll = (req, res) => {
    CafeteriaMenu.getAll((err, data) => {
        if (err)
            res.status(500).send({ message: err.message || "Some error occurred while retrieving cafeteria menus." });
        else res.send(data);
    });
};

exports.findOne = (req, res) => {
    CafeteriaMenu.findById(req.params.menu_id, (err, data) => {
        if (err) {
            if (err.kind === "not_found") {
                res.status(404).send({ message: `Not found Cafeteria menu with id ${req.params.menu_id}.` });
            } else {
                res.status(500).send({ message: "Error retrieving Cafeteria menu with id " + req.params.menu_id });
            }
        } else res.send(data);
    });
};

exports.update = (req, res) => {
    if (!req.body) {
        res.status(400).send({ message: "Content can not be empty!" });
    }

    CafeteriaMenu.updateById(req.params.menu_id, new CafeteriaMenu(req.body), (err, data) => {
        if (err) {
            if (err.kind === "not_found") {
                res.status(404).send({ message: `Not found Cafeteria menu with id ${req.params.menu_id}.` });
            } else {
                res.status(500).send({ message: "Error updating Cafeteria menu with id " + req.params.menu_id });
            }
        } else res.send(data);
    });
};

exports.delete = (req, res) => {
    CafeteriaMenu.remove(req.params.menu_id, (err, data) => {
        if (err) {
            if (err.kind === "not_found") {
                res.status(404).send({ message: `Not found Cafeteria menu with id ${req.params.menu_id}.` });
            } else {
                res.status(500).send({ message: "Could not delete Cafeteria menu with id " + req.params.menu_id });
            }
        } else res.send({ message: `Cafeteria menu was deleted successfully!` });
    });
};
