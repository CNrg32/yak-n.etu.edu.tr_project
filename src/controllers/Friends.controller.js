const sql = require('../config/db_config'); // Import your database configuration

// Get Friends by User ID
exports.getFriendsByUserId = (req, res) => {
    const userId = req.params.userId;

    const query = `
        SELECT 
            f.friend_user_id AS friendId,
            u.name AS friendName,
            u.email AS friendEmail,
            sc.balance AS friendBalance
        FROM friends f
        INNER JOIN users u ON f.friend_user_id = u.user_id
        LEFT JOIN student_cards sc ON sc.user_id = f.friend_user_id
        WHERE f.user_id = ?`;

    sql.query(query, [userId], (err, results) => {
        if (err) {
            console.error('Database query error:', err);
            return res.status(500).json({ message: 'Database query failed' });
        }

        if (results.length === 0) {
            return res.status(404).json({ message: 'No friends found' });
        }

        res.json(results);
    });
};

// Create a new Friend relationship
exports.create = (req, res) => {
    if (!req.body) {
        return res.status(400).send({ message: "Content cannot be empty!" });
    }

    const newFriend = {
        user_id: req.body.user_id,
        friend_user_id: req.body.friend_user_id,
    };

    sql.query("INSERT INTO friends SET ?", newFriend, (err, results) => {
        if (err) {
            console.error('Error inserting into database:', err);
            return res.status(500).json({ message: 'Failed to create friend relationship' });
        }
        res.json({ id: results.insertId, ...newFriend });
    });
};

// Get all Friend relationships
exports.findAll = (req, res) => {
    sql.query("SELECT * FROM friends", (err, results) => {
        if (err) {
            console.error('Database query error:', err);
            return res.status(500).json({ message: 'Failed to retrieve friend relationships' });
        }
        res.json(results);
    });
};

// Find a single Friend relationship by ID
exports.findOne = (req, res) => {
    const friendId = req.params.friendId;

    sql.query("SELECT * FROM friends WHERE friend_id = ?", [friendId], (err, results) => {
        if (err) {
            console.error('Database query error:', err);
            return res.status(500).json({ message: 'Failed to retrieve friend relationship' });
        }

        if (results.length === 0) {
            return res.status(404).json({ message: `No friend relationship found with ID ${friendId}` });
        }

        res.json(results[0]);
    });
};

// Update a Friend relationship by ID
exports.update = (req, res) => {
    if (!req.body) {
        return res.status(400).send({ message: "Content cannot be empty!" });
    }

    const friendId = req.params.friendId;
    const updatedFriend = {
        user_id: req.body.user_id,
        friend_user_id: req.body.friend_user_id,
    };

    sql.query(
        "UPDATE friends SET user_id = ?, friend_user_id = ? WHERE friend_id = ?",
        [updatedFriend.user_id, updatedFriend.friend_user_id, friendId],
        (err, results) => {
            if (err) {
                console.error('Database update error:', err);
                return res.status(500).json({ message: 'Failed to update friend relationship' });
            }

            if (results.affectedRows === 0) {
                return res.status(404).json({ message: `No friend relationship found with ID ${friendId}` });
            }

            res.json({ id: friendId, ...updatedFriend });
        }
    );
};

// Delete a Friend relationship by ID
exports.delete = (req, res) => {
    const friendId = req.params.friendId;

    sql.query("DELETE FROM friends WHERE friend_id = ?", [friendId], (err, results) => {
        if (err) {
            console.error('Database delete error:', err);
            return res.status(500).json({ message: 'Failed to delete friend relationship' });
        }

        if (results.affectedRows === 0) {
            return res.status(404).json({ message: `No friend relationship found with ID ${friendId}` });
        }

        res.json({ message: `Friend relationship with ID ${friendId} was successfully deleted` });
    });
};
