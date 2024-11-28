module.exports = (app) => {
    const friends = require('../controllers/Friends.controller');

    // Get friends by user ID
    app.get('/friends/:userId', friends.getFriendsByUserId);

    // Create a new friend relationship
    app.post('/friends', friends.create);

    // Get all friend relationships
    app.get('/friends', friends.findAll);

    // Delete a friend relationship by friend ID
    app.delete('/friends/:friendId', friends.delete);
};
