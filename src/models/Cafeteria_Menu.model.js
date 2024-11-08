const sql = require('../config/db_config');

const CafeteriaMenu = function (menu) {
    this.date = menu.date;
    this.menu_description = menu.menu_description;
};

CafeteriaMenu.create = (newMenu, result) => {
    sql.query("INSERT INTO Cafeteria_Menu SET ?", newMenu, (err, res) => {
        if (err) {
            console.log("error: ", err);
            result(err, null);
            return;
        }
        result(null, { id: res.insertId, ...newMenu });
    });
};

CafeteriaMenu.getAll = (result) => {
    sql.query("SELECT * FROM Cafeteria_Menu", (err, res) => {
        if (err) {
            console.log("error: ", err);
            result(null, err);
            return;
        }
        result(null, res);
    });
};

CafeteriaMenu.findById = (id, result) => {
    sql.query("SELECT * FROM Cafeteria_Menu WHERE menu_id = ?", [id], (err, res) => {
        if (err) {
            console.log("error: ", err);
            result(err, null);
            return;
        }
        if (res.length) {
            result(null, res[0]);
            return;
        }
        result({ kind: "not_found" }, null);
    });
};

CafeteriaMenu.updateById = (id, menu, result) => {
    sql.query(
        "UPDATE Cafeteria_Menu SET date = ?, menu_description = ? WHERE menu_id = ?",
        [menu.date, menu.menu_description, id],
        (err, res) => {
            if (err) {
                console.log("error: ", err);
                result(err, null);
                return;
            }
            if (res.affectedRows == 0) {
                result({ kind: "not_found" }, null);
                return;
            }
            result(null, { id: id, ...menu });
        }
    );
};

CafeteriaMenu.remove = (id, result) => {
    sql.query("DELETE FROM Cafeteria_Menu WHERE menu_id = ?", [id], (err, res) => {
        if (err) {
            console.log("error: ", err);
            result(err, null);
            return;
        }
        if (res.affectedRows == 0) {
            result({ kind: "not_found" }, null);
            return;
        }
        result(null, res);
    });
};

module.exports = CafeteriaMenu;
