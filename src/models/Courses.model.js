const sql = require('../config/db_config');

const Course = function (course) {
    this.course_name = course.course_name;
    this.course_description = course.course_description;
};

Course.create = (newCourse, result) => {
    sql.query("INSERT INTO Courses SET ?", newCourse, (err, res) => {
        if (err) {
            console.log("error: ", err);
            result(err, null);
            return;
        }
        result(null, { id: res.insertId, ...newCourse });
    });
};

Course.getAll = (result) => {
    sql.query("SELECT * FROM Courses", (err, res) => {
        if (err) {
            console.log("error: ", err);
            result(null, err);
            return;
        }
        result(null, res);
    });
};

Course.findById = (id, result) => {
    sql.query("SELECT * FROM Courses WHERE course_id = ?", [id], (err, res) => {
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

Course.updateById = (id, course, result) => {
    sql.query(
        "UPDATE Courses SET course_name = ?, course_description = ? WHERE course_id = ?",
        [course.course_name, course.course_description, id],
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
            result(null, { id: id, ...course });
        }
    );
};

Course.remove = (id, result) => {
    sql.query("DELETE FROM Courses WHERE course_id = ?", [id], (err, res) => {
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

module.exports = Course;
