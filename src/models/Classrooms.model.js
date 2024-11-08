const sql = require('../config/db_config');

const Classroom = function (classroom) {
    this.classroom_name = classroom.classroom_name;
    this.capacity = classroom.capacity;
};

Classroom.create = (newClassroom, result) => {
    sql.query("INSERT INTO Classrooms SET ?", newClassroom, (err, res) => {
        if (err) {
            console.log("error: ", err);
            result(err, null);
            return;
        }
        result(null, { id: res.insertId, ...newClassroom });
    });
};

Classroom.getAll = (result) => {
    sql.query("SELECT * FROM Classrooms", (err, res) => {
        if (err) {
            console.log("error: ", err);
            result(null, err);
            return;
        }
        result(null, res);
    });
};

Classroom.findById = (id, result) => {
    sql.query("SELECT * FROM Classrooms WHERE classroom_id = ?", [id], (err, res) => {
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

Classroom.updateById = (id, classroom, result) => {
    sql.query(
        "UPDATE Classrooms SET classroom_name = ?, capacity = ? WHERE classroom_id = ?",
        [classroom.classroom_name, classroom.capacity, id],
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
            result(null, { id: id, ...classroom });
        }
    );
};

Classroom.remove = (id, result) => {
    sql.query("DELETE FROM Classrooms WHERE classroom_id = ?", [id], (err, res) => {
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

module.exports = Classroom;
