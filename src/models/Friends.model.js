const sql = require('../config/db_config');

const Friend = function (friend) {
    this.user_id = friend.user_id;
    this.friend_user_id = friend.friend_user_id;
};

Friend.create = (newFriend, result) => {
    sql.query("INSERT INTO Friends SET ?", newFriend, (err, res) => {
        if (err) {
            console.log("error: ", err);
            result(err, null);
            return;
        }
        result(null, { id: res.insertId, ...newFriend });
    });
};

Friend.getAll = (result) => {
    sql.query("SELECT * FROM Friends", (err, res) => {
        if (err) {
            console.log("error: ", err);
            result(null, err);
            return;
        }
        result(null, res);
    });
};

Friend.findById = (id, result) => {
    sql.query("SELECT * FROM Friends WHERE friend_id = ?", [id], (err, res) => {
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

Friend.updateById = (id, friend, result) => {
    sql.query(
        "UPDATE Friends SET user_id = ?, friend_user_id = ? WHERE friend_id = ?",
        [friend.user_id, friend.friend_user_id, id],
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
            result(null, { id: id, ...friend });
        }
    );
};

Friend.remove = (id, result) => {
    sql.query("DELETE FROM Friends WHERE friend_id = ?", [id], (err, res) => {
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

module.exports = Friend;
