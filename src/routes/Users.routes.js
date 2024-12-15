module.exports = app => {
    const users = require('../controllers/users.controller');

    app.post('/users/login', users.login); // Login endpoint
    app.post('/users', users.create);      // Create user
    app.get('/users', users.findAll);      // Fetch all users
    app.get('/users/with-balance', users.findAllWithBalance); // Users with balance
    app.get('/users/:userId', users.findOne); // Fetch user by ID
    app.put('/users/:userId', users.update);  // Update user
    app.delete('/users/:userId', users.delete); // Delete user
};
