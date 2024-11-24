module.exports = app => {
    const enrollments = require('../controllers/enrollments.controller');

    // Create a new enrollment
    app.post('/enrollments', enrollments.create);

    // Get all enrollments
    app.get('/enrollments', enrollments.findAll);

    // Get a single enrollment by ID
    app.get('/enrollments/:enrollmentId', enrollments.findOne);

    // Update an enrollment by ID
    app.put('/enrollments/:enrollmentId', enrollments.update);

    // Delete an enrollment by ID
    app.delete('/enrollments/:enrollmentId', enrollments.delete);
};
