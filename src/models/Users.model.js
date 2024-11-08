const sql = require('../config/db_config');

const User = function (user) {
    this.email = user.email;
    this.password_hash = user.password_hash;
    this.name = user.name;
    this.contact_details = user.contact_details;
};

User.create = (newUser, result) => {
    sql.query("INSERT INTO Users SET ?", newUser, (err, res) => {
        if (err) {
            console.log("error: ", err);
            result(err, null);
            return;
        }
        result(null, { id: res.insertId, ...newUser });
    });
};

User.getAll = (result) => {
    sql.query("SELECT * FROM Users", (err, res) => {
        if (err) {
            console.log("error: ", err);
            result(null, err);
            return;
        }
        result(null, res);
    });
};

User.findById = (id, result) => {
    sql.query("SELECT * FROM Users WHERE user_id = ?", [id], (err, res) => {
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

User.updateById = (id, user, result) => {
    sql.query(
        "UPDATE Users SET email = ?, password_hash = ?, name = ?, contact_details = ? WHERE user_id = ?",
        [user.email, user.password_hash, user.name, user.contact_details, id],
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
            result(null, { id: id, ...user });
        }
    );
};

User.remove = (id, result) => {
    sql.query("DELETE FROM Users WHERE user_id = ?", [id], (err, res) => {
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

module.exports = User;
