const Enrollment = require('../models/enrollments.model');

// Yeni bir kayıt (enrollment) oluştur
exports.create = (req, res) => {
    if (!req.body) {
        res.status(400).send({
            message: "İçerik boş olamaz!"
        });
        return;
    }

    const enrollment = new Enrollment({
        user_id: req.body.user_id,
        course_id: req.body.course_id
    });

    Enrollment.create(enrollment, (err, data) => {
        if (err)
            res.status(500).send({
                message: err.message || "Yeni kayıt oluşturulurken bir hata oluştu."
            });
        else res.send(data);
    });
};

// Tüm kayıtları getir
exports.findAll = (req, res) => {
    Enrollment.getAll((err, data) => {
        if (err)
            res.status(500).send({
                message: err.message || "Kayıtları alırken bir hata oluştu."
            });
        else res.send(data);
    });
};

// ID ile tek bir kaydı bul
exports.findOne = (req, res) => {
    Enrollment.findById(req.params.id, (err, data) => {
        if (err) {
            if (err.kind === "not_found") {
                res.status(404).send({
                    message: `ID'si ${req.params.id} olan kayıt bulunamadı.`
                });
            } else {
                res.status(500).send({
                    message: `ID'si ${req.params.id} olan kaydı alırken hata oluştu.`
                });
            }
        } else res.send(data);
    });
};

// ID ile bir kaydı güncelle
exports.update = (req, res) => {
    if (!req.body) {
        res.status(400).send({
            message: "İçerik boş olamaz!"
        });
        return;
    }

    Enrollment.updateById(
        req.params.id,
        new Enrollment(req.body),
        (err, data) => {
            if (err) {
                if (err.kind === "not_found") {
                    res.status(404).send({
                        message: `ID'si ${req.params.id} olan kayıt bulunamadı.`
                    });
                } else {
                    res.status(500).send({
                        message: `ID'si ${req.params.id} olan kaydı güncellerken hata oluştu.`
                    });
                }
            } else res.send(data);
        }
    );
};

// ID ile bir kaydı sil
exports.delete = (req, res) => {
    Enrollment.remove(req.params.id, (err, data) => {
        if (err) {
            if (err.kind === "not_found") {
                res.status(404).send({
                    message: `ID'si ${req.params.id} olan kayıt bulunamadı.`
                });
            } else {
                res.status(500).send({
                    message: `ID'si ${req.params.id} olan kaydı silerken hata oluştu.`
                });
            }
        } else res.send({ message: "Kayıt başarıyla silindi!" });
    });
};
