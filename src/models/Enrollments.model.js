const sql = require('../config/db_config');

const Enrollment = function (enrollment) {
    this.user_id = enrollment.user_id;
    this.course_id = enrollment.course_id;
};

Enrollment.create = (newEnrollment, result) => {
    sql.query("INSERT INTO Enrollments SET ?", newEnrollment, (err, res) => {
        if (err) {
            console.log("error: ", err);
            result(err, null);
            return;
        }
        result(null, { id: res.insertId, ...newEnrollment });
    });
};

Enrollment.getAll = (result) => {
    sql.query("SELECT * FROM Enrollments", (err, res) => {
        if (err) {
            console.log("error: ", err);
            result(null, err);
            return;
        }
        result(null, res);
    });
};

Enrollment.findById = (id, result) => {
    sql.query("SELECT * FROM Enrollments WHERE enrollment_id = ?", [id], (err, res) => {
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

Enrollment.updateById = (id, enrollment, result) => {
    sql.query(
        "UPDATE Enrollments SET user_id = ?, course_id = ? WHERE enrollment_id = ?",
        [enrollment.user_id, enrollment.course_id, id],
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
            result(null, { id: id, ...enrollment });
        }
    );
};

Enrollment.remove = (id, result) => {
    sql.query("DELETE FROM Enrollments WHERE enrollment_id = ?", [id], (err, res) => {
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

module.exports = Enrollment;
