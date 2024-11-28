module.exports = app => {
    const courses = require('../controllers/Courses.controller');

    // Define the routes for courses
    app.post('/courses', courses.create);              // Create a new course
    app.get('/courses', courses.findAll);              // Get all courses
    app.get('/courses/:courseId', courses.findOne);    // Get a course by ID
    app.put('/courses/:courseId', courses.update);     // Update a course by ID
    app.delete('/courses/:courseId', courses.delete);  // Delete a course by ID
};
