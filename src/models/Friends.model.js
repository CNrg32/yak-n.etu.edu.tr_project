const sql = require('../config/db_config'); // Import your database configuration

const Friends = function (friend) {
    this.user_id = friend.user_id;
    this.friend_user_id = friend.friend_user_id;
};

// Create a new Friend relationship
Friends.create = (newFriend, result) => {
    sql.query("INSERT INTO friends SET ?", newFriend, (err, res) => {
        if (err) {
            console.error('Error inserting into database:', err);
            result(err, null);
            return;
        }
        result(null, { id: res.insertId, ...newFriend });
    });
};

// Get all Friend relationships
Friends.getAll = (result) => {
    sql.query("SELECT * FROM friends", (err, res) => {
        if (err) {
            console.error('Database query error:', err);
            result(null, err);
            return;
        }
        result(null, res);
    });
};

// Find a Friend relationship by ID
Friends.findById = (id, result) => {
    sql.query("SELECT * FROM friends WHERE friend_id = ?", [id], (err, res) => {
        if (err) {
            console.error('Database query error:', err);
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

// Update a Friend relationship by ID
Friends.updateById = (id, friend, result) => {
    sql.query(
        "UPDATE friends SET user_id = ?, friend_user_id = ? WHERE friend_id = ?",
        [friend.user_id, friend.friend_user_id, id],
        (err, res) => {
            if (err) {
                console.error('Database update error:', err);
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

// Delete a Friend relationship by ID
Friends.remove = (id, result) => {
    sql.query("DELETE FROM friends WHERE friend_id = ?", [id], (err, res) => {
        if (err) {
            console.error('Database delete error:', err);
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

module.exports = Friends;
